import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/core/observers/bloc_observer.dart';
import 'package:gym/core/services/di.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  await initLocator();

  Bloc.observer = MyBlocObserver();

  runApp(
    const GymApp(),
  );
}
