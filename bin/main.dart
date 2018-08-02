import 'dart:async';
import 'system/server.dart';

Future main() async {
  Server server = new Server();
  await server.run(3000);
}
