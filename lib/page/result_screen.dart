import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectofinal2/servicios/Ubications.dart';
import 'package:proyectofinal2/widget/ubication_widget.dart';
import 'package:proyectofinal2/widget/instruction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants.dart';

class ResultScreen extends StatelessWidget {
  final String? name;
  final String? stuatus;
  final String? ;
  final String? glassType;
  final String? pictureUrl;
  final String? instructions;
  final List<Ingredient>? ingredients;
  final user = FirebaseAuth.instance.currentUser!;
  ResultScreen(
      {required this.name,
      required this.status,
      required this.type,
      required this.glassType,
      required this.pictureUrl,
      required this.instructions,
      required this.ingredients});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                name!,
                style: kHeaderTextStyle,
              ),
            ),

            //detalles de cocktail
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 40,
              decoration: BoxDecoration(
                color: kGroupBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(category!),
                  Text('-'),
                  Text(status!),
                  Text('-'),
                  Text(type!),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            //imagen de cocktail
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(pictureUrl!),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            //ingredientes de cocktail
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: kBoxDecorationStyle,
              child: IngredientWidget(ingredientList: ingredients!),
            ),
            SizedBox(
              height: 20,
            ),
            //instrucciones
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 200,
              decoration: kBoxDecorationStyle,
              child: InstructionWidget(
                instructions: instructions!,
              ),
            ),

            SizedBox(
              height: 20,
            ),
            //boton de retorno
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Return"),
                style: ElevatedButton.styleFrom(
                    primary: kComponentColor,
                    minimumSize: kButtonMinSize,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
