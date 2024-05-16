import 'package:flutter/material.dart';
import 'package:machn_tst/models/customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  const CustomerCard({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: SizedBox(
        child: Stack(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 65,
                      child: Container(
                        color: Colors.black,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.name,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          customer.id.toString(),
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade800),
                        ),
                        Text(
                          '${customer.street}, ${customer.street_two}, ${customer.city}',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 10,
              right: 10,
              child: SizedBox(
                child: Row(
                  children: [
                    Icon(
                      Icons.call,
                      size: 15,
                    ),
                    Icon(
                      Icons.message_rounded,
                      size: 15,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
