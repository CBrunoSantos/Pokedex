import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prokedex_project/pages/home_page/home_page.dart';
import 'package:prokedex_project/stores/pokeapi_store.dart';
import 'package:prokedex_project/stores/pokeapiv2_store.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<PokeApiStore>(PokeApiStore());
  getIt.registerSingleton<PokeApiV2Store>(PokeApiV2Store());
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       child: MaterialApp(
//         title: 'Pokedex',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: HomePage(),
//       ),
//       providers: <SingleChildWidget>[
//         Provider<PokeApiStore>(
//           create: (_) => PokeApiStore(),
//         ),
//       ],
//     );
//   }
// }
