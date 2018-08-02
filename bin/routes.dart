// System imports
import 'system/route.dart';
import 'system/verb.dart';

// Controller imports
import 'controllers/ping.controller.dart';

List<Route> routes = [
  new Route('/ping', Verb.GET, PingController, 'ping'),
];
