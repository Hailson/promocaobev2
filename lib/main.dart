import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'Home.dart';
import 'Login.dart';

void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  
  Firestore.instance.collection('usuarios')
  .document("001")
  .setData({ 'nome': 'admin', 'cpf': '123456789101', 'senha': '123456' });
  
  runApp(MaterialApp(
  home: Login(),
  theme: ThemeData(
    primaryColor: Color(0xff075e54),
    accentColor: Color(0xff25d366)
  ),
  debugShowCheckedModeBanner: false,
));
}