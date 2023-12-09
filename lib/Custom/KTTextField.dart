import 'package:flutter/material.dart';

class KTTextField extends StatelessWidget{

  String sHint;
  TextEditingController tecController;
  bool blIsPassword;
  double dPaddingH;
  double dPaddingV;

  KTTextField({Key? key,this.sHint="",
    required this.tecController,
    this.blIsPassword=false,
    this.dPaddingH=60,
    this.dPaddingV=15
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(padding: EdgeInsets.symmetric(horizontal: dPaddingH, vertical: dPaddingV),
      child: Row(children: [
        Image.asset("resources/psp.jpeg",width: 50, height: 50),
        Flexible(
          child: TextFormField(
              controller: tecController,
              obscureText: blIsPassword,
              enableSuggestions: !blIsPassword,
              autocorrect: !blIsPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                //hintText: sHint,
                fillColor: Colors.purpleAccent,
                filled: true,
                labelText: sHint,
                suffixIcon:Icon(Icons.check_circle_outline_rounded),
                prefixIcon: Icon(Icons.check_circle),
              )),
        ),
      ],
      ),
    );


  }

}