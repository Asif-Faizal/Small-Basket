import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        title: Text('My Orders'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: Icon(Icons.arrow_back_rounded)),
      ),
    );
  }
}
