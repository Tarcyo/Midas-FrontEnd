import 'package:flutter/material.dart';
import 'package:midas/reusableWidgets/veryLargeFixedCamp.dart';

class OtherMessage extends StatelessWidget {
  final String text;

  OtherMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Alinha à esquerda
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                Colors.grey[600], // Cor diferente para diferenciar do usuário
          ),
          padding: EdgeInsets.all(18),
          child: Icon(
            Icons.person,
            size: 25,
            color: Colors.white,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 16.0),
            child: VeryLargeFixedTextWidget(
              text: text,
            ),
          ),
        ),
      ],
    );
  }
}
