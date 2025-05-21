import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ChoiceChipExample());
  }
}

class ChoiceChipExample extends StatefulWidget {
  const ChoiceChipExample({super.key});

  @override
  State<ChoiceChipExample> createState() => _ChoiceChipExampleState();
}

class _ChoiceChipExampleState extends State<ChoiceChipExample> {
  bool isSelected = false;
  bool isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ChoiceChip(
              avatar: Icon(
                isSelected ? Icons.accessible_forward_rounded : Icons.accessible_rounded,
              ),
              showCheckmark: false,
              label: Text(isSelected ? "Moved" : "Stopped"),
              selected: isSelected,
              onSelected: (value) {
                setState(() {
                  isSelected = value;
                });
              },
            ),
            SizedBox(width: 20),
            ChoiceChip(
              label: Text("Select"),
              selected: isSelected2,
              onSelected: (value) {
                setState(() {
                  isSelected2 = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
