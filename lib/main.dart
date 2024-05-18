import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/bloc/customer_bloc.dart';
import 'package:machn_tst/models/colors.dart';
import 'package:machn_tst/repository/customer_repository.dart';
import 'package:machn_tst/repository/productAdapter.dart';
import 'package:machn_tst/view/cartPage.dart';
import 'package:machn_tst/view/customerPage.dart';
import 'package:machn_tst/view/homePage.dart';
import 'package:machn_tst/view/myOrders.dart';
import 'package:machn_tst/view/orderPlaced.dart';
import 'package:machn_tst/view/productPage.dart';
import 'package:machn_tst/view/wishlist_page.dart';
import 'package:machn_tst/viewmodel/bottom_nav_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ProductAdapter());
  // await Hive.openBox<Product>('cart');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavViewModel()),
        BlocProvider<CustomerBloc>(
          create: (context) =>
              CustomerBloc(CustomerRepositoryImpl(http.Client())),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Technaureus Machine Test',
        theme: ThemeData(colorScheme: myColorScheme),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyBottomNavPage(),
          '/wishlist': (context) => const WishlistPage(),
          '/cart': (context) => const CartPage(),
          '/myorders': (context) => const MyOrdersPage(),
          '/orderplaced': (context) => const OrderPlaced(),
        },
      ),
    );
  }
}

class MyBottomNavPage extends StatelessWidget {
  const MyBottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BottomNavViewModel>(context);
    final customerBloc = BlocProvider.of<CustomerBloc>(context);

    return Scaffold(
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: [
          HomePage(),
          ProductPage(),
          BlocProvider.value(
            value: customerBloc,
            child: CustomerPage(),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.elliptical(200, 10),
          topRight: Radius.elliptical(200, 10),
        ),
        child: Container(
          color: Colors.transparent,
          height: 80,
          child: BottomNavigationBar(
            elevation: 3,
            backgroundColor: Color.fromARGB(170, 184, 255, 102),
            unselectedItemColor: Theme.of(context).colorScheme.secondary,
            selectedItemColor: Theme.of(context).colorScheme.onPrimary,
            currentIndex: viewModel.currentIndex,
            onTap: (index) => viewModel.updateIndex(index),
            items: viewModel.items
                .map((item) => BottomNavigationBarItem(
                      icon: Icon(item.icon),
                      label: item.title,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
