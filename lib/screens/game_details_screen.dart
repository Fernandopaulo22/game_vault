import 'dart:io';

import 'package:flutter/material.dart';

import '../models/game_model.dart';

class GameDetailsScreen
    extends StatelessWidget {

  final GameModel game;

  const GameDetailsScreen({
    super.key,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFF121212),

      appBar: AppBar(

        backgroundColor:
            Colors.deepPurple,

        title: Text(game.title),
      ),

      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            game.imagePath != null &&
                    game.imagePath!
                        .isNotEmpty

                ? Image.file(

                    File(game.imagePath!),

                    width: double.infinity,

                    height: 250,

                    fit: BoxFit.cover,
                  )

                : Container(

                    height: 250,

                    color: Colors.grey[900],

                    child: const Center(

                      child: Icon(
                        Icons
                            .sports_esports,

                        color: Colors.white,

                        size: 80,
                      ),
                    ),
                  ),

            Padding(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(

                    game.title,

                    style:
                        const TextStyle(

                      color: Colors.white,

                      fontSize: 30,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  detailItem(
                    "Categoria",
                    game.category,
                  ),

                  detailItem(
                    "Raridade",
                    game.rarity,
                  ),

                  detailItem(
                    "Status",
                    game.status,
                  ),

                  detailItem(
                    "Condição",
                    game.condition,
                  ),

                  detailItem(
                    "Local",
                    game.location,
                  ),

                  detailItem(
                    "Valor Pago",
                    "R\$ ${game.paidValue}",
                  ),

                  detailItem(
                    "Valor Estimado",
                    "R\$ ${game.estimatedValue}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailItem(
    String title,
    String value,
  ) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 15,
      ),

      child: Container(

        width: double.infinity,

        padding:
            const EdgeInsets.all(15),

        decoration: BoxDecoration(

          color:
              const Color(0xFF1E1E1E),

          borderRadius:
              BorderRadius.circular(
            15,
          ),
        ),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Text(
              title,

              style: const TextStyle(
                color:
                    Colors.white70,

                fontSize: 14,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              value,

              style: const TextStyle(
                color: Colors.white,

                fontSize: 18,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}