import 'package:flutter/material.dart';
import 'package:word_generator/function/cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'function/random_words.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RandomCubit>(
      create: (context) => RandomCubit(),
      child: MaterialApp(
        title: 'Name Generator',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: const RandomWords(),
      ),
    );
  }
}
