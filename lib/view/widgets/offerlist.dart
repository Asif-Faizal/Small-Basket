import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OfferList extends StatefulWidget {
  const OfferList({Key? key}) : super(key: key);

  @override
  _OfferListState createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  final List<String> images = [
    'https://img.freepik.com/free-vector/flat-supermarket-sale-background_23-2149379271.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705536000&semt=ais',
    'https://img.freepik.com/free-vector/flat-supermarket-sale-background_23-2149379271.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705536000&semt=ais',
    'https://img.freepik.com/free-vector/flat-supermarket-sale-background_23-2149379271.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705536000&semt=ais',
    'https://img.freepik.com/free-vector/flat-supermarket-sale-background_23-2149379271.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705536000&semt=ais',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        items: images
            .take(5) // Limit to 5 items
            .map((item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        item,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
