![GitHub Workflow Status (with event)](https://img.shields.io/github/actions/workflow/status/lorenalexm/StrapiSwiftCross/tests.yml)
![Codecov](https://img.shields.io/codecov/c/github/lorenalexm/StrapiSwiftCross)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/lorenalexm/StrapiSwiftCross)
![Swift Version 5.8](https://badgen.net/static/Swift/5.8/orange)
![GitHub](https://img.shields.io/github/license/lorenalexm/StrapiSwiftCross)
<a href="https://www.buymeacoffee.com/roniemartinez" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="21" width="87"></a>


# StrapiSwiftCross
This project builds a binding around the Strapi API to ease the communication between your Swift project and the Strapi backend; attempting to eliminate the need to write any `URLSession` code yourself.


## Tech Stack
Swift 5.8, XCTest, Swift DocC, [Mocker](https://github.com/WeTransfer/Mocker) (For the test suite only)


## [Documentation](https://lorenalexm.github.io/StrapiSwiftCross/documentation/strapiswiftcross/)
The Swift DocC generated [documentation](https://lorenalexm.github.io/StrapiSwiftCross/documentation/strapiswiftcross/) is hosted on GitHub Pages. I have tried to provide fairly detailed documentation comments throughout and examples below, this should hopefully be enough to get up and running.



## Installation
Add the `StrapiSwiftCross` library to your `Package.swift` file as you would any other library. There is no support for CocoaPods or Carthage, if this is something you need feel free to open a pull request!

```swift
// swift-tools-version:5.8
import PackageDescription

let package = Package(
    name: "Example",
    products: [
        .library(name: "Example", targets: ["Example"]),
    ],
    dependencies: [
        .package(url: "https://github.com/lorenalexm/StrapiSwiftCross.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "Example",
            dependencies: ["StrapiSwiftCross"]),
        .testTarget(
            name: "ExampleTests",
            dependencies: ["Example"]),
    ]
)
```


## Usage/Examples
Basic example of querying a `posts` resource from Strapi.
```swift
import StrapiSwiftCross

let strapi = Strapi(host: "http://localhost:1337/api")
let request = QueryRequest("posts")
let result = try? await strapi.execute(request)
print(result)
```

Example of querying and filtering a `posts` example resource from Strapi.
```swift
import StrapiSwiftCross

let strapi = Strapi(host: "http://localhost:1337/api")
let request = QueryRequest("posts")
request.addFilter(type: .greaterThan, onField: "viewCount", forValue: 500)
let result = try? await strapi.execute(request)
print(result)
```

Example of querying, filtering, and sorting a `posts` example resource from Strapi.
```swift
import StrapiSwiftCross

let strapi = Strapi(host: "http://localhost:1337/api")
let request = QueryRequest("posts")
request.addFilter(type: .greaterThan, onField: "viewCount", forValue: 500)
request.sort(field: "slug", byDirection: .descending)
request.limit(to: 3)

let result = try? await strapi.execute(request)
print(result)
```

All of the above examples have shown how to retrieve a JSON string as a result from the Strapi host. There is also a utility method to have the `JSONDecoder` automatically run on the response, returning you an object of `T`. 

The example assumes you have a model struct `PostsQueryResponse` defined somewhere. Given the customization capabilities of Strapi, a model definition has been omitted from this sample.
```swift
import StrapiSwiftCross

let strapi = Strapi(host: "http://localhost:1337/api")
let request = QueryRequest("posts")

let result: PostsQueryResponse = try? await strapi.executeAndDecode(request)
print(result)
```


## Running Tests
To run the test suite, run the following command

```bash
  swift test
```


## Acknowledgements
 - [Ricardo Rauber](https://github.com/ricardorauber) and his work on [StrapiSwift](https://github.com/ricardorauber/StrapiSwift) which was leaned upon heavily during development of StrapiSwiftCross.


## License
[MIT](https://choosealicense.com/licenses/mit/)
