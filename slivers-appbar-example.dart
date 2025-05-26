import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SliversAppBarExample());
  }
}

class SliversAppBarExample extends StatefulWidget {
  const SliversAppBarExample({super.key});

  @override
  State<SliversAppBarExample> createState() => _SliversAppBarExampleState();
}

class _SliversAppBarExampleState extends State<SliversAppBarExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            pinned: true,
            floating: true,
            snap: false,
            title: Text("Flutter", style: TextStyle(color: Colors.white)),
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                fit: BoxFit.cover,
                "https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg",
              ),
              title: Text("Silver", style: TextStyle(color: Colors.white)),
              centerTitle: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                title: Text('Item #$index'),
                leading: const Icon(Icons.adobe_sharp),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              );
            }),
          ),
        ],
      ),
    );
  }
}
