import 'dart:io';
import 'dart:async';
import '../system/controller.dart';

class SystemErrorController extends Controller {
  SystemErrorController(HttpRequest request, HttpResponse response)
      : super(request, response);

  Future error404() async {
    await this.response
      ..statusCode = HttpStatus.NOT_FOUND
      ..close();
  }

  Future error500() async {
    try {
      await this.response
        ..statusCode = HttpStatus.INTERNAL_SERVER_ERROR
        ..close();
    } catch (e) {
      print(e);
    }
  }
}
