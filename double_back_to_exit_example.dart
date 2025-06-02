import 'package:flutter/material.dart';

// Simple Double Back to Exit Wrapper
class DoubleBackToExit extends StatefulWidget {
  const DoubleBackToExit({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DoubleBackToExit> createState() => _DoubleBackToExitState();
}

class _DoubleBackToExitState extends State<DoubleBackToExit> {
  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        final now = DateTime.now();
        
        if (lastBackPressed == null || 
            now.difference(lastBackPressed!) > const Duration(seconds: 2)) {
          lastBackPressed = now;
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }
        
        Navigator.of(context).pop();
      },
      child: widget.child,
    );
  }
}


// Usage
// Simple - Just wrap any widget that you want to show execute double press to exit.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleBackToExit( // Add this code
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: const Center(
          child: Text(
            'This is the home page.\nPress back twice to exit.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
