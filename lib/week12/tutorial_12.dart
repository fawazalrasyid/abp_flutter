import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'product.dart';

void main() => runApp(const TutorialWeek12());

class TutorialWeek12 extends StatefulWidget {
  const TutorialWeek12({super.key});

  @override
  State<TutorialWeek12> createState() => _TutorialWeek12State();
}

Future<List<Product>> fetchProduct() async {
  final res = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/products'),
  );
  if (res.statusCode == 200) {
    var data = jsonDecode(res.body) as List;
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed');
  }
}

Future addProduct(Product product) async {
  final res = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/products'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(product.toJson()),
  );

  if (res.statusCode == 201) {
    var data = jsonDecode(res.body);
    return data['message'];
  } else {
    var data = jsonDecode(res.body);
    return data['message'];
  }
}

class _TutorialWeek12State extends State<TutorialWeek12> {
  late Future<List<Product>> products;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    products = fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: fetchProduct(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Tidak ada data'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              formatCurrency(item.price),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddProductDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty &&
                    priceController.text.isNotEmpty) {
                  final newProduct = Product(
                    id: 0,
                    name: nameController.text,
                    price: int.parse(priceController.text),
                    description: 'Lorem ipsum',
                    processor: 'Intel Core i5',
                    memory: '8GB',
                    storage: '1TB',
                  );

                  final response = await addProduct(newProduct);

                  nameController.clear();
                  priceController.clear();

                  setState(() {
                    products = fetchProduct();
                  });

                  if (context.mounted) {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Name and price cannot be empty'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  String formatCurrency(int amount) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(amount);
  }
}
