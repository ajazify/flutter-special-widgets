import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => customShowBottomSheet(context),
          child: const Text("Show Modal Bottom Sheet"),
        ),
      ),
    );
  }
}

void customShowBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Material(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Search', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 5.0),

              //! User TextForm Field
              TextFormField(
                decoration: InputDecoration(
                  isDense: false,
                  hintText: 'Type here..',
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(5),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Search', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                ),
                autofocus: true, //! Open keyboard
              ),
            ],
          ),
        ),
      );
    },
  );
}
