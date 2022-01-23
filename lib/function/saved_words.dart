import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit_state.dart';

class SavedWords extends StatefulWidget {
  const SavedWords({Key? key}) : super(key: key);

  @override
  _SavedWordsState createState() => _SavedWordsState();
}

class _SavedWordsState extends State<SavedWords> {
  Widget _savedList() {
    return BlocBuilder<RandomCubit, RandomState>(
      builder: (context, state) {
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: state.savedWordPairs.length,
          itemBuilder: (context, item) {
            return _buildSavedList(state.savedWordPairs.elementAt(item));
          },
        );
      },
    );
  }

  Widget _buildSavedList(WordPair pair) {
    return ListTile(
        title: Text(pair.asPascalCase, style: const TextStyle(fontSize: 18.0)),
        trailing: const Icon(Icons.delete_forever, color: Colors.black),
        onTap: () {
          BlocProvider.of<RandomCubit>(context).removeSavedWordPairs(pair);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: BlocListener<RandomCubit, RandomState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.removedWordPairs +
                  ' has been removed from the saved list'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: _savedList(),
      ),
    );
  }
}
