import 'package:flutter/material.dart';

void main() {
  runApp(const NumberPad());
}

// Constants for button size
const double width = 100;
const double height = 80;

class NumberPad extends StatelessWidget {
  const NumberPad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Number Pad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Omar Contact Number Pad'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  void _deleteLastDigit() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        _controller.text = text.substring(0, text.length - 1);
      });
    }
  }

  void _submitNumber() {
    // You can add submission logic here
    print('Submitted number: ${_controller.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controller,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Number',
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28),
            ),
          ),
          const SizedBox(height: 20),
          NumPadCheckout(
            controller: _controller,
            delete: _deleteLastDigit,
            onSubmit: _submitNumber,
          ),
        ],
      ),
    );
  }
}

class NumPadCheckout extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback delete;
  final VoidCallback onSubmit;

  const NumPadCheckout({
    Key? key,
    required this.delete,
    required this.onSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRow(["1", "2", "3"]),
        buildRow(["4", "5", "6"]),
        buildRow(["7", "8", "9"]),
        buildRow(["*", "0", "⌫"], isLastRow: true),
        const SizedBox(height: 20),
        SizedBox(
          width: width * 2 + 20,
          height: height,
          child: ElevatedButton(
            onPressed: onSubmit,
            child: const Text("Call", style: TextStyle(fontSize: 20)),
          ),
        ),
      ],
    );
  }

  Widget buildRow(List<String> keys, {bool isLastRow = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: keys.map((key) {
        if (key == "⌫") {
          return CustomKey(iconData: Icons.backspace, onPressed: delete);
        }
        return NumberButtonCheckout(number: key, controller: controller);
      }).toList(),
    );
  }
}

class NumberButtonCheckout extends StatelessWidget {
  final String number;
  final TextEditingController controller;

  const NumberButtonCheckout({
    Key? key,
    required this.number,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () {
          controller.text += number;
        },
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class CustomKey extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;

  const CustomKey({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(iconData, size: 24),
      ),
    );
  }
}
