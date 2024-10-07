import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/screens/main_screen.dart';
import 'package:todolist/screens/welcome_screen.dart';
import 'providers/task_provider.dart';
import 'helpers/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize path_provider
  await getApplicationDocumentsDirectory();

  // Initialize database
  await DatabaseHelper.instance.database;

  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        useMaterial3: true
        //primarySwatch: Colors.green,
        //: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}