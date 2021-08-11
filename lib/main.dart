import 'package:flutter/material.dart';
import 'package:postos_locais/pages/home_page.dart';
import 'package:postos_locais/repositories/postos_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<PostosRepository>(
      create: (_) => PostosRepository(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Postos Locais',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
    );
  }
}
