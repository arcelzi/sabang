import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> loading (
    context, GlobalKey key, String text 
  ) async {
    return showDialog(context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
          key: key,
          backgroundColor: Colors.black,
          children:<Widget> [
            Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(text,style: TextStyle(color: Colors.white),)
                ],
              ),
            )
          ],
        ),
        );
    });
  }

  static Future<void> popUp(context, String text) async {
    return showDialog(context: context, 
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text('Informasi'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(text),
            ]),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: const Text("OK"))
        ],
      );
    });
  }
} 