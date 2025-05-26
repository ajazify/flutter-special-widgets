import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ExpansionTileExample());
  }
}

class ExpansionTileExample extends StatefulWidget {
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTileExampleState();
}

class _ExpansionTileExampleState extends State<ExpansionTileExample> {
  // Track the currently expanded tile
  int? expandedTile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Expansion Widget")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListTile(
              title: Text("Expansion Widget Example"),
              subtitle: Text("This is an expansion widget example"),
            ),
            const Divider(),

            // ! You can also populate  [MyExpansionTile] in a [List View Builder] if you want it dynamically.
            // First custom expansion tile
            MyExpansionTile(
              index: 0,
              currentlyExpanded: expandedTile,
              onExpand: (index) {
                setState(() {
                  expandedTile = index;
                });
              },
              title: "How to open a noodles Packet?",
              leading: Icons.restaurant,
              children: [
                //! Add your Widgets
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(title: Text("#$index Noodles Rule")),
                  ),
                ),
              ],
            ),

            // Second custom expansion tile
            MyExpansionTile(
              index: 1,
              currentlyExpanded: expandedTile,
              onExpand: (index) {
                setState(() {
                  expandedTile = index;
                });
              },
              title: "How to hold a bottle?",
              leading: Icons.hourglass_bottom_rounded,
              children: [
                //! Add your Widgets
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(title: Text("#$index Bottle Rule")),
                  ),
                ),
              ],
            ),

            // Four custom expansion tile
            MyExpansionTile(
              index: 2,
              currentlyExpanded: expandedTile,
              onExpand: (index) {
                setState(() {
                  expandedTile = index;
                });
              },
              title: "How to smell a Flower?",
              leading: Icons.download_rounded,
              children: [
                //! Add your Widgets
                Text("Special Card"),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) => ListTile(title: Text("#$index Flower Rule")),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Our completely custom expansion tile implementation
class MyExpansionTile extends StatefulWidget {
  final int index;
  final int? currentlyExpanded;
  final Function(int?) onExpand;
  final String title;
  final IconData leading;
  final List<Widget> children;

  const MyExpansionTile({
    super.key,
    required this.index,
    required this.currentlyExpanded,
    required this.onExpand,
    required this.title,
    required this.leading,
    required this.children,
  });

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    // Check if this tile should be expanded
    final bool isExpanded = widget.currentlyExpanded == widget.index;

    return Column(
      children: [
        // Header
        ListTile(
          title: Text(widget.title),
          leading: Icon(widget.leading),
          trailing: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
          onTap: () {
            if (isExpanded) {
              // If this tile is already expanded, collapse it
              widget.onExpand(null);
            } else {
              // Otherwise expand this one (which will collapse others)
              widget.onExpand(widget.index);
            }
          },
        ),

        // Content (only shown when expanded)
        if (isExpanded) ...widget.children,
      ],
    );
  }
}
