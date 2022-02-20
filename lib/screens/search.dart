import 'dart:convert';

import 'package:assignment1/constants.dart';
import 'package:assignment1/models/joke.dart';
import 'package:assignment1/screens/jokesList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  List<Joke>? jokes;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('Find Joke by Searching'),
                    TextField(
                      controller: _controller,
                    ),
                  ],
                ),
              ),
              // jokes != null
              //     ? Expanded(
              //         child: ListView(
              //             // shrinkWrap: true,
              //             scrollDirection: Axis.horizontal,
              //             children: [
              //               ...jokes!.map((e) => SizedBox(
              //                     height: 200,
              //                     child: JokeTile(
              //                         joke: e,
              //                         category: e.categories.toString()),
              //                   ))
              //             ]),
              //       )
              //     : Wrap(),
              ElevatedButton(
                onPressed: () async {
                  print(_controller.text);
                  await getQueryJokes(_controller.text);
                },
                child: const Text('Search'),
                style: ElevatedButton.styleFrom(primary: Colors.black),
              ),
            ]),
      ),
    );
  }

  getQueryJokes(String query) async {
    var response =
        jsonDecode((await http.get(Uri.parse(jokeQuery + query))).body);
    print(response['result']);
    List<Joke> result = (response['result'] as List<dynamic>)
        .map((e) => Joke.fromJson(e))
        .toList();
    setState(() {
      // jokes = result;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => JokeList(
                jokes: result,
                query: query,
              )));
    });
    return result;
  }
}
