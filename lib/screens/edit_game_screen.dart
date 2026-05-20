import 'package:flutter/material.dart';
import 'package:game_vault/models/game_model.dart';
import 'package:game_vault/services/game_service.dart';

class EditGameScreen extends StatefulWidget {

  final GameModel game;

  const EditGameScreen({
    super.key,
    required this.game,
  });

  @override
  State<EditGameScreen> createState() =>
      _EditGameScreenState();
}

class _EditGameScreenState
    extends State<EditGameScreen> {

  late TextEditingController titleController;
  late TextEditingController categoryController;
  late TextEditingController rarityController;
  late TextEditingController valueController;

  final GameService _gameService =
      GameService();

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
      text: widget.game.title,
    );

    categoryController =
        TextEditingController(
      text: widget.game.category,
    );

    rarityController =
        TextEditingController(
      text: widget.game.rarity,
    );

    valueController =
        TextEditingController(
      text: widget.game.paidValue.toString(),
    );
  }

  void updateGame() async {

    final updatedGame = GameModel(
      id: widget.game.id,
      title: titleController.text,
      category: categoryController.text,
      rarity: rarityController.text,
      status: widget.game.status,
      condition: widget.game.condition,
      paidValue:
          double.tryParse(
                valueController.text,
              ) ??
              0,

      estimatedValue:
          double.tryParse(
                valueController.text,
              ) ??
              0,

      location: widget.game.location,
      imagePath: widget.game.imagePath,
    );

    await _gameService.updateGame(
      updatedGame,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Editar Jogo",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: titleController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Nome do jogo",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  categoryController,

              decoration:
                  const InputDecoration(
                labelText: "Categoria",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  rarityController,

              decoration:
                  const InputDecoration(
                labelText: "Raridade",
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  valueController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText: "Valor",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: updateGame,

              child:
                  const Text("Atualizar"),
            ),
          ],
        ),
      ),
    );
  }
}