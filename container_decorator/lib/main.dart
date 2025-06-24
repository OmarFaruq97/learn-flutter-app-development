import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const CircleApp());
}

class CircleApp extends StatelessWidget {
  const CircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('6 Circles UI')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              shrinkWrap: true,
              children: List.generate(9, (index) {
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepOrange,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset.fromDirection(0.25 * pi, 10.2),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
