
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carlosescriva_examepsp/Custom/KTTextField.dart';
import 'package:carlosescriva_examepsp/FirestoreObjects/FbPost.dart';
import 'package:carlosescriva_examepsp/OnBoarding/LoginView.dart';
import 'package:carlosescriva_examepsp/Singletone/DataHolder.dart';

import '../Custom/BottomMenu.dart';
import '../Custom/PostCellView.dart';
import '../Custom/PostGridCellView.dart';
import '../Custom/DrawerClass.dart';
import '../FirestoreObjects/FbPost.dart';
import '../OnBoarding/LoginView.dart';
import '../Singletone/DataHolder.dart';


class HomeView extends StatefulWidget {


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>{

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  final Map<String,FbPost> mapPosts = Map();
  bool bIsList=false;
  String eve="Hola";


  void onBottonMenuPressed(int indice) {
    // TODO: implement onBottonMenuPressed
    print("------>>>> HOME!!!!!!"+indice.toString()+"---->>> ");
    setState(() {
      if(indice == 0){
        bIsList=true;
      }
      else if(indice==1){
        bIsList=false;
      }
      else if(indice==2){
        exit(0);
      }
    });

  }

  void fHomeViewDrawerOnTap(int indice){
    print("---->>>> "+indice.toString());
    if(indice==0){
      FirebaseAuth.instance.signOut();
      //Navigator.of(context).pop();
      //Navigator.of(context).popAndPushNamed("/loginview");
      //Navigator.of(context).pushAndRemoveUntil(newRoute, (route) => false)
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) =>  LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }
    else if(indice==1){
      exit(0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descargarPosts();
    determinarTempLocal();
    DataHolder().suscribeACambiosGPSUsuario();

  }

  void determinarTempLocal() async{
    Position position = await DataHolder().geolocAdmin.determinePosition();
    double valor=await DataHolder().httpAdmin.pedirTemperaturasEn(position.latitude,position.longitude);
    print("LA TEMPERATURA EN EL SITIO DONDE ESTAS ES: ${valor}");
  }

  void descargarPosts() async{


    CollectionReference<FbPost> ref=db.collection("Posts")
        .withConverter(fromFirestore: FbPost
        .fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);

    ref.snapshots().listen(datosDescargados, onError: descargaPostError,);

  }

  void datosDescargados(QuerySnapshot<FbPost> postsDescargados){
    print("NUMERO DE POSTS ACTUALIZADOS>>>> "+postsDescargados.docChanges.length.toString());

    for(int i=0;i<postsDescargados.docChanges.length;i++){
        FbPost temp = postsDescargados.docChanges[i].doc.data()!;
        mapPosts[postsDescargados.docChanges[i].doc.id]=temp;

    }

    setState(() {
      posts.clear();
      posts.addAll(mapPosts.values);
    });

  }

  void descargaPostError(error){
    print("Listen failed: $error");
  }

  void descargarPostsOLD() async{
    posts.clear();

    CollectionReference<FbPost> ref=db.collection("Posts")
        .withConverter(fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),);


    QuerySnapshot<FbPost> querySnapshot=await ref.get();

    for(int i=0;i<querySnapshot.docs.length;i++){
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("KYTY"),
      ),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      //bottomNavigationBar: BottomMenu(onBotonesClicked: this.onBottonMenuPressed),
      drawer: DrawerClass(onItemTap: fHomeViewDrawerOnTap,),
      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      /**/
    );
  }

  void onItemListClicked(int index){
    DataHolder().selectedPost=posts[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed("/postview");
    //print("EL ELEMENTO DE LA LISTA QUE ACABA DE TOCARSE ES> "+index.toString());
    
  }

  /**
   *
   */
  Widget? creadorDeItemLista(BuildContext context, int index){
    return PostCellView(sText: posts[index].titulo,
      dFontSize: 30,
      iColorCode: 0,
      iPosicion: index,
      onItemListClickedFun:onItemListClicked
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index){
    return PostGridCellView(sText: posts[index].titulo,
      dFontSize: 28,
      iColorCode: 0,
      dHeight: DataHolder().platformAdmin.getScreenHeight()*0.5,
      iPosicion: index,
      onItemListClickedFun:onItemListClicked
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    //return Divider(thickness: 5,);
    return Column(
      children: [
        Divider(),
        //CircularProgressIndicator(),
        //Image.network("https://media.tenor.com/zBc1XhcbTSoAAAAC/nyan-cat-rainbow.gif")
      ],
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista,
        );
    } else {
      return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemCount: posts.length,
            itemBuilder: creadorDeItemMatriz
        );
    }
  }



}