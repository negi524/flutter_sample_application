import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample_application/main.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    List<WordPair> favorites = appState.favorites;

    int favoriteCount = favorites.length;
    Text favoriteCountText;
    if (favoriteCount <= 0) {
      favoriteCountText = Text('No favorites yet.');
    } else {
      favoriteCountText = Text('You have $favoriteCount favorites:');
    }

    // お気に入りした単語のリストをTextウィジェットに変換する
    List<ListTile> favoriteTextList = favorites
        .map((e) => ListTile(
              leading: Icon(Icons.favorite),
              title: Text(e.asLowerCase),
            ))
        .toList();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: favoriteCountText,
        ),
        ...favoriteTextList
      ],
    );
  }
}
