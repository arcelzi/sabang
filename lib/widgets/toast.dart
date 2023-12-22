import 'package:flutter/material.dart';


class CustomToast {
  static void show(BuildContext context, String message, {bool isSuccess = true}) {
    final overlay = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.85, // Atur posisi sesuai keinginan Anda
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSuccess ? Colors.green.withOpacity(0.7) : Colors.red.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlay);

    // Hapus toast setelah beberapa detik
    Future.delayed(Duration(seconds: 2), () {
      overlay.remove();
    });
  }
}