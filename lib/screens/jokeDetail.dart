import 'dart:convert';

import 'package:assignment1/constants.dart';
import 'package:assignment1/models/joke.dart';
import 'package:assignment1/widgets/jokeTile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class JokeDetails extends StatefulWidget {
  JokeDetails({Key? key, required this.category}) : super(key: key);
  String category;
  Future<void>? _launched;
  @override
  _JokeDetailsState createState() => _JokeDetailsState();
}

class _JokeDetailsState extends State<JokeDetails> {
  Future<void>? _launched;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Joke'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder(
            future: getRandomJoke(),
            builder: (context, AsyncSnapshot<Joke> snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.black,
                );
              }
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        JokeTile(
                            joke: snapshot.data!, category: widget.category),
                        const SizedBox(
                          height: 80,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text('Generate Another Random Joke'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future<Joke> getRandomJoke() async {
    var response =
        (await http.get(Uri.parse(randomJokeCategory + widget.category)));
    return Joke.fromJson(jsonDecode(response.body));
  }
}
