import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final List<String> lists = <String>[
    "Warehouse",
    "Creator",
    "Accounts",
    "Rental",
    "Loan Manager",
    "Service",
    "Restaurant",
  ];
  final List<IconData> icons = [
    Icons.warehouse, // Warehouse
    Icons.create, // Creator
    Icons.account_circle, // Accounts
    Icons.car_rental, // Rental
    Icons.account_balance, // Loan Manager
    Icons.build, // Service
    Icons.restaurant, // Restaurant
  ];

  @override
  Widget build(BuildContext context) {
    var mediaHeight = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Windows 8 Menu',
      theme: ThemeData(primarySwatch: Colors.amber, fontFamily: 'Segoe UI'),
      home: Scaffold(
        appBar: AppBar(title: Text("The App")),
        body: Center(child: Text("data")),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(mediaHeight: mediaHeight, textTheme: textTheme),
              ContainerDecorator(),
              MenuLists(lists: lists, textTheme: textTheme, icons: icons),
              // Spacer(),

              // Padding(
              //   padding: EdgeInsets.all(16),
              //   child: RichText(
              //     text: TextSpan(
              //       text: 'Create with ',
              //       style: DefaultTextStyle.of(context).style,
              //       children: const <TextSpan>[
              //         TextSpan(text: 'Love', style: TextStyle(fontWeight: FontWeight.bold)),
              //         TextSpan(text: ' by Ajas!'),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key, required this.mediaHeight, required this.textTheme});

  final Size mediaHeight;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      height: mediaHeight.height * .25,
      decoration: BoxDecoration(color: Colors.deepPurple),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Spacer(),
          ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Manifesto", style: textTheme.titleLarge!.copyWith(color: Colors.white)),
                Text(".", style: textTheme.displayMedium!.copyWith(color: Colors.red)),
              ],
            ),
            subtitle: Text(
              "Normalize your designer concept!",
              style: textTheme.labelSmall!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuLists extends StatelessWidget {
  const MenuLists({super.key, required this.lists, required this.textTheme, required this.icons});

  final List<String> lists;
  final TextTheme textTheme;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: List.generate(lists.length, (index) {
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      lists[index],
                      style: textTheme.labelLarge!.copyWith(color: Colors.black),
                    ),
                    leading: Icon(icons[index], size: 18, color: Colors.black38),
                    trailing: Icon(Icons.navigate_next_rounded),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: Colors.purple.withValues(alpha: .1),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class ContainerDecorator extends StatelessWidget {
  const ContainerDecorator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Container(
          height: 8,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(90),
              bottomRight: Radius.circular(90),
            ),
          ),
        ),
        Container(
          height: 8,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(90),
              bottomRight: Radius.circular(90),
            ),
          ),
        ),
        Container(
          height: 8,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(90),
              bottomRight: Radius.circular(90),
            ),
          ),
        ),
        Container(
          height: 8,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(90),
              bottomRight: Radius.circular(90),
            ),
          ),
        ),
      ],
    );
  }
}
