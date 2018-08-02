import '../system/controller.dart';
import 'dart:async';
import 'dart:io';

class PingController extends Controller {
  PingController(HttpRequest request, HttpResponse response)
      : super(request, response);

  Future ping() async {
    await this.response
      ..statusCode = HttpStatus.OK
      ..headers.contentType = ContentType.TEXT
      ..write("PONG")
      ..close();
  }
}
