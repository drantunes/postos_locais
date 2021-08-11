import 'package:flutter/material.dart';
import 'package:postos_locais/repositories/postos_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Local'),
      ),
      body: Center(
        child: Text(
          'Latitude: | Logitude',
        ),
      ),
    );
  }
}
