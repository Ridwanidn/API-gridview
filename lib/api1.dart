import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api1 extends StatefulWidget {
  const Api1({super.key});

  @override
  State<Api1> createState() => _Api1State();
}

class _Api1State extends State<Api1> {
  List<dynamic> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Api Page 1',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 234, 3, 88),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final name = product['title'];
          final price = product['price'];
          final imageURL = product['image'];

          return Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('\$${price.toString()}'),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getData();
        },
        child: const Icon(
          Icons.download,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 234, 3, 88),
      ),
    );
  }

  void getData() async {
    const url = 'https://fakestoreapi.com/products'; 
    final uro = Uri.parse(url);
    final respon = await http.get(uro);
    final body = respon.body;
    final json = jsonDecode(body);
    setState(() {
      products = json; 
    });
  }
}
