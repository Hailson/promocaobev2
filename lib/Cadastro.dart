//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promocaobe/Model/Usuario.dart';

import 'Home.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {

  //Controladores Fields
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerCpf = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";

  _validarCampos(){


    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String cpf = _controllerCpf.text;
    String senha = _controllerSenha.text;

    //print("clicado: "+ nome + email + cpf + senha);

    if( nome.isNotEmpty ){

      if (cpf.isNotEmpty && cpf.length == 11 ){

        if( email.isNotEmpty && email.contains("@") ){

          if( senha.isNotEmpty && senha.length > 6 ){

            setState(() {
              _mensagemErro = "";
            });

            Usuario usuario = Usuario();
            usuario.nome = nome;
            usuario.cpf = cpf;
            usuario.email = email;
            usuario.senha = senha;

            _cadastrarUsuario( usuario );


          }else{
            setState(() {
              _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
            });
          }

        }else{
          setState(() {
            _mensagemErro = "Preencha o E-mail utilizando @";
          });
        }
      }

    }else{
      setState(() {
        _mensagemErro = "Preencha o Nome";
      });
    }

  }

  
 //Usuario usuario = Usuario();


  _cadastrarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;
    

    auth.createUserWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){
      
      Firestore db = Firestore.instance;

      db.collection("usuarios")
      .document(firebaseUser.uid)
      .setData(
        usuario.toMap()
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );

    }).catchError((error){
      print("erro app: " + error.toString() );
      setState(() {
        _mensagemErro = "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });

    });

  }//fim cadastrar usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        leading: GFIconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ), 
          onPressed: (){
            print('Clicado para fechar');
            Navigator.pop(context);
          },
          type: GFButtonType.transparent,
        ),
        title: Text('Cadastro'),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xff78a057)
        ),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    'images/user.png',
                    width: 200, height: 150,
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                      hintText: 'Nome',
                      prefixIcon: Icon(Icons.account_box),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)
                      )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerCpf,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                      hintText: 'CPF',
                      prefixIcon: Icon(Icons.confirmation_number),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)
                      )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(28, 8, 28, 8),
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.account_circle),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)
                      )
                    ),
                  ),
                ),

                TextField(
                  controller: _controllerSenha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(28, 8, 28, 8),
                      hintText: 'Senha',
                      prefixIcon: Icon(Icons.lock),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28)
                      )
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: GFButton(
                    fullWidthButton: true,
                    text: "Cadastrar",
                    textStyle: TextStyle(fontSize: 22),
                    shape: GFButtonShape.pills,
                    size: GFSize.LARGE,
                    color: Color(0xff075e54),
                    blockButton: true,
                    onPressed: () {
                      _validarCampos();
                    },
                  ),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),

                /*
                Center(
                  child: GestureDetector(
                  child: Text(
                    'clique aqui para se cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => Cadastro()
                      )
                    );
                  },
                ),
                ) */
              ],
            ),
          ),
        ),
      ),
    );
  }
}