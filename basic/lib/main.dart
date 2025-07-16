import 'package:flutter/material.dart';

main() {
  runApp(const BasicApp());
}

class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Basic Application'),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: Center(child: Text('Hello Basic Application')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text('Menu'),
              ),
              ListTile(title: const Text('Animals')),
              ListTile(title: const Text('Birds')),
              ListTile(title: const Text('Human Body')),
            ],
          ),
        ),
      ),
    );
  }
}
