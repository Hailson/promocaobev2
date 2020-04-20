import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:promocaobe/Login.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _emailUsuario = "";
  String _cupom = "";

  List<String> listaQrcode = [
    "202001","202002", "202003", "202004", "202005", "202006", "202007",
    "202008", "202009", "2020010", "2020011", "2020012","2020013", "2020014",
     
  ];

   _gerarCupom() {
     print("gerado");
    var cupom_random =  Random().nextInt(listaQrcode.length);
    
    var cupomGerado = listaQrcode[cupom_random];
    

    setState(() {
      _cupom = cupomGerado;
    });
  }


  Future _recuperardados() async{
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuario = usuarioLogado.email;
      //print(usuarioLogado);
    });
  }

  _sair(){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();

    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Login()
          )
      );
  }

  @override
  void initState() {
    _gerarCupom();
    _recuperardados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerar QRCODE"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_emailUsuario),
              QrImage(
                errorCorrectionLevel: QrErrorCorrectLevel.Q,
                data: _cupom,
                version: QrVersions.auto,
                size: 200.0,
              ),
              Text("Codigo de Cupom gerado foi: " + _cupom),
              Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: GFButton(
                    fullWidthButton: true,
                    text: "Gerar Cupom",
                    textStyle: TextStyle(fontSize: 26),
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    color: Color(0xff075e54),
                    blockButton: true,
                    onPressed: (){
                      _gerarCupom();
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: GFButton(
                    text: "SAIR",
                    textStyle: TextStyle(fontSize: 26),
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    color: GFColors.DANGER,
                    blockButton: true,
                    onPressed: (){
                      _sair();
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}