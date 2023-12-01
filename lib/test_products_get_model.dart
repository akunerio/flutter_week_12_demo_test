import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_week_12_demo_test/model_products.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Layout 1",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const myHomePage(),
    );
  }
}

class myHomePage extends StatefulWidget {
  const myHomePage({Key? key}) : super(key: key);

  @override
  State<myHomePage> createState() => _myHomePageState();
}

class _myHomePageState extends State<myHomePage> {

  Future<List> getData() async {
    List products = [];

    try {
      final response = await http.get(
        Uri.parse('http://103.67.187.87/telu_laravel_08/public/api/products'),
        headers: {
          HttpHeaders.authorizationHeader : 'Bearer 26|2Jq1Z3utkaGJgOVhLxFXcAPrvnLrb4e7DxNWPmqA',
        },
      );

      products = parseProducts(response.body);

    } catch (err) {
      print (err);
    }

    return products;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fetch Data Example")),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  subtitle: Text(snapshot.data![index].price.toString()),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
