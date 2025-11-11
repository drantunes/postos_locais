# Google Maps e Geolocation

Exemplo de um projeto Flutter com Geolocalização e Google Maps.

## Configuração

### Android

A API Key do Google Maps é carregada dinamicamente durante o build do Android através de uma das seguintes opções:

1. **Variável de ambiente** (recomendado para CI/CD):
   ```bash
   export GOOGLE_MAPS_API_KEY="sua_api_key_aqui"
   flutter run
   ```

2. **Arquivo local.properties** (recomendado para desenvolvimento local):
   - Abra o arquivo `android/local.properties`
   - Adicione a linha:
     ```properties
     GOOGLE_MAPS_API_KEY=sua_api_key_aqui
     ```
   - O arquivo `local.properties` já está no `.gitignore` e não será commitado

### iOS

A API Key do Google Maps é carregada dinamicamente durante o build do iOS através de uma das seguintes opções:

1. **Variável de ambiente** (recomendado para CI/CD):
   ```bash
   export GOOGLE_MAPS_API_KEY="sua_api_key_aqui"
   flutter run
   ```

2. **Arquivo Config.xcconfig** (recomendado para desenvolvimento local):
   - Crie/edite o arquivo `ios/Config.xcconfig`
   - Adicione a linha:
     ```
     GOOGLE_MAPS_API_KEY = sua_api_key_aqui
     ```
   - O arquivo `Config.xcconfig` já está no `.gitignore` e não será commitado
   - Um arquivo de exemplo está disponível em `ios/Config.xcconfig.example`

### Web

Projeto Web não configurado. Basta acessar a documentação em: [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter#web)

### Obtendo a API Key do Google Maps

1. Acesse [Google Cloud Console](https://console.cloud.google.com/)
2. Crie ou selecione um projeto
3. Ative as APIs necessárias:
   - Maps SDK for Android
   - Maps SDK for iOS
4. Crie credenciais (API Key)
5. Configure as restrições da API Key conforme necessário

### Executar o projeto

```bash
flutter pub get
flutter run
```

### Testando no Simulador iOS

O simulador iOS não tem GPS real. Para testar a localização:

1. **Opção 1 - Configurar localização no simulador:**
   - No simulador, vá em: `Features > Location > Custom Location...`
   - Digite uma latitude e longitude (ex: `-23.5505, -46.6333` para São Paulo)
   - Ou escolha uma cidade pré-configurada em `Features > Location`

2. **Opção 2 - Usar localização padrão:**
   - O app usa automaticamente São Paulo como localização padrão se não conseguir obter a localização real
   - Aparecerá um aviso laranja no topo: "Usando localização padrão (simulador)"

**Dica:** No simulador, a primeira vez que o app solicitar permissão de localização, clique em "Allow While Using App"
