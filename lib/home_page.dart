import 'package:flutter/material.dart';
import 'package:myapp/custom_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            children: [
              Expanded(child: CustomBox()),
              Expanded(
                flex: 2,
                child: CustomBox(),
              ),
              Expanded(child: CustomBox()),
            ],
          ),
          const Text('Anda telah menghitung sebanyak:'),
          Text(
            _counter.toString(),
            style: const TextStyle(fontSize: 48),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
