import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'dart:math';

class JoystickExample extends StatefulWidget {
  final Socket channel;
  const JoystickExample({super.key, required this.channel});
  // const JoystickExample({super.key});

  @override
  State<JoystickExample> createState() => _JoystickExampleState();
}

class _JoystickExampleState extends State<JoystickExample> {
  final JoystickMode _joystickMode = JoystickMode.all;
  final double pi = 3.1415926535897932;

  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('IoT Controller'),
        backgroundColor: Colors.grey,
      ),
      body: SafeArea(
        child: Center(
          // The joystick container
          child: Container(
            alignment: const Alignment(0, 0.1),
            child: Joystick(
              mode: _joystickMode,
              listener: (details) {
                setState(() {
                  double getRadians = atan2(details.x, -details.y);
                  double getDegrees = getRadians * (180 / pi);
                  if (getDegrees < 0) {
                    getDegrees += 360;
                  }
                  debugPrint(getDegrees.toString());
                  if (details.x != 0 && details.y != 0) {
                    if (getDegrees >= 315 || getDegrees <= 44) {
                      debugPrint("Move Forward");
                      widget.channel.write("F");
                    } else if (getDegrees >= 45 && getDegrees <= 134) {
                      debugPrint("Rotate Right");
                      widget.channel.write("R");
                    } else if (getDegrees >= 135 && getDegrees <= 224) {
                      debugPrint("Move Backward");
                      widget.channel.write("B");
                    } else if (getDegrees >= 225 && getDegrees <= 314) {
                      debugPrint("Rotate Left");
                      widget.channel.write("L");
                    }
                  }
                });
              },
            ),
          ),
        ),
      ),


    );
  }
}
