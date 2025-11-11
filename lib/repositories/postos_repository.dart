import 'package:postos_locais/models/posto.dart';

class PostosRepository {
  final List<Posto> _postos = [
    Posto(
      nome: 'Posto Cinco Primos',
      endereco: 'Rua Anita Garibaldi, 1000 - Órfãs, Ponta Grossa - PR, 84015-050',
      foto:
          'https://lh5.googleusercontent.com/p/AF1QipP_xnSi5-sp9slSuMpSx-JlmvwvHGL1VJ_JcOGX=w408-h306-k-no',
      latitude: -25.0800458,
      longitude: -50.166821,
    ),
  ];

  List<Posto> get postos => _postos;
}
