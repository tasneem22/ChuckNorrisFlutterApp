import 'package:assignment1/widgets/jokeTile.dart';
import 'package:flutter/material.dart';

import '../models/joke.dart';

class JokeList extends StatelessWidget {
  JokeList({Key? key, required this.jokes, required this.query})
      : super(key: key);
  List<Joke> jokes;
  String query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resulted Jokes for $query',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [...jokes.map((e) => JokeTile(joke: e, category: null))],
      ),
    );
  }
}
