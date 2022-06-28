import 'package:flutter/material.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Item {
  final String label;
  bool value;
  Item(this.label, this.value);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var toggle = true;
  var items = [
    Item("Satu", false),
    Item("Dua", false),
    Item("Tiga", false),
    Item("Empat", false),
    Item("Lima", false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: toggle,
                onChanged: (t) {
                  setState(() {
                    toggle = t;
                  });
                },
              ),
              ...items.map((e) {
                return Row(
                  children: [
                    Expanded(child: Text(e.label)),
                    const SizedBox(width: 4),
                    Checkbox(
                      value: e.value,
                      onChanged: !toggle
                          ? null
                          : (v) {
                              setState(() {
                                setState(() {
                                  e.value = v ?? false;
                                });
                              });
                            },
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
