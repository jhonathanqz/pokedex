import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/injection_container.dart';
import 'package:pokedex/pages/home_page/home_page.dart';

void main() {
  setupClient();
  setupStore();

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex - Youtube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Google',
        brightness: Brightness.light,
      ),
      home: HomePage(),
    );
  }
}
