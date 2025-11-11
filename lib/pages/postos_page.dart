import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:postos_locais/controllers/postos_controller.dart';
import 'package:provider/provider.dart';

final appKey = GlobalKey();

class PostosPage extends StatelessWidget {
  const PostosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: appKey,
      appBar: AppBar(
        title: const Text('Postos'),
      ),
      body: ChangeNotifierProvider<PostosController>(
        create: (context) => PostosController(),
        child: Builder(
          builder: (context) {
            final local = context.watch<PostosController>();

            // Se ainda não tem localização, mostra loading
            if (local.lat == 0.0 && local.long == 0.0 && local.erro.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Carregando sua localização...'),
                  ],
                ),
              );
            }

            // Se houver erro e ainda não tem localização padrão, mostra a mensagem
            if (local.erro.isNotEmpty && local.lat == 0.0 && local.long == 0.0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      local.erro,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => local.getPosicao(),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(local.lat, local.long),
                    zoom: 18,
                  ),
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: local.onMapCreated,
                  markers: local.markers,
                ),
                // Se houver erro mas já tem localização padrão, mostra aviso
                if (local.erro.isNotEmpty && local.lat != 0.0)
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.orange),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Usando localização padrão (simulador)',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () => local.limparErro(),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
