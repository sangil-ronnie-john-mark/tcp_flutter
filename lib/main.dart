import 'dart:io';
import 'package:flutter/material.dart';
import 'joystick_controller.dart';

void main() async {

  Socket sock = await Socket.connect('192.168.1.1', 80);
  runApp(MyApp(
    socket: sock,
  ));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Socket socket;
  const MyApp({super.key, required this.socket});
  // const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JoystickExample(
        channel: socket,
      ),
      // home: ConnectNodeMCU(),
    );
  }
}
