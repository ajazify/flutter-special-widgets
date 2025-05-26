import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: StepperExample());
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  // Current step index
  int _currentStep = 0;

  // Proceed to next step
  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      } else {
        // Handle form submission here
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  // Handle tap on step
  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  void dispose() {
    // Clean up controllers (if used)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Add Firebase to your'), leading: Icon(Icons.close)),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepTapped: _onStepTapped,
        physics: const ClampingScrollPhysics(),
        controlsBuilder: (context, details) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (_currentStep != 0)
                  TextButton(
                    onPressed: _previousStep,
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text('Previous'),
                  ),
                const SizedBox(width: 12),
                FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: _nextStep,
                  child: Text(_currentStep < 2 ? 'Next' : 'Submit'),
                ),
              ],
            ),
          );
        },
        steps: [
          Step(
            title: Text('Prepare your workspace', style: textTheme.titleLarge),
            isActive: _currentStep >= 0,
            content: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("The easiest way to get you started is to use the FlutterFire CLI."),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• Install the Flutter SDK"),
                        SizedBox(height: 4),
                        Text("• Create a project (run flutter create)"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text('Install and run CLI', style: textTheme.titleLarge),
            isActive: _currentStep >= 1,
            content: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From any directory, run this command:"),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• dart pub global activate "),
                        SizedBox(height: 4),
                        Text("• Then, Open Flutter project"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text('Initialize Firebase', style: textTheme.titleLarge),
            isActive: _currentStep >= 2,
            content: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "To initialize Firebase, call Firebase. initializeApp from the firebase_core package ",
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
