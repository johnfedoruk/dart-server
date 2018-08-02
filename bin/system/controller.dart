import 'dart:io';

abstract class Controller {
  HttpRequest request;
  HttpResponse response;
  Controller(HttpRequest request, HttpResponse response) {
    this.request = request;
    this.response = response;
  }
}
