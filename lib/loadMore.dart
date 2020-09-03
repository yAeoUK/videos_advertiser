import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class LoadMore extends StatefulWidget{

  final onClick;
  final loading;
  LoadMore({this.onClick,this.loading});
  @override
  State<StatefulWidget> createState()=>LoadMoreState();
}

class LoadMoreState extends State<LoadMore>{
  var loading;Future onClick;

  @override
  void initState() {
    super.initState();
    loading=widget.loading;
    onClick=widget.onClick;
    configureLoading();
  }

  void configureLoading()async{
    setState(() {
      
    });
    if(loading){
      await onClick;
      setState(() {
        loading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading?CircularProgressIndicator():
    RaisedButton(
      onPressed: () { 
        loading=true;
        configureLoading();
       },
      child: Text(MyApp.al.translate('LOADING')),
    );
  }
}