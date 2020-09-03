import 'package:flutter/material.dart';

import 'main.dart';

void showOKDialogue(String title,String content,BuildContext context,{void onOkClicked}){
     showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext build){
                          return AlertDialog(
                            title: Text(title),
                            content: Text(content),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(MyApp.al.translate('OK')),
                                onPressed:(){
                                  Navigator.pop(context);
                                } ,
                              )
                            ],
                          );
                        }
                      );
   }

   void showNoConnectionDialogue(BuildContext context){
     showOKDialogue(MyApp.al.translate('ERROR'), MyApp.al.translate('NO_CONNECTION_PLEASE_TRY_AGAIN_LATER'),context);
   }

   /*YYDialog showLoadingDialogue(BuildContext context){
    return YYDialog().build(context)
      ..text(
        text: LOADING,
        fontWeight: FontWeight.bold
      )
      ..divider(
        color: PRIMARY_COLOR
      )
      ..circularProgress(backgroundColor:PRIMARY_COLOR)
      ..text(
        text: CONNECTING_TO_SERVER_PLEASE_WAIT
      )..show();
   }*/


    void showLoadingDialogue(BuildContext context){
     showDialog(context: context,barrierDismissible: false,builder: (BuildContext context){
                          return AlertDialog(
                            title: Text(MyApp.al.translate('LOADING')),
                            content: SingleChildScrollView(
                                child:ListBody(
                                  children: <Widget>[
                                    CircularProgressIndicator(),
                                    Text(MyApp.al.translate('CONNECTING_TO_SERVER_PLEASE_WAIT'))],
                                    )
                                    )
                                    );
                      });
   }