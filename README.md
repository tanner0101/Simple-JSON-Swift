Beautifully Simple JSON in Swift
================================

This is a lovely way of dealing with JSON in Swift that I have come up with from reading various articles across the internet. It allows you to take JSON data in from an API and easily map it onto your custom Swift classes.

It's as simple as this:

```swift
let listings: [Listings] = JSON.getParsedArray(data)
```

Don't believe me? Read on...

Getting the data
================

Here is the complete code you would need to get the data from a real server

```swift
let request = NSURLRequest(URL: NSURL(string: "https://api.example.com/v1/listings"))
NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in {
	let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil)
	if let array = json as [AnyObject]? {
		let listings: [Listings] = JSON.getParsedArray(array)
	} else {
		println("JSON was not an array as expected")
	}
}

```

What is this magical JSON class?
================================

So the magical JSON class is not as complicated as it may seem, the core functions are these:

```swift
class func getParsedArray<T: Parsable>(array: [AnyObject]) -> [T] {
    var parsedArray = [T]()
    for dictionary in array {
        let dictionary = dictionary as [String: AnyObject]
        let parsedDictionary: T = self.getParsedDictionary(dictionary)
        parsedArray.append(parsedObject)
    }
    return parsedArray
}
 ```

 ```swift
class func getParsedDictionary<T: Parsable>(dictionary: [String: AnyObject]) -> T {
    let parsedDictionary = T(dictionary: dictionary)
    return parsedDictionary
}
```

Protocol: Parsable
==================

The only hard part is making sure your Swift classes conform to the parsable protocol. Even then, this is super easy with a couple of helper functions from the JSON class

```swift
protocol Parsable {
    init(dictionary: [String: AnyObject])
}
```

The parsable conforming listing class

```swift
class Listing: Parsable {
    var name: String?
    
    required init(dictionary: [String: AnyObject]) {
        self.name = JSON.getString(dictionary, key: "name")
    }
}
```

The helper function for getting a string

```swift
class func getString(json: [String: AnyObject]?, key: String) -> String? {
    let maybeString: AnyObject? = json?[key]
    return maybeString as? String
}
```

That's it!

- Tanner
