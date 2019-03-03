import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ImageBloc {
  final _image =BehaviorSubject<int>();

  Stream<int> get image => _image.stream;

  Function(int) get changeImage => _image.sink.add;
}