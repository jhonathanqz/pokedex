import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  final Dio client;

  _PokeApiStoreBase({
    @required this.client,
  });

  @observable
  PokeAPI _pokeAPI;

  @observable
  Pokemon _pokemonAtual;

  @observable
  dynamic corPokemon;

  @observable
  int posicaoAtual;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  Pokemon get pokemonAtual => _pokemonAtual;

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  Pokemon getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }

  @action
  setPokemonAtual({int index}) {
    _pokemonAtual = _pokeAPI.pokemon[index];
    corPokemon = ConstsApp.getColorType(type: _pokemonAtual.type[0]);
    posicaoAtual = index;
  }

  @action
  Widget getImage({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await client.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.data);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }
}
