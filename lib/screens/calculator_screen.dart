import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0"; // Output yang akan ditampilkan di layar
  String _currentValue = "0"; // Nilai yang sedang diinput
  String? _operator; // Operator saat ini
  double? _firstNumber; // Angka pertama sebelum operator

  // Fungsi untuk menangani input angka dan operator
  void _onPressed(String value) {
    setState(() {
      if (value == "C") {
        // Reset kalkulator
        _output = "0";
        _currentValue = "0";
        _operator = null;
        _firstNumber = null;
      } else if (value == "+" || value == "-" || value == "x" || value == "/") {
        // Operator ditekan
        _operator = value;
        _firstNumber = double.tryParse(_currentValue);
        _currentValue = "0";
      } else if (value == "=") {
        // Tombol sama dengan ditekan
        if (_operator != null && _firstNumber != null) {
          double secondNumber = double.tryParse(_currentValue) ?? 0;
          double result;

          switch (_operator) {
            case "+":
              result = _firstNumber! + secondNumber;
              break;
            case "-":
              result = _firstNumber! - secondNumber;
              break;
            case "x":
              result = _firstNumber! * secondNumber;
              break;
            case "/":
              result = secondNumber != 0 ? _firstNumber! / secondNumber : 0;
              break;
            default:
              result = 0;
          }

          _output = result.toString();
          _currentValue = "0";
          _operator = null;
          _firstNumber = null;
        }
      } else {
        // Angka ditekan
        if (_currentValue == "0") {
          _currentValue = value;
        } else {
          _currentValue += value;
        }
        _output = _currentValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Tampilan output
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black,
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Tombol kalkulator
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey[900],
              child: Column(
                children: [
                  _buildButtonRow(["7", "8", "9", "/"]),
                  _buildButtonRow(["4", "5", "6", "x"]),
                  _buildButtonRow(["1", "2", "3", "-"]),
                  _buildButtonRow(["C", "0", "=", "+"]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Membuat baris tombol
  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((btn) => _buildButton(btn)).toList(),
      ),
    );
  }

  // Membuat tombol
  Widget _buildButton(String value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onPressed(value),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: value == "C" ? Colors.red : Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: value == "C" ? Colors.white : Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
