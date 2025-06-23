
import 'package:crud_hospital_app/presentation/pages/add_hospital_page.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final IconData?  icon;
  final VoidCallback press;
  DefaultButton({
    super.key, required this.text, this.icon, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.all(7)
      ),
      onPressed: 
        press
      , child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 25, color: Colors.white,),
        Text(text,style: TextStyle(
          fontSize: 25,
          color: Colors.white
        ),),
      ],
    ));
  }
}