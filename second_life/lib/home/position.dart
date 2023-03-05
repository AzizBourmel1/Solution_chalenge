import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class position extends StatefulWidget {
  const position({super.key});

  @override
  State<position> createState() => _positionState();
}

class _positionState extends State<position> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Press the button with a label below!'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: const Text('Share'),
        icon: const Icon(Icons.shopping_cart_checkout_sharp),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
