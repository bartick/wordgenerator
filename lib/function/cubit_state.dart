import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';

class RandomCubit extends Cubit<RandomState> {
  RandomCubit()
      : super(RandomState(savedWordPairs: <WordPair>{}, removedWordPairs: ''));

  void removeSavedWordPairs(WordPair wordPair) {
    state.savedWordPairs.remove(wordPair);
    emit(RandomState(
        savedWordPairs: state.savedWordPairs,
        removedWordPairs: wordPair.asPascalCase.toString()));
  }
}

class RandomState {
  Set<WordPair> savedWordPairs;
  String removedWordPairs;

  RandomState({required this.savedWordPairs, required this.removedWordPairs});
}
