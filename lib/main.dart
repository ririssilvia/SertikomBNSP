import 'package:flutter/material.dart';
import 'package:mycashbook/helpers/db_acc_provider.dart';
import 'package:mycashbook/helpers/db_provider.dart';
import 'package:mycashbook/pages/Authentication.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<DBProvider>(create: (_) => DBProvider()),
        ListenableProvider<AccProvider>(create: (_) => AccProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: AuthPage()),
    );
  }
}
