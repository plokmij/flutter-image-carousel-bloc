import 'package:flutter/material.dart';
import 'imagebloc.dart';
export 'imagebloc.dart';

class Provider extends InheritedWidget{
  final bloc = ImageBloc();

  Provider({Key key, Widget child}) :super(key:key,child:child);

  bool updateShouldNotify(_) => true;

  static ImageBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}