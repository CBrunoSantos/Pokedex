import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:prokedex_project/consts/consts_app.dart';
import 'package:prokedex_project/models/pokeapi.dart';
import 'package:prokedex_project/pages/home_page/widgets/app_bar_home.dart';
import 'package:prokedex_project/pages/home_page/widgets/poke_item.dart';
import 'package:prokedex_project/pages/poke_detail/poke_datail_page.dart';
import 'package:prokedex_project/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    if (_pokemonStore.pokeAPI == null) {
      _pokemonStore.fetchPokemonList();
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -85,
            left: screenWidth - (240 / 1.3),
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                ConstsApp.blackPokeball,
                height: 300,
                width: 300,
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: statusWidth,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Observer(
                      builder: (BuildContext context) {
                        PokeAPI _pokeApi = _pokemonStore.pokeAPI;
                        return (_pokeApi != null)
                            ? AnimationLimiter(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.all(12),
                                  addAutomaticKeepAlives: true,
                                  gridDelegate:
                                      new SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount:
                                      _pokemonStore.pokeAPI.pokemon.length,
                                  itemBuilder: (context, index) {
                                    Pokemon pokemon =
                                        _pokemonStore.getPokemon(index: index);
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: GestureDetector(
                                          child: PokeItem(
                                              types: pokemon.type,
                                              index: index,
                                              name: pokemon.name,
                                              num: pokemon.num),
                                          onTap: () {
                                            _pokemonStore.setPokemonAtual(
                                                index: index);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          PokeDetailPage(
                                                    index: index,
                                                  ),
                                                  fullscreenDialog: true,
                                                ));
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
