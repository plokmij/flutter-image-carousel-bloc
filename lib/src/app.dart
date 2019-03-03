import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'blocs/imageprovider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context){
    return Provider(
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}