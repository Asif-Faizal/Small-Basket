import 'package:flutter/material.dart';
import 'package:machn_tst/view/widgets/customerCard.dart';

class CustomerPage extends StatelessWidget {
  final _controller = TextEditingController();
  CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Customers',
        ),
        leading: const Icon(Icons.arrow_back_ios_new_rounded),
        actions: const [
          Icon(
            Icons.list_rounded,
            color: Colors.black,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              elevation: 5,
              child: SizedBox(
                height: 60,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.grey),
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
                        color: Colors.grey,
                      ),
                      suffix: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.qr_code_rounded,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      prefixIconColor: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) {
          return customerCard();
        },
      ),
    );
  }
}
