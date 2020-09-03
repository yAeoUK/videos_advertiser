import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videos_advertiser/dialogues.dart';
import 'package:videos_advertiser/home.dart';
import 'main.dart';
import 'post.dart';

class SignPage extends StatefulWidget {

  @override
  SignPageState createState() => SignPageState();
}

class SignPageState extends State<SignPage> {

  TextEditingController usernameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  FocusNode usernameNode=FocusNode();
  FocusNode passwordNode=FocusNode();

  String usernameError='';
  String passwordError='';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: usernameController,
                    focusNode: usernameNode,
                    decoration: InputDecoration(
                      hintText:MyApp.al.translate('USERNAME'),
                      errorText: usernameError
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  Padding(padding: EdgeInsets.all(10),),
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordNode,
                    decoration: InputDecoration(
                      hintText: MyApp.al.translate('PASSWORD'),
                      errorText: passwordError
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  RaisedButton(
                    child: Text(MyApp.al.translate('OK')),
                    onPressed: ()async{
                      if(usernameController.text.isEmpty){
                        usernameNode.requestFocus();
                        setState(() {
                          usernameError= MyApp.al.translate('ENTER_USERNAME');
                        });
                        return;
                      }
                      if(usernameController.text.isNotEmpty)setState(() {
                          usernameError= '';
                        });
                      if(passwordController.text.isEmpty){
                        passwordNode.requestFocus();
                        setState(() {
                          passwordError=MyApp.al.translate('ENTER_PASSWORD');
                        });
                        return;
                      }
                      if(passwordController.text.isNotEmpty)setState(() {
                          passwordError= '';
                        });
                      showLoadingDialogue(context);
                      Map m=Map();
                      m['username']=usernameController.text;
                      m['password']=passwordController.text;
                      var p=Post(context,'advertiserSignIn.php',m);
                      await p.fetchPost();
                      if(p.connectionSucceed){
                        try{
                          var result=json.decode(p.result);
                          if(result['result']=='failed'){
                            if(result['reason']=='wrong data'){
                              showOKDialogue(MyApp.al.translate('WRONG_DATA'), MyApp.al.translate('CHECK_USERNAME_PASSWORD_TRY_AGAIN'), context);
                            }
                          }
                          if(result['result']=='success'){
                            var data=result['data'];
                            var id =data['id'];
                            var preferences=await SharedPreferences.getInstance();
                            await preferences.setBool('loggedIn', true);
                            await preferences.setBool('advertiserId', id);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(con)=> HomePage()));
                          }
                        }
                        on Exception{
                          showOKDialogue(MyApp.al.translate('ERROR'), p.result,context);
                        }
                      }
                    },
                  )
                ],
              ),
            )
          )
        );
  }
}