import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machn_tst/bloc/customer_bloc.dart';
import 'package:machn_tst/bloc/customer_event.dart';
import 'package:machn_tst/bloc/customer_state.dart';
import 'package:machn_tst/repository/customer_repository.dart';
import 'package:machn_tst/view/widgets/customerCard.dart';
import 'package:http/http.dart' as http;

class CustomerPage extends StatefulWidget {
  CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final _controller = TextEditingController();

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
              child: Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 240,
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
                          prefixIconColor:
                              Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.qr_code_rounded,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                TextEditingController nameController =
                                    TextEditingController();
                                TextEditingController emailController =
                                    TextEditingController();
                                TextEditingController phoneController =
                                    TextEditingController();

                                return AlertDialog(
                                  title: Text("Add Customer"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: nameController,
                                        decoration:
                                            InputDecoration(labelText: "Name"),
                                      ),
                                      TextField(
                                        controller: emailController,
                                        decoration: InputDecoration(
                                            labelText: "Address"),
                                      ),
                                      TextField(
                                        controller: phoneController,
                                        decoration:
                                            InputDecoration(labelText: "Phone"),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("Cancel"),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        child: const Text("Add"),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
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
                ],
              ),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            CustomerBloc(CustomerRepositoryImpl(http.Client())),
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerInitial) {
              BlocProvider.of<CustomerBloc>(context).add(LoadCustomers());
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomersLoaded) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.customers.length,
                itemBuilder: (context, index) {
                  return CustomerCard(
                    customer: state.customers[index],
                  );
                },
              );
            } else if (state is CustomersError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
