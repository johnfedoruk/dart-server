import '../services/hello-service.dart';
import '../system/controller.dart';
import 'dart:async';
import 'dart:io';

class HelloController extends Controller {
  HelloService _hello = new HelloService();
  HelloController(HttpRequest request, HttpResponse response)
      : super(request, response);

  Future hello() async {
    await this.response
      ..statusCode = HttpStatus.OK
      ..headers.contentType = ContentType.HTML
      ..write(this._hello.html)
      ..close();
  }

}
