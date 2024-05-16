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
    'https://www.shutterstock.com/shutterstock/photos/1786091843/display_1500/stock-vector-website-design-for-online-grocery-store-girl-with-laptop-ordering-food-online-grocery-store-1786091843.jpg',
    'https://as1.ftcdn.net/v2/jpg/03/64/68/42/1000_F_364684231_FXZlCAKUhAcenOcv6qUrzdP77L0BOzHU.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1445131568/display_1500/stock-vector-web-page-design-template-for-grocery-store-online-market-home-delivery-man-with-laptop-and-food-1445131568.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1783009853/display_1500/stock-vector-website-design-for-online-grocery-store-grocery-basket-and-trolley-full-of-food-grocery-store-1783009853.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CarouselSlider(
        items: images
            .take(5)
            .map((item) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        item,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          autoPlayAnimationDuration: Duration(seconds: 3),
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
