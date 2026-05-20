import 'dart:io';

import 'package:flutter/material.dart';
import 'package:game_vault/models/game_model.dart';
import 'package:game_vault/screens/add_game_screen.dart';
import 'package:game_vault/screens/edit_game_screen.dart';
import 'package:game_vault/screens/game_details_screen.dart';
import 'package:game_vault/services/game_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameVault',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final GameService _gameService =
      GameService();

  List<GameModel> games = [];

  String searchText = "";

  String selectedFilter =
      "Todos";

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  void loadGames() async {

    final loadedGames =
        await _gameService.getGames();

    setState(() {

      games = loadedGames;

    });
  }

  void deleteGame(int id) async {

    await _gameService.deleteGame(id);

    loadGames();
  }

  @override
  Widget build(BuildContext context) {

    List<GameModel> filteredGames =
        games.where((game) {

      final matchesSearch =
          game.title
              .toLowerCase()
              .contains(
                searchText
                    .toLowerCase(),
              );

      final matchesFilter =
          selectedFilter ==
                  "Todos"

              ? true

              : game.status ==
                  selectedFilter;

      return matchesSearch &&
          matchesFilter;

    }).toList();

    int collectionCount = games
        .where((game) =>
            game.status == "Na coleção")
        .length;

    int wishCount = games
        .where((game) =>
            game.status == "Desejado")
        .length;

    int soldCount = games
        .where((game) =>
            game.status == "Vendido")
        .length;

    int borrowedCount = games
        .where((game) =>
            game.status ==
                "Emprestado")
        .length;

    int rareCount = games
        .where((game) =>
            game.rarity == "Raro")
        .length;

    double totalValue = games.fold(
      0,
      (sum, game) =>
          sum + game.paidValue,
    );

    return Scaffold(

      backgroundColor:
          const Color(0xFF121212),

      appBar: AppBar(

        backgroundColor:
            Colors.deepPurple,

        elevation: 0,

        title: const Text(
          "GameVault",
        ),

        centerTitle: true,
      ),

      body: SafeArea(

        child: Padding(

          padding:
              const EdgeInsets.all(16),

          child: Column(
            children: [

              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFF6A11CB),
                      Color(0xFF2575FC),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    25,
                  ),

                  boxShadow: const [

                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.sports_esports,
                          color: Colors.white,
                          size: 30,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "GameVault",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "${games.length} jogos cadastrados",

                      style:
                          const TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "R\$ ${totalValue.toStringAsFixed(2)}",

                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Valor total da coleção",

                      style: TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [

                  Expanded(
                    child: dashboardCard(
                      "Coleção",
                      collectionCount.toString(),
                      Colors.green,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: dashboardCard(
                      "Desejados",
                      wishCount.toString(),
                      Colors.orange,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: dashboardCard(
                      "Vendidos",
                      soldCount.toString(),
                      Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Row(
                children: [

                  Expanded(
                    child: dashboardCard(
                      "Emprestados",
                      borrowedCount.toString(),
                      Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: dashboardCard(
                      "Raros",
                      rareCount.toString(),
                      Colors.purple,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextField(

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(

                  hintText:
                      "Pesquisar jogo...",

                  hintStyle:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),

                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),

                  filled: true,

                  fillColor:
                      Colors.grey[900],

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),

                    borderSide:
                        BorderSide.none,
                  ),
                ),

                onChanged: (value) {

                  setState(() {

                    searchText = value;

                  });
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(

                value: selectedFilter,

                dropdownColor:
                    Colors.grey[900],

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: InputDecoration(

                  filled: true,

                  fillColor:
                      Colors.grey[900],

                  border:
                      OutlineInputBorder(

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),

                    borderSide:
                        BorderSide.none,
                  ),
                ),

                items: const [

                  DropdownMenuItem(
                    value: "Todos",
                    child: Text("Todos"),
                  ),

                  DropdownMenuItem(
                    value: "Na coleção",
                    child:
                        Text("Na coleção"),
                  ),

                  DropdownMenuItem(
                    value: "Desejado",
                    child:
                        Text("Desejado"),
                  ),

                  DropdownMenuItem(
                    value: "Vendido",
                    child:
                        Text("Vendido"),
                  ),

                  DropdownMenuItem(
                    value: "Emprestado",
                    child:
                        Text("Emprestado"),
                  ),

                  DropdownMenuItem(
                    value: "Trocado",
                    child:
                        Text("Trocado"),
                  ),
                ],

                onChanged: (value) {

                  setState(() {

                    selectedFilter =
                        value!;

                  });
                },
              ),

              const SizedBox(height: 20),

              Expanded(

                child: filteredGames.isEmpty

                    ? const Center(
                        child: Text(
                          "Nenhum jogo encontrado",

                          style: TextStyle(
                            color:
                                Colors.white,
                          ),
                        ),
                      )

                    : ListView.builder(

                        itemCount:
                            filteredGames
                                .length,

                        itemBuilder:
                            (context, index) {

                          final game =
                              filteredGames[
                                  index];

                          return Container(

                            margin:
                                const EdgeInsets.only(
                              bottom: 15,
                            ),

                            decoration:
                                BoxDecoration(

                              color:
                                  const Color(
                                0xFF1E1E1E,
                              ),

                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),

                              boxShadow: const [

                                BoxShadow(
                                  color:
                                      Colors.black26,

                                  blurRadius:
                                      6,

                                  offset:
                                      Offset(
                                    0,
                                    4,
                                  ),
                                ),
                              ],
                            ),

                            child: ListTile(

                              onTap: () {

                                Navigator.push(

                                  context,

                                  MaterialPageRoute(
                                    builder: (_) =>
                                        GameDetailsScreen(
                                      game: game,
                                    ),
                                  ),
                                );
                              },

                              contentPadding:
                                  const EdgeInsets.all(
                                12,
                              ),

                              leading:
                                  game.imagePath !=
                                              null &&
                                          game
                                              .imagePath!
                                              .isNotEmpty

                                      ? ClipRRect(

                                          borderRadius:
                                              BorderRadius.circular(
                                            15,
                                          ),

                                          child:
                                              Image.file(

                                            File(
                                              game.imagePath!,
                                            ),

                                            width:
                                                60,

                                            height:
                                                60,

                                            fit: BoxFit
                                                .cover,
                                          ),
                                        )

                                      : Container(

                                          padding:
                                              const EdgeInsets.all(
                                            10,
                                          ),

                                          decoration:
                                              BoxDecoration(

                                            color: Colors
                                                .deepPurple,

                                            borderRadius:
                                                BorderRadius.circular(
                                              15,
                                            ),
                                          ),

                                          child:
                                              const Icon(
                                            Icons
                                                .sports_esports,

                                            size: 30,

                                            color: Colors
                                                .white,
                                          ),
                                        ),

                              title: Text(
                                game.title,

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight.bold,

                                  fontSize: 18,
                                ),
                              ),

                              subtitle:
                                  Padding(

                                padding:
                                    const EdgeInsets.only(
                                  top: 8,
                                ),

                                child: Text(

                                  "${game.category} • ${game.rarity} • ${game.status}",

                                  style:
                                      const TextStyle(
                                    color: Colors
                                        .white70,
                                  ),
                                ),
                              ),

                              trailing:
                                  SizedBox(

                                width: 120,

                                child: Column(

                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,

                                  children: [

                                    Text(
                                      "R\$ ${game.paidValue}",

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight.bold,

                                        color: Colors
                                            .greenAccent,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 5,
                                    ),

                                    Row(

                                      mainAxisAlignment:
                                          MainAxisAlignment.end,

                                      children: [

                                        IconButton(

                                          onPressed:
                                              () async {

                                            final result =
                                                await Navigator.push(

                                              context,

                                              MaterialPageRoute(
                                                builder:
                                                    (_) =>
                                                        EditGameScreen(
                                                  game:
                                                      game,
                                                ),
                                              ),
                                            );

                                            if (result ==
                                                true) {

                                              loadGames();
                                            }
                                          },

                                          icon:
                                              const Icon(
                                            Icons.edit,

                                            color:
                                                Colors.blue,
                                          ),
                                        ),

                                        IconButton(

                                          onPressed:
                                              () {

                                            deleteGame(
                                              game.id!,
                                            );
                                          },

                                          icon:
                                              const Icon(
                                            Icons.delete,

                                            color:
                                                Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton:
          FloatingActionButton(

        backgroundColor:
            Colors.deepPurple,

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

        onPressed: () async {

          final result =
              await Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) =>
                  const AddGameScreen(),
            ),
          );

          if (result == true) {

            loadGames();
          }
        },
      ),
    );
  }

  Widget dashboardCard(
    String title,
    String value,
    Color color,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: color,

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: Column(

        children: [

          Text(
            value,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,

            textAlign:
                TextAlign.center,

            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}