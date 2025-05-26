import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> miniList = [
    "Arcanine",
    "Bayleef",
    "Charmander",
    "Dragonite",
    "Farfetch’d",
    "Bulbasaur",
    "Blastoise",
    "Beldum",
    "Banette",
    "Bewear",
    "Kabuto",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16), child: ResponsiveGridView(items: miniList)),
    );
  }
}

class ResponsiveGridView extends StatelessWidget {
  final List<dynamic> items;

  const ResponsiveGridView({super.key, required this.items});

  int _calculateCrossAxisCount(double width) {
    if (width > 1200) return 6;
    if (width > 900) return 5;
    if (width > 600) return 4;
    if (width > 300) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateCrossAxisCount(constraints.maxWidth),
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              var bgColor = Color(Random().nextInt(0xffffffff));
              var item = items[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                child: InkWell(
                  onTap: () => print(item),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: 0.75,
                            backgroundColor: bgColor,
                            valueColor: AlwaysStoppedAnimation<Color>(bgColor),
                          ),
                          Icon(Icons.electric_bolt, size: 20, color: bgColor),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        item,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
