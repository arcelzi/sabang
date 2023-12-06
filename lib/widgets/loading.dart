import 'package:avicenna/avicenna.dart';

showLoadingDialogNotdismissible(context){
  showAvicennaDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: const Duration(milliseconds: 400), 
    child: const AvicennaLoadingDialog()
  );
}