import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:prokedex_project/models/pokeapiv2.dart';
import 'package:prokedex_project/stores/pokeapi_store.dart';
import 'package:prokedex_project/stores/pokeapiv2_store.dart';

class AbaStatus extends StatelessWidget {
  final PokeApiStore _pokeApiStore = GetIt.instance<PokeApiStore>();
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();

  List<int> getStatusPokemon(PokeApiV2 pokeApiV2) {
    List<int> list = [1, 2, 3, 4, 5, 6];
    pokeApiV2.stats.forEach((f) {
      switch (f.stat.name) {
        case 'speed':
          list[0] = f.baseStat;
          break;
        case 'special-defense':
          list[1] = f.baseStat;
          break;
        case 'special-attack':
          list[2] = f.baseStat;
          break;
        case 'defense':
          list[3] = f.baseStat;
          break;
        case 'attack':
          list[4] = f.baseStat;
          break;
        case 'hp':
          list[5] = f.baseStat;
          break;
      }
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Observer(builder: (context) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Speed',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'sp. Def',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Sp.attak',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Defense',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Attak',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'HP',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Observer(builder: (context) {
                  List<int> _list = getStatusPokemon(_pokeApiV2Store.pokeApiV2);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _list[0].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        _list[1].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        _list[2].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        _list[3].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        _list[4].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        _list[5].toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }),
                SizedBox(
                  width: 15,
                ),
                Observer(builder: (context) {
                  List<int> _list = getStatusPokemon(_pokeApiV2Store.pokeApiV2);
                  return Column(
                    children: [
                      StatusBar(
                        widthFactor: _list[0] / 160,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      StatusBar(
                        widthFactor: _list[1] / 160,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      StatusBar(
                        widthFactor: _list[2] / 160,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      StatusBar(
                        widthFactor: _list[3] / 160,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      StatusBar(
                        widthFactor: _list[4] / 160,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      StatusBar(
                        widthFactor: _list[5] / 160,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class StatusBar extends StatelessWidget {
  final double widthFactor;

  const StatusBar({Key key, this.widthFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19,
      child: Center(
        child: Container(
          height: 10,
          width: MediaQuery.of(context).size.width * .4,
          alignment: Alignment.centerLeft,
          decoration:
              ShapeDecoration(shape: StadiumBorder(), color: Colors.grey),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1.0,
            child: Container(
              decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: widthFactor > 0.5 ? Colors.green : Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
