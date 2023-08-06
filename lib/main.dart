import 'package:bloc/bloc.dart';
import 'package:bloc_infinite_list/simple_bloc_observer.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(const MyApp());
}