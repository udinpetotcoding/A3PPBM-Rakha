import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String _selectedCategory = "Uang";
  double _inputValue = 0;
  String _outputValue = "0";
  final TextEditingController _inputController = TextEditingController();

  final Map<String, List<String>> _conversionOptions = {
    "Uang": ["USD ke IDR", "IDR ke USD"],
    "Suhu": ["Celsius ke Fahrenheit", "Fahrenheit ke Celsius"],
    "Berat": ["Kilogram ke Pound", "Pound ke Kilogram"],
  };

  String _selectedConversion = "USD ke IDR";

  void _convert() {
    setState(() {
      double input = double.tryParse(_inputController.text) ?? 0;
      double result = 0;

      if (_selectedCategory == "Uang") {
        if (_selectedConversion == "USD ke IDR") {
          result = input * 15000; // Asumsi 1 USD = 15.000 IDR
        } else if (_selectedConversion == "IDR ke USD") {
          result = input / 15000;
        }
      } else if (_selectedCategory == "Suhu") {
        if (_selectedConversion == "Celsius ke Fahrenheit") {
          result = (input * 9 / 5) + 32;
        } else if (_selectedConversion == "Fahrenheit ke Celsius") {
          result = (input - 32) * 5 / 9;
        }
      } else if (_selectedCategory == "Berat") {
        if (_selectedConversion == "Kilogram ke Pound") {
          result = input * 2.20462;
        } else if (_selectedConversion == "Pound ke Kilogram") {
          result = input / 2.20462;
        }
      }

      _outputValue = result.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0, // Hilangkan bayangan untuk desain datar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown kategori konversi
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(
                labelText: "Pilih Kategori",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: _conversionOptions.keys.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newCategory) {
                setState(() {
                  _selectedCategory = newCategory!;
                  _selectedConversion = _conversionOptions[_selectedCategory]!.first;
                });
              },
            ),
            const SizedBox(height: 16),
            // Dropdown opsi konversi
            DropdownButtonFormField<String>(
              value: _selectedConversion,
              decoration: InputDecoration(
                labelText: "Pilih Konversi",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: _conversionOptions[_selectedCategory]!.map((String conversion) {
                return DropdownMenuItem<String>(
                  value: conversion,
                  child: Text(conversion),
                );
              }).toList(),
              onChanged: (String? newConversion) {
                setState(() {
                  _selectedConversion = newConversion!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Input nilai
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan nilai",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _inputValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 16),
            // Tombol konversi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna biru khas iOS
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _convert,
                child: const Text(
                  "Konversi",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Hasil konversi
            Text(
              "Hasil: $_outputValue",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
