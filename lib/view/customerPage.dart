import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:machn_tst/bloc/customer_bloc.dart';
import 'package:machn_tst/bloc/customer_event.dart';
import 'package:machn_tst/bloc/customer_state.dart';
import 'package:machn_tst/models/customer.dart';
import 'package:machn_tst/repository/customer_repository.dart';
import 'package:machn_tst/repository/order_service.dart';
import 'package:machn_tst/repository/productAdapter.dart';
import 'package:machn_tst/view/widgets/customerCard.dart';
import 'package:http/http.dart' as http;

class CustomerPage extends StatefulWidget {
  CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final TextEditingController _controller = TextEditingController();
  List<Customer> _filteredCustomers = [];
  bool _isLoading = false;
  late Box<Product> _cartBox;

  @override
  void initState() {
    super.initState();
    _openCartBox();
    _controller.addListener(() {
      setState(() {
        _filteredCustomers = _filterCustomers(_controller.text);
      });
    });
  }

  Future<void> _openCartBox() async {
    _cartBox = await Hive.openBox<Product>('cart');
  }

  List<Customer> _filterCustomers(String query) {
    final currentState = BlocProvider.of<CustomerBloc>(context).state;

    if (currentState is CustomersLoaded) {
      return currentState.customers
          .where((customer) =>
              customer.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> _placeOrder(int customerId) async {
    setState(() {
      _isLoading = true;
    });

    final products = _cartBox.values.toList();
    final totalPrice =
        products.fold(0.0, (sum, product) => sum + product.price);

    final apiService = ApiService();

    try {
      final response =
          await apiService.placeOrder(customerId, totalPrice, products);
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/orderplaced');
        _cartBox.deleteAll(products);
      } else {
        print('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      print('Error placing order: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text('Customers'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        actions: const [
          Icon(
            Icons.list_rounded,
            color: Colors.black,
            size: 24,
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      onChanged: (query) {
                        BlocProvider.of<CustomerBloc>(context)
                            .add(LoadCustomers(query: _controller.text));
                      },
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
                    width: 80,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.qr_code_rounded,
                          size: 24,
                        ),
                        SizedBox(
                          width: 50,
                          child: ElevatedButton(
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
                                    title: const Text("Add Customer"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                              labelText: "Name"),
                                        ),
                                        TextField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                              labelText: "Address"),
                                        ),
                                        TextField(
                                          controller: phoneController,
                                          decoration: const InputDecoration(
                                              labelText: "Phone"),
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
              BlocProvider.of<CustomerBloc>(context).add(const LoadCustomers());
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CustomersLoaded) {
              if (_filteredCustomers.isEmpty) {
                _filteredCustomers = state.customers;
              }
              return _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filteredCustomers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext ctx) {
                                return ConfirmationDialog(
                                  title: 'Confirm Order',
                                  content:
                                      'Are you sure you want to proceed with the order?',
                                  onConfirm: () {
                                    Navigator.of(ctx).pop();
                                    _placeOrder(_filteredCustomers[index].id);
                                  },
                                  onCancel: () {
                                    Navigator.pop(ctx);
                                  },
                                );
                              },
                            );
                          },
                          child: CustomerCard(
                            customer: _filteredCustomers[index],
                          ),
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

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ConfirmationDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
