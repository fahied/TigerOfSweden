# TigerOfSweden
=============

## 1. Consuming APIs with style

Create a simple app (min iOS version: 6) able to consume a JSON API (`/products/`) returning a list of objects as follows:

``` javascript
{
	id: <int>,
	sku: <string>,
	productName: <string>,
	brandName: <string>,
        image: <url>
	price: <int>
	productPage: <url>
}
```

The API accepts 2 params: 

* `from`: a product ID to start from
* `count`: how many products my consumer wants to retrieve

For example:

```
/produts/?from=100&count=50
```

You app should:

* consume the API displaying it with an infinite scrolling mechanism
* persist the objects in a cache used when the app is started/restarted
* when a table row is tapped it will open the product's details (productPage url) in a webview

Also: the opened webpage might send a message to the app by setting its location to:

```
customURL://?message=<string>
```

* catch that message and display it.
