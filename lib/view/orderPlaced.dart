import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({super.key});

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacementNamed(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.network(
                'https://lottie.host/3c0ad972-310d-44d0-8555-a700ce87d451/PszutEdy6t.json'),
            Text(
              'Order Placed',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
