import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapiv2.dart';
import 'package:pokedex/models/specie.dart';
part 'pokeapiv2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  final Dio client;
  _PokeApiV2StoreBase({
    @required this.client,
  });
  @observable
  Specie specie;

  @observable
  PokeApiV2 pokeApiV2;

  @action
  Future<void> getInfoPokemon(String nome) async {
    try {
      final response =
          await client.get(ConstsAPI.pokeapiv2URL + nome.toLowerCase());
      var decodeJson = jsonDecode(response.data);
      print('***decode info: $decodeJson');
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
      print('****from: ${pokeApiV2.toJson()}');
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecie(String numPokemon) async {
    try {
      specie = null;
      final response =
          await client.get(ConstsAPI.pokeapiv2EspeciesURL + numPokemon);
      var decodeJson = jsonDecode(response.data);
      print('***decode: ${decodeJson}');
      var _specie = Specie.fromJson(decodeJson);
      print('**_specie: ${_specie.toJson()}');
      specie = _specie;
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
