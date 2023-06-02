import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:proyectofinal2/constants.dart';
import 'package:proyectofinal2/page/result_screen.dart';
import 'package:proyectofinal2/servicios/rickandmorty_manager.dart';
import 'package:proyectofinal2/servicios/Ubications.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final TextEditingController _nameController = TextEditingController();
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('cockteles');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['nombre'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;

                    if (name != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productss.add({
                          "nombre": name,
                        });
                      }

                      if (action == 'update') {
                        // Update the product
                        await _productss.doc(documentSnapshot!.id).update({
                          "nombre": name,
                        });
                      }

                      // Clear the text fields
                      _nameController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['nombre']),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                          IconButton(
                              icon: const Icon(Icons.slideshow_outlined),
                              onPressed: () async {
                                // if (documentSnapshot == null) return;
                                // documentSnapshot['nombre'].toLowerCase().replaceAll(' ', '_');

                                CocktailManager cm = CocktailManager();

                                var network = await get(Uri.parse(kMainUrl +
                                    documentSnapshot['nombre']
                                        .toLowerCase()
                                        .replaceAll(' ', '_')));

                                var json = jsonDecode(network.body);

                                cm.name = json['drinks'][0]['strDrink'];
                                cm.alcoholic =
                                    json['drinks'][0]['strAlcoholic'];
                                cm.glassType = json['drinks'][0]['strGlass'];
                                cm.pictureUrl =
                                    json['drinks'][0]['strDrinkThumb'];
                                cm.category = json['drinks'][0]['strCategory'];
                                cm.instructions =
                                    json['drinks'][0]['strInstructions'];

                                String strIngredientName, strIngredientMeasure;
                                List<Ingredient> ingrdientList = [];

                                for (int i = 1; i < 16; i++) {
                                  strIngredientName =
                                      'strIngredient' + i.toString();
                                  strIngredientMeasure =
                                      'strMeasure' + i.toString();
                                  ingrdientList.add(
                                    Ingredient(
                                        name: json['drinks'][0]
                                            [strIngredientName],
                                        mesure: json['drinks'][0]
                                            [strIngredientMeasure]),
                                  );
                                }

                                ingrdientList.removeWhere((element) =>
                                    element.name == null &&
                                    element.mesure == null);

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
                                        category: cm.category,
                                        alcoholic: cm.alcoholic,
                                        glassType: cm.glassType,
                                        pictureUrl: cm.pictureUrl,
                                        instructions: cm.instructions,
                                        ingredients: cm.ingredients);
                                  }),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),

      // body: FutureBuilder(
      //   future: getPeople(),
      //   builder: ((context, snapshot){
      //     return ListView.builder(
      //       itemCount: snapshot.data?.length,
      //       itemBuilder: (context, index) {
      //         return Text(snapshot.data?[index]['cockteles']);
      //       },
      //     );
      //   }
      //   )
      //   ),
    );
  }
}
