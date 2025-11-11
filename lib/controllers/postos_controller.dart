import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:postos_locais/pages/postos_page.dart';
import 'package:postos_locais/repositories/postos_repository.dart';
import 'package:postos_locais/widgets/posto_detalhes.dart';

class PostosController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  Set<Marker> markers = <Marker>{};
  late GoogleMapController _mapsController;

  // PostosController() {
  //   getPosicao();
  // }
  get mapsController => _mapsController;

  limparErro() {
    erro = '';
    notifyListeners();
  }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
    loadPostos();
  }

  loadPostos() async {
    final postos = PostosRepository().postos;

    BitmapDescriptor customIcon;
    try {
      customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(48, 48)),
        'images/posto.png',
      );
    } catch (e) {
      // Fallback para o ícone padrão se houver erro ao carregar a imagem
      customIcon = BitmapDescriptor.defaultMarker;
      print('Erro ao carregar ícone customizado: $e');
    }

    for (var posto in postos) {
      markers.add(
        Marker(
          markerId: MarkerId(posto.nome),
          position: LatLng(posto.latitude, posto.longitude),
          icon: customIcon,
          onTap: () => {
            showModalBottomSheet(
              context: appKey.currentState!.context,
              builder: (context) => PostoDetalhes(posto: posto),
            ),
          },
        ),
      );
    }
    notifyListeners();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      _mapsController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, long), zoom: 18),
        ),
      );
    } catch (e) {
      erro = e.toString();
      // Se houver erro (ex: simulador sem localização configurada),
      // usa localização padrão (São Paulo)
      lat = -23.5505;
      long = -46.6333;
      print('Erro ao obter localização: $e. Usando localização padrão.');
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    // Adiciona timeout de 10 segundos para não ficar travado no simulador
    return await Geolocator.getCurrentPosition(
      timeLimit: const Duration(seconds: 10),
    );
  }
}
