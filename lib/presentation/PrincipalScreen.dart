// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesnoapp/presentation/CarritoScreen.dart';
import 'package:yesnoapp/presentation/LoginScreen.dart';

import '../models/Categoria.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({Key? key}) : super(key: key);

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  Future<void> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('username');
  }

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(4.0)),
        title: const Text('Menu'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.output_outlined)),
          IconButton(onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CarritoScreen()),
                );
          }, icon: const Icon(Icons.car_rental))
        ],
      ),
      body: FutureBuilder<List<Categories>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final categories = snapshot.data!;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                            categories[index].image),
                        title: Text(categories[index].name),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductoScreen(
                          //
                          //         idCategoria: categories[index].idCategoria
                          //
                          //
                          //         ),
                          //   ),
                          Navigator.pushNamed(context, 'productos',
                              arguments: categories[index].id);
                        },
                      ),
                    ),
                  );
                });
              },
            );
          } else {
            return const Text('No hay datos disponibles');
          }
        },
      ),
    );
  }
}

Future<List<Categories>> fetchCategories() async {
  final response = await http.get(
    Uri.parse(
        'https://api.escuelajs.co/api/v1/categories'),
  );
  inspect(response.body);
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
  // print(typeofEquals(jsonData, ));
    
      final List<Categories> categoriasData = Categories.fromMap(jsonData) as List<Categories>;

      return categoriasData;

  } else {
    throw Exception('Error al cargar las categorías');
  }
}
