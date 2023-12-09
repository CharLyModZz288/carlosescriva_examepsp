import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerClass extends StatelessWidget{

  Function(int indice)? onItemTap;

  DrawerClass({Key? key,required this.onItemTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(

              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'Ajustes'
            ),
          ),
          ListTile(
            leading:Image.asset("resources/logout.jpeg",width: 50, height: 50),
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Logout'),
            onTap: () {
              onItemTap!(0);

            },
          ),

        ],
      ),
    );
  }

}