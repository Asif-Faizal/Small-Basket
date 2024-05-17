import 'package:flutter/material.dart';
import 'package:machn_tst/models/product.dart';
import 'package:machn_tst/view/widgets/appbarActions.dart';
import 'package:machn_tst/view/widgets/catogoryList.dart';
import 'package:machn_tst/view/widgets/myDrawer.dart';
import 'package:machn_tst/view/widgets/offerlist.dart';
import 'package:machn_tst/view/widgets/staticproductCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String selectedCustomers = '';

  List<Product> products = [
    Product(
        quantity: 1,
        id: 1,
        name: "Orange",
        price: 40,
        imageUrl: "http://143.198.61.94:8000/media/products/images.jpeg"),
    Product(
        quantity: 1,
        id: 3,
        name: "Papaya",
        price: 100,
        imageUrl: "http://143.198.61.94:8000/media/products/Papaya.png.webp"),
    Product(
        quantity: 1,
        id: 3,
        name: "Cherry",
        price: 300,
        imageUrl:
            "http://143.198.61.94:8000/media/products/810eZqaozxL._AC_UF10001000_QL80_.jpg"),
    Product(
        quantity: 1,
        id: 4,
        name: "Mango",
        price: 50,
        imageUrl:
            "http://143.198.61.94:8000/media/products/big_205179_manogo.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            expandedHeight: 150,
            foregroundColor: Theme.of(context).colorScheme.secondary,
            backgroundColor: Theme.of(context).colorScheme.background,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
                  const EdgeInsets.only(bottom: 90, left: 60, top: 25),
              title: Text(
                'Good Day! 👋',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                ),
              ),
            ),
            actions: const [AppbarActions()],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          hintText: 'Search',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          prefixIconColor:
                              Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ),
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OfferList(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  CategoryList(),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discover',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          'see all >',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Theme.of(context).colorScheme.background,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return StaticProductCard(
                    product: products[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
