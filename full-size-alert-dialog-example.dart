import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: MyDialogueHome());
  }
}

class MyDialogueHome extends StatelessWidget {
  const MyDialogueHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => fullSizeDialog(context: context),
          child: Text("Show Full Dialogue Alert!"),
        ),
      ),
    );
  }
}

Future<dynamic> fullSizeDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.zero, // Remove default padding
        child: Material(
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey.shade200,
                title: const Text('Full Size Dialogue', style: TextStyle(fontSize: 14)),
                leading: IconButton(
                  icon: const Icon(Icons.close, size: 15),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: Text("Full Screen Alert Dialogue")),
              ),
            ),
          ),
        ),
      );
    },
  );
}
