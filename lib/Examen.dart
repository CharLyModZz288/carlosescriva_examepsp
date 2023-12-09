import 'package:carlosescriva_examepsp/Main/MapaView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'Main/HomeView.dart';
import 'Main/PostCreateView.dart';
import 'Main/PostView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/PerfilView.dart';
import 'OnBoarding/RegisterView.dart';
import 'Splash/SplashView.dart';

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
          '/splashview': (context) => SplashView(),
          '/perfilview': (context) => PerfilView(),
          '/postview': (context) => PostView(),
          '/postcreateview': (context) => PostCreateView(),
        },
        initialRoute: '/loginview',
      );
    }
    return materialApp;
  }

}