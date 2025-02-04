import 'package:flutter/material.dart';

class VeryLargeInsertCamp extends StatelessWidget {
  final TextEditingController controller;

  const VeryLargeInsertCamp({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(180.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: TextField(
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.justify,
                textInputAction: TextInputAction.newline,
                
                decoration: InputDecoration(
                  border: InputBorder.none,
                  
                  hintText: '',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 15.0), 
                ),
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 18, color: Colors.grey[900]),
              ),
            ),
          );
        },
      ),
    );
  }
}
