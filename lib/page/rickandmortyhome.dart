import 'dart:convert';
import 'package:proyectofinal2/page/result_screen.dart';
import 'package:proyectofinal2/servicios/rickandmorty_manager.dart';
import 'package:proyectofinal2/servicios/Ubications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../constants.dart';

class Cocktail_Home extends StatefulWidget {
  const Cocktail_Home({super.key});

  @override
  State<Cocktail_Home> createState() => _Cocktail_HomeState();
}

class _Cocktail_HomeState extends State<Cocktail_Home> {
  late String RickandMortyName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 100,
                ),
                //logo text
                const Center(
                  child: Text(
                    "RICK AND MORTY",
                    style: TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
                //Text input
                TextField(
                  onChanged: (value) {
                    RickandMortyName = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "¿Nombre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 69, 125, 255),
                            width: 5)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 69, 125, 255),
                            width: 5)),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                //Search button
                ElevatedButton(
                  onPressed: () async {
                    // ignore: unnecessary_null_comparison
                    if (RickandMortyName == null) return;
                    RickandMortyName.toLowerCase().replaceAll(' ', '_');

                    RickandMortyManager cm = RickandMortyManage();

                    var network =
                        await get(Uri.parse(kMainUrl + RickandMortyName));

                    var json = jsonDecode(network.body);
                    cm.name = json['user'][0]['strName'];
                    cm.status = json['user'][0]['strStatus'];
                    cm.species = json['user'][0]['strSpecies'];
                    cm.type = json['user'][0]['strType'];
                    cm.gender = json['user'][0]['strgender'];

                    String strName, strMeasure;
                    List<Ubications> ingrdientList = [];

                    for (int i = 1; i < 16; i++) {
                      strtName = 'strIngredient' + i.toString();
                      strIngredientMeasure = 'strMeasure' + i.toString();
                      ingrdientList.add(
                        Ubications(
                            name: json['Rick'][0][strIngredientName],
                            mesure: json['Good'][0][strIngredientMeasure]),
                      );
                    }

                    ingrdientList.removeWhere((element) =>
                        element.name == null && element.mesure == null);

                    ingrdientList.forEach((element) {
                      if (element.mesure == null) {
                        element.mesure == ' ';
                      }
                    });
                    cm.ingredients = ingrdientList;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ResultScreen(
                            name: cm.name,
                            status: cm.status,
                            species: cm.species,
                            tyoe: cm.type,
                            gender: cm.gender);
                      }),
                    );
                  },
                  child: const Text("Buscar"),
                  style: ElevatedButton.styleFrom(
                    primary: kComponentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: kButtonMinSize,
                  ),
                ),

                //Random button
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    CocktailManager cm = CocktailManager();
                    var network = await get(Uri.parse(kRandomURL));

                    var json = jsonDecode(network.body);

                    cm.name = json['user'][0]['strName'];
                    cm.status = json['user'][0]['strStatus'];
                    cm.species = json['user'][0]['strSpecies'];
                    cm.type = json['user'][0]['strType'];
                    cm.gender = json['user'][0]['strgender'];

                    String strIngredientName, strIngredientMeasure;
                    List<Ingredient> ingrdientList = [];

                    for (int i = 1; i < 16; i++) {
                      strIngredientName = 'strIngredient' + i.toString();
                      strIngredientMeasure = 'strMeasure' + i.toString();
                      ingrdientList.add(
                        Ingredient(
                            name: json['drinks'][0][strIngredientName],
                            mesure: json['drinks'][0][strIngredientMeasure]),
                      );
                    }

                    ingrdientList.removeWhere((element) =>
                        element.name == null && element.mesure == null);

                    ingrdientList.forEach((element) {
                      if (element.mesure == null) {
                        element.mesure == ' ';
                      }
                    });
                    cm.ingredients = ingrdientList;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ResultScreen(
                            name: cm.name,
                            status: cm.status,
                            species: cm.species,
                            type: cm.type,
                            gender: cm.gender);
                      }),
                    );
                  },
                  child: const Text("Al azar"),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 69, 125, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: const Size(100, 50),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
