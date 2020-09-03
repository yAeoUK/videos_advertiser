import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:videos_advertiser/home.dart';
import 'package:videos_advertiser/localization.dart';
import 'package:videos_advertiser/sign_in.dart';
import 'parameters.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  var loggedIn=false;
  static AppLocalizations al;
  static Locale local;
  Future isUserLoggedIn(BuildContext context)async{
    var sharedPreferences=await SharedPreferences.getInstance();
    loggedIn=sharedPreferences.getBool('loggedIn')??false;
    //Locale l=Localizations.localeOf(context);
    al=AppLocalizations(local);
    await al.load();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.blueGrey,
      ),
      home:FutureBuilder(
        future: isUserLoggedIn(context),
        builder: (cont,snapshot)  {
          if(snapshot.connectionState==ConnectionState.done){
            return loggedIn?HomePage():SignPage();
          }
          return Scaffold();
        },
      ),
      supportedLocales: SOPPURTED_LOCALES,
      localizationsDelegates: [
        //AppLocalizations.delegate,
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
                local=supportedLocale;
            return supportedLocale;
          }
        }
        local=supportedLocales.first;
        return supportedLocales.first;
      }
    );
  }
}

class Channel{
    final String name,pictureUrl,url;
    final int viewed;
    Channel({this.name,this.pictureUrl,this.url,this.viewed});
  }

class Video{
    final thumbnailUrl,title,videoId;
    var favorite,watched;
    Video({this.videoId,this.title,this.thumbnailUrl,this.favorite,this.watched});

    Map toJson() => {'videoId':videoId,'title':title,'thumbnailUrl':thumbnailUrl,'favorite':favorite,'watched':watched};
    
    factory Video.fromJson(var json){
      return Video(
        videoId: json['videoId'],
        title: json['title'],
        thumbnailUrl: json['thumbnailUrl'],
        favorite: json['favorite'],
        watched: json['watched']
      );
    }
  }
