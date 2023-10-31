import 'package:flutter/material.dart';

Column photoMenu({required String text, required Icon icon, required Function() onTap}) {
  return Column(
    children: [
      Container(
        height: 42,
        width: 42,
        color: Colors.white,
        child: IconButton(
          onPressed: onTap, 
          icon: icon,
          color: Colors.black,
          ),
      ),
      const SizedBox(height: 4,),
      Text(text, style: TextStyle(color: Colors.black),)
    ],
  );
}