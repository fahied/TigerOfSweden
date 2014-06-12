//
//  ViewController.m
//  TigerOfSweden
//
//  Created by Muhammad Fahied on 11/06/14.
//  Copyright (c) 2014 Muhammad Fahied. All rights reserved.
//

#define SampleData @{@"id":@2, @"sku":@"randomString", @"productName":@"Polo shirt",@"brandName":@"dressman", @"image":@"http://cdn.varner.eu/Global/Dressmann/Collection/2014_spring_summer/7115627_950_3.jpg.transform?w=300&cp=true:",@"price":@300, @"procductPage":@"http://dressmann.com/no/Produkter/Collection/Dresser/Wool-stretch-grey-check_7115627_950/"}



#import "ProductsViewController.h"
#import "RestFullManager.h"
#import <UIScrollView+SVPullToRefresh.h>
#import <UIScrollView+SVInfiniteScrolling.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "WebViewController.h"


#import "AppConstants.h"
#import "ProductTableViewCell.h"





static int initialProductID = 1; // product ID to start from 1, depends on your api
static int productCount = 50; // product ID to start from 1, depends on your api

@interface ProductsViewController ()

// to keep track of what is the next intial product ID to load
@property (nonatomic, assign) int currentLastProductID;
// to keep the objects GET from server
@property (nonatomic, strong) NSMutableArray *productList;

@property (nonatomic, strong) NSMutableArray *filteredProductList;


@end

@implementation ProductsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    self.productList = [NSMutableArray new];
    self.filteredProductList = [@[]mutableCopy];
    self.searchBar.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    // refresh new data when pull the table list
    [self.tableView addPullToRefreshWithActionHandler:^{
        weakSelf.currentLastProductID = initialProductID; // reset the product ID
        [weakSelf.productList removeAllObjects]; // remove all data
        [weakSelf.tableView reloadData]; // before load new content, clear the existing table list
        [weakSelf loadFromServer]; // load new data
        [weakSelf.tableView.pullToRefreshView stopAnimating]; // clear the animation
        
        // once refresh, allow the infinite scroll again
        weakSelf.tableView.showsInfiniteScrolling = YES;
    }];
    
    // load more content when scroll to the bottom most
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadFromServer];
    }];
    
    //for testing
    [self.productList addObject:SampleData];
    _filteredProductList = [_productList mutableCopy];
    [self.tableView reloadData];
}


- (void)loadFromServer
{
    // check if internet is not available, show error message
    if (![self connected])
    {
     [[[UIAlertView alloc]initWithTitle:@"Offline!" message:@"Internet connection is not available, Please try later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    // if network is available, make GET request to server to fetch data
    NSString *route = [NSString stringWithFormat:@"/products/?frome=%d&count=%d", _currentLastProductID,productCount];
    [RestFullManager getJsonWhereRoute:route prams:nil completion:^(NSError *error, id json) {
        
        if (error) {
            self.tableView.showsInfiniteScrolling = NO;
            [[[UIAlertView alloc]initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            NSLog(@"error %@", error);
            return;
        }
        
        // if no more result
            if ([[json objectForKey:@"items"] count] == 0) {
                self.tableView.showsInfiniteScrolling = NO; // stop the infinite scroll
                return;
            }
        self.currentLastProductID+=[[json objectForKey:@"items"] count]; // increase the product count
        int currentRow = [self.productList count]; // keep the the index of last row before add new items into the list
        
        // store the items into the existing list
        for (id obj in [json valueForKey:@"items"]) {
            [self.productList addObject:obj];
        }
        self.filteredProductList = [self.productList mutableCopy];
        
        [self reloadTableView:currentRow];
        
        // clear the pull to refresh & infinite scroll, this 2 lines very important
        [self.tableView.pullToRefreshView stopAnimating];
        [self.tableView.infiniteScrollingView stopAnimating];
        
    }];
}



- (void)reloadTableView:(int)startingRow;
{
    // the last row after added new items
    int endingRow = [_productList count];
    
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (; startingRow < endingRow; startingRow++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:startingRow inSection:0]];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showWebView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Assume self.view is the table view
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    id item = [_filteredProductList objectAtIndex:indexPath.row];
    
    NSString *productPage = [item valueForKey:@"procductPage"];

    [(WebViewController*)segue.destinationViewController setPageUrlString:productPage];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_filteredProductList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"productCell";
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // minus 1 because the first row is the search bar
    id item = [_filteredProductList objectAtIndex:indexPath.row];
    
    cell.productNameLabel.text = [item valueForKey:@"productName"];
    
    //set product image
    [cell.largeImageView setImageWithURL:[NSURL URLWithString:[item valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)connected
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}


// called when text changes (including clear)
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // Update the filtered array based on the search text and scope.
    
    if ([searchText length] == 0) {
        
        _filteredProductList = [_productList mutableCopy];
        // [self.tableview performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        [self.tableView reloadData];
        return;
    }
    else if([searchText length] > 0)
    {
        // Remove all objects from the filtered search array
        [_filteredProductList removeAllObjects];
        // Filter the array using NSPredicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.productName contains[c] %@) || (SELF.brandName contains[c] %@) ", searchText,searchText];
        _filteredProductList = [[_productList filteredArrayUsingPredicate:predicate]mutableCopy];
        
        [self.tableView reloadData];
    }
}



@end
