import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Examen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp;
    materialApp=MaterialApp(title: "Examen Carlos Escriva",
      routes: {
        '/loginview':(context)=>LoginView(),
        '/registerview':(context)=>RegisterView(),
        '/homeview':(context)=>HomeView(),
        '/splashview':(context) => SplashView(),
        '/perfilview':(context) => PerfilView(),
        '/postview':(context) => PostView(),
        '/postcreateview':(context) => PostCreateView(),
      },
      initialRoute:'/splashview' ,
    );

    return materialApp;
  }

}