import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsms_admin/firebase_options.dart';
import 'package:tsms_admin/home/home.dart';
import 'package:tsms_admin/manager/firebase-init/init_firebase_bloc.dart';
import 'package:tsms_admin/manager/get-version/get_version_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Base());
}

class Base extends StatelessWidget {
  const Base({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetVersionBloc(),
        ),
        BlocProvider(
          create: (context) => InitFirebaseBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
        ),
        home: Home(),
      ),
    );
  }
}
