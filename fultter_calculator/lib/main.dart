import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C" || buttonText == "AC") {
        _output = "0";
        _currentInput = "";
        _num1 = 0;
        _num2 = 0;
        _operation = "";
      } else if (buttonText == "[X]") {
        if (_currentInput.isNotEmpty) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
          _output = _currentInput.isEmpty ? "0" : _currentInput;
        }
      } else if (buttonText == ".") {
        if (!_currentInput.contains(".")) {
          _currentInput += ".";
          _output = _currentInput;
        }
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "*" ||
          buttonText == "÷" ||
          buttonText == "%") {
        if (_currentInput.isNotEmpty) {
          _num1 = double.parse(_currentInput);
          _operation = buttonText;
          _currentInput = "";
          _output = "$_num1 $_operation";
        }
      } else if (buttonText == "=") {
        if (_currentInput.isNotEmpty && _operation.isNotEmpty) {
          _num2 = double.parse(_currentInput);

          switch (_operation) {
            case "+":
              _currentInput = (_num1 + _num2).toString();
              break;
            case "-":
              _currentInput = (_num1 - _num2).toString();
              break;
            case "*":
              _currentInput = (_num1 * _num2).toString();
              break;
            case "÷":
              _currentInput = _num2 != 0
                  ? (_num1 / _num2).toStringAsFixed(2)
                  : "Error";
              break;
            case "%":
              _currentInput = (_num1 % _num2).toString();
              break;
          }

          _num1 = 0;
          _num2 = 0;
          _operation = "";
          _output = _currentInput;
        }
      } else {
        _currentInput += buttonText;
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(
    String buttonText, {
    Color color = Colors.white,
    Color textColor = Colors.black,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(24.0),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Calculator'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 12.0,
            ),
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(thickness: 2, color: Colors.yellow),
          Column(
            children: [
              Row(
                children: [
                  _buildButton(
                    "AC",
                    color: Colors.redAccent,
                    textColor: Colors.white,
                  ),
                  _buildButton(
                    "[X]",
                    color: Colors.red,
                    textColor: Colors.white,
                  ),
                  _buildButton(
                    "%",
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                  _buildButton(
                    ".",
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton(
                    "÷",
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton(
                    "*",
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton(
                    "-",
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  _buildButton("0"),
                  _buildButton(
                    "C",
                    color: Colors.brown,
                    textColor: Colors.white,
                  ),
                  _buildButton(
                    "=",
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                  _buildButton(
                    "+",
                    color: Colors.orange,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
