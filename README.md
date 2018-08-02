# Hello World | Dart Server

This project demonstrates a simple, easily scalable, MVC structured Http server in Dart.

## Running

First, you will need to install the [Dart SDK](https://www.dartlang.org/install).

To run the server, simply enter the following from the project root:

```bash
dart bin/main.dart
```

## Development

### Adding a new Controller

Start by creating a file in bin/controllers. You will need to extend the Controller class. It provides two important public class properties: `request` and `response`. These are instances of _HttpRequest_ and _HttpResponse_, respectively.

Once you've extended the Controller class, simply create an async method that has a Future return type.

```Dart
import '../system/controller.dart';
import 'dart:async';
import 'dart:io';

class ExampleController extends Controller {
  ExampleController(HttpRequest request, HttpResponse response)
      : super(request, response);

  Future demo() async {
    await this.response
      ..statusCode = HttpStatus.OK
      ..headers.contentType = ContentType.TEXT
      ..write("Thanks for trying!")
      ..close();
  }
}

```

### Adding a Controller method to a Route

After defining a Controller, you will need to add it to a Route instance. Go into the bin/routes.dart file and an instance of Route into the routes List. The properties you must add into the contructor method for the Route class are as follows:

- Path: The route path to respond to
- Verb: The route verb to respond to
- Controller: The controller class to respond with
- Method: The controller method to respond with

```Dart
...

import 'controllers/hello.controller.dart';

List<Route> routes = [
  ...
  new Route('/example', Verb.GET, ExampleController, 'demo'),
];

```

### Testing it out

Run the server and try making the following cURL request:

```bash
curl -X GET localhost:3000/example
```
