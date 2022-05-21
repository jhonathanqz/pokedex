import 'package:get_it/get_it.dart';
import 'package:pokedex/app/client_factory.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:pokedex/stores/pokeapiv2_store.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Future<void> setupClient() async {
  final client = ClientFactory.baseClient;
  //client.options.baseUrl = '$host:$port';
  //client.options.headers = {
  //  'Authorization': 'Bearer static:$token',
  //};
  client.options.followRedirects = false;
  client.options.connectTimeout = 20 * 1000;
  client.options.receiveTimeout = 20 * 2000;
  client.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
}

GetIt getIt = GetIt.instance;
void setupStore() {
  setupClient();
  getIt.registerSingleton<PokeApiStore>(PokeApiStore(
    client: ClientFactory.baseClient,
  ));
  getIt.registerSingleton<PokeApiV2Store>(PokeApiV2Store(
    client: ClientFactory.baseClient,
  ));
  setupClient();
}
