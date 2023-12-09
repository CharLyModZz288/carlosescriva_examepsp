import 'package:carlosescriva_examepsp/Examen.dart';
import 'package:carlosescriva_examepsp/Singletone/DataHolder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DataHolder().initDataHolder();
  Examen examen=Examen();
  runApp(examen);
}