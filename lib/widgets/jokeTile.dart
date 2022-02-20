import 'package:assignment1/models/joke.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JokeTile extends StatelessWidget {
  JokeTile({Key? key, required this.joke, required this.category})
      : super(key: key);
  Joke joke;
  String? category;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  joke.icon_url,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                category != null
                    ? buildRow(30, 'Joke Category: ', category!)
                    : Wrap(),
                const SizedBox(
                  height: 30,
                ),
                buildRow(15, 'Random Joke: ', joke.value),
                const SizedBox(
                  height: 10,
                ),
                buildRow(15, 'Creation Date: ', joke.created_at),
                const SizedBox(
                  height: 10,
                ),
                buildRow(15, 'Last Update: ', joke.updated_at),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () async {
                    await _launchURL(joke.url);
                  },
                  child: const Text('Open it in Browser'),
                )
              ]))
    ]);
  }

  buildRow(double font, String title, String subtitle) {
    return RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(
                fontSize: font,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            children: [
          TextSpan(
            text: subtitle,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: font,
                color: Colors.black),
          ),
        ]));
  }

  _launchURL(String url) async {
    try {
      await launch(url);
    } catch (e) {
      print(e.toString());
    }
  }
}
