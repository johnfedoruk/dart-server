// import 'dart:io';
import '../routes.dart';
import 'dart:async';
import 'dart:io';
import 'router.dart';

class Server {
  Future run(int port) async {
    HttpServer server =
        await HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, port);
    print('Listening on localhost:${port}');
    Router router = new Router(server, routes);
    await router.start();
    print('Server killed');
  }
}
