import 'dart:mirrors';
import 'verb.dart';
import 'controller.dart';

class Route {
  String path;
  Verb verb;
  Type controller;
  String method;
  Route(
    String path,
    Verb verb,
    Type controller,
    String method,
  ) {
    if(!reflectClass(controller).isSubtypeOf(reflectClass(Controller))) {
      throw('${controller} is not a Controller');
    }
    if(!reflectClass(controller).instanceMembers.containsKey(new Symbol(method))) {
      throw('${controller} has no property ${method}');
    }
    if(
      !reflectClass(controller).instanceMembers[new Symbol(method)].isRegularMethod
    ) {
      throw('${controller}.${method} is not a regular method');
    }
    this.path = path;
    this.verb = verb;
    this.controller = controller;
    this.method = method;
  }
}
