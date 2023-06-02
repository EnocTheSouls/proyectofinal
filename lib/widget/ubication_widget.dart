import 'package:proyectofinal2/constants.dart';
import 'package:proyectofinal2/servicios/Ubications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UbicationWidget extends StatelessWidget {
  UbicationWidget({required this.ingredientList});
  final List<Ubications> ingredientList;

  Widget CreateTable() {
    List<TableRow> rows = [];

    for (int i = 0; i < ingredientList.length; i++) {
      rows.add(TableRow(children: [
        Center(
          child: Text(ingredientList[i].name!),
        ),
        Center(
          child: Text(ingredientList[i].mesure!),
        )
      ]));
    }
    return Table(children: rows);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Ubicacion",
          style: kTableTextStyle,
        ),
        const SizedBox(
          height: 30,
        ),
        Expanded(
            child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: CreateTable(),
        ))
      ],
    );
  }
}
