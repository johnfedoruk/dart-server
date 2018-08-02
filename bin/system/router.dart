import 'dart:async';
import 'dart:io';
import 'dart:mirrors';
import 'route.dart';
import 'system-error.controller.dart';
import 'verb.dart';

class Router {
  HttpServer _server;
  List<Route> _routes;

  Router(HttpServer server, List<Route> routes) {
    this._server = server;
    this._routes = routes;
  }

  Future start() async {
    await for (HttpRequest request in this._server) {
      this._handleRequest(request);
    }
  }

  Future _handleRequest(HttpRequest request) async {
    HttpResponse response = request.response;
    try {
      Route route = this._routes.singleWhere(
          (Route route) => this._routeMatchesRequest(route, request));
      try {
        await this._invokeController(
            route.controller, route.method, request, response);
      } catch (server_error) {
        print(server_error);
        await this._invokeController(
            SystemErrorController, 'error500', request, response);
      }
    } catch (not_found) {
      await this._invokeController(
          SystemErrorController, 'error404', request, response);
    } finally {
      print(
          "${request.method} ${request.uri} [${response.statusCode}] - ${response.connectionInfo.remoteAddress.address}");
    }
  }

  Future _invokeController(Type controller, String method, HttpRequest request,
      HttpResponse response) async {
    InstanceMirror ctrl = reflectClass(controller)
        .newInstance(new Symbol(''), [request, response]);
    InstanceMirror call = ctrl.invoke(new Symbol(method), []);
    await call.reflectee;
  }

  bool _routeMatchesRequest(Route route, HttpRequest request) {
    if (route.path.compareTo(request.uri.toString()) == 0) {
      try {
        return request.method.compareTo(this._verbToString(route.verb)) == 0;
      } catch (verb_parse_error) {
        print(verb_parse_error);
        return false;
      }
    } else {
      return false;
    }
  }

  String _verbToString(Verb verb) {
    switch (verb) {
      case Verb.GET:
        return "GET";
      case Verb.POST:
        return "POST";
      case Verb.PUT:
        return "PUT";
      case Verb.PATCH:
        return "PATCH";
      case Verb.DELETE:
        return "DELETE";
      case Verb.HEAD:
        return "HEAD";
      default:
        throw ("Unknown Verb...");
    }
  }
}
