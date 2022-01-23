import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './saved_words.dart';
import 'cubit_state.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[]; // Array of WordPair

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return const Divider();

        final index = item ~/ 2;

        if (index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    return BlocBuilder<RandomCubit, RandomState>(
      builder: (context, state) {
        final alreadySaved = state.savedWordPairs.contains(pair);
        return ListTile(
            title:
                Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
            trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.purple : null),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  state.savedWordPairs.remove(pair);
                } else {
                  state.savedWordPairs.add(pair);
                }
              });
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text('WordPair Generator'), actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const SavedWords(),
              ));
            },
          )
        ]),
        body: _buildList());
  }
}
