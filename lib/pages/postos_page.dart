import 'package:flutter/material.dart';
import 'package:postos_locais/controllers/postos_controller.dart';
import 'package:provider/provider.dart';

class PostosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Local'),
      ),
      body: ChangeNotifierProvider<PostosController>(
        create: (context) => PostosController(),
        child: Builder(builder: (context) {
          final local = context.watch<PostosController>();

          String mensagem = local.erro == ''
              ? 'Latitude: ${local.lat} | Longitude: ${local.long}'
              : local.erro;

          return Center(child: Text(mensagem));
        }),
      ),
    );
  }
}
