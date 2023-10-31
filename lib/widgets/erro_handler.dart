import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/http.dart';

errorDialogHandler({required BuildContext context, required HTTPResponseStatus status, String? info}){
  switch(status){
    case HTTPResponseStatus.success:
      break;
    case HTTPResponseStatus.failed:
      return dialogTemplate(
        context: context,
        info: info, 
        defaultInfo: 'Terjadi kesalahan'
      );
    case HTTPResponseStatus.timeout:
      return dialogTemplate(
        context: context,
        info: info, 
        defaultInfo: 'Timeout'
      );
    case HTTPResponseStatus.error:
      return dialogTemplate(
        context: context,
        info: info, 
        defaultInfo: 'Terjadi kesalahan'
      );
    case HTTPResponseStatus.noInternet:
      return dialogTemplate(
        context: context,
        info: info, 
        defaultInfo: 'Anda tidak terhubung ke Internet'
      );
    }
  }

  dialogTemplate({required BuildContext context, String? info, required String defaultInfo}){
    return CupertinoAlertDialog(
      title: Text('Error'),
      
      content: Text(info ?? defaultInfo),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, 
        child: Text("OK"))
      ],
    );
  }