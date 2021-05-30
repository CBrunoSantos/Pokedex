import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prokedex_project/stores/pokeapi_store.dart';

class CircularProgressAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                GetIt.instance<PokeApiStore>().corPokemon),
          ),
        ),
      ),
    );
  }
}
