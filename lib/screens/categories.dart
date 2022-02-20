import 'dart:convert';

import 'package:assignment1/constants.dart';
import 'package:assignment1/screens/jokeDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getCategories(),
        builder: (context, AsyncSnapshot<List<dynamic>> categories) {
          if (!categories.hasData &&
              categories.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Colors.black,
            );
          }
          if (categories.hasError) {
            return Center(child: Text(categories.error.toString()));
          }
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: (categories.data)!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(categories.data![index]),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          JokeDetails(category: categories.data![index])));
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<List<String>> getCategories() async {
    var response = (await http.get(Uri.parse(categoriesList)));
    List<String> categories =
        (jsonDecode(response.body) as List<dynamic>).cast<String>();

    return categories;
  }
}
