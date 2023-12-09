import 'package:carlosescriva_examepsp/main/MapaView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import 'OnBoarding/LoginView.dart';
import 'OnBoarding/PerfilView.dart';
import 'OnBoarding/RegisterView.dart';
import 'Splash/SplashView.dart';
import 'main/HomeView.dart';
import 'main/PostCreateView.dart';
import 'main/PostView.dart';

class Examen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp;
    if(kIsWeb){
      materialApp=MaterialApp(title: "Examen Carlos Escriva",
        routes: {
          '/loginview':(context)=>LoginView(),
          '/registerview':(context)=>RegisterView(),
          '/homeview':(context)=>HomeView(),//MapaView()
          '/splashview':(context) => SplashView(),
          '/perfilview':(context) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview':(context) => PostCreateView(),

        },
        initialRoute:'/MapaView' ,
      );
    }else {
      materialApp = MaterialApp(title: "Examen Carlos Escriva",
        routes: {
          '/loginview': (context) => LoginView(),
          '/registerview': (context) => RegisterView(),
          '/homeview': (context) => HomeView(),
          '/mapaview': (context) => MapaView(),
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/postview': (context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    }
    return materialApp;
  }

}