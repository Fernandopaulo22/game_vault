import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/game_model.dart';
import '../services/game_service.dart';

class AddGameScreen extends StatefulWidget {
  const AddGameScreen({super.key});

  @override
  State<AddGameScreen> createState() =>
      _AddGameScreenState();
}

class _AddGameScreenState
    extends State<AddGameScreen> {

  final titleController =
      TextEditingController();

  final categoryController =
      TextEditingController();

  final rarityController =
      TextEditingController();

  final valueController =
      TextEditingController();

  final GameService _gameService =
      GameService();

  String selectedStatus =
      "Na coleção";

  File? selectedImage;

  Future<void> pickImage() async {

    final picked =
        await ImagePicker()
            .pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {

      setState(() {

        selectedImage =
            File(picked.path);

      });
    }
  }

  void saveGame() async {

    final game = GameModel(

      title: titleController.text,

      category:
          categoryController.text,

      rarity:
          rarityController.text,

      status: selectedStatus,

      condition: "Novo",

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

      location: "Estante",

      imagePath:
          selectedImage?.path ?? "",
    );

    await _gameService.insertGame(
      game,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFF121212),

      appBar: AppBar(

        backgroundColor:
            Colors.deepPurple,

        title: const Text(
          "Adicionar Jogo",
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            GestureDetector(

              onTap: pickImage,

              child: Container(

                height: 180,
                width: double.infinity,

                decoration: BoxDecoration(

                  color: Colors.grey[900],

                  borderRadius:
                      BorderRadius.circular(
                    20,
                  ),
                ),

                child: selectedImage == null

                    ? const Column(

                        mainAxisAlignment:
                            MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 60,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Selecionar capa",

                            style: TextStyle(
                              color:
                                  Colors.white70,
                            ),
                          ),
                        ],
                      )

                    : ClipRRect(

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            buildTextField(
              titleController,
              "Nome do jogo",
            ),

            const SizedBox(height: 15),

            buildTextField(
              categoryController,
              "Categoria",
            ),

            const SizedBox(height: 15),

            buildTextField(
              rarityController,
              "Raridade",
            ),

            const SizedBox(height: 15),

            buildTextField(
              valueController,
              "Valor pago",
              isNumber: true,
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField(

              value: selectedStatus,

              dropdownColor:
                  Colors.grey[900],

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration:
                  inputDecoration(
                "Status",
              ),

              items: const [

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
                  value: "Emprestado",
                  child:
                      Text("Emprestado"),
                ),

                DropdownMenuItem(
                  value: "Vendido",
                  child:
                      Text("Vendido"),
                ),

                DropdownMenuItem(
                  value: "Trocado",
                  child:
                      Text("Trocado"),
                ),
              ],

              onChanged: (value) {

                setState(() {

                  selectedStatus =
                      value!;

                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.deepPurple,

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                      15,
                    ),
                  ),
                ),

                onPressed: saveGame,

                child: const Text(
                  "Salvar Jogo",

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String hint, {
    bool isNumber = false,
  }) {

    return TextField(

      controller: controller,

      keyboardType: isNumber
          ? TextInputType.number
          : TextInputType.text,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration:
          inputDecoration(hint),
    );
  }

  InputDecoration inputDecoration(
      String hint) {

    return InputDecoration(

      hintText: hint,

      hintStyle: const TextStyle(
        color: Colors.white70,
      ),

      filled: true,

      fillColor: Colors.grey[900],

      border: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(15),

        borderSide: BorderSide.none,
      ),
    );
  }
}