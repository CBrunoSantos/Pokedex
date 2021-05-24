import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:prokedex_project/consts/consts_api.dart';
import 'package:prokedex_project/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeAPI _pokeAPI;

  @observable
  Pokemon pokemonAtual;

  @observable
  dynamic _corPokemonAtual;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  PokeAPI get corPokemonAtual => _corPokemonAtual;

  @action
  fetchPokemonList() {
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  @action
  getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }

  @action
  setPokemonAtual({int index}) {
    pokemonAtual = _pokeAPI.pokemon[index];
    _corPokemonAtual = ConstsAPI.getColorType(type: pokemonAtual.type[0]);
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
      final response = await http.get(Uri.parse(ConstsAPI.pokeapiURL));
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error) {
      print("erro al carregar a lista");
      return null;
    }
  }
}
