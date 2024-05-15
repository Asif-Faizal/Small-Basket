import 'package:flutter/material.dart';
import 'package:machn_tst/models/colors.dart';
import 'package:machn_tst/view/customerPage.dart';
import 'package:machn_tst/view/homePage.dart';
import 'package:machn_tst/view/productPage.dart';
import 'package:machn_tst/viewmodel/bottom_nav_viewmodel.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavViewModel(),
      child: MaterialApp(
        title: 'Bottom Nav Demo',
        theme: ThemeData(colorScheme: myColorScheme),
        home: const MyBottomNavPage(),
      ),
    );
  }
}

class MyBottomNavPage extends StatelessWidget {
  const MyBottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<BottomNavViewModel>(context);

    return Scaffold(
      body: IndexedStack(
        index: viewModel.currentIndex,
        children: [
          HomePage(),
          ProductPage(),
          CustomerPage(),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.elliptical(200, 10),
          topRight: Radius.elliptical(200, 10),
        ),
        child: SizedBox(
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
