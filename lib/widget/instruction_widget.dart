import 'package:flutter/material.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
// ignore: implementation_imports, unused_import
import 'package:flutter/src/widgets/placeholder.dart';

import '../constants.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({super.key, required this.instructions});
  final String instructions;
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
        children: [
          const Text(
            "Ubicaciones",
            style: kTableTextStyle,
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(instructions),
          ))
        ],
      ),
    );
  }
}
