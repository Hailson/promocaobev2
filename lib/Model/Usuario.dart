//import 'package:flutter/material.dart';
class Usuario {

  String nome;
  String cpf;
  String email;
  String senha;
  bool status = false;

  Usuario();

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome": this.nome,
      "cpf": this.cpf,
      "email": this.email,
      "status": this.status
    };

    return map;
  }
/*
  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
*/

}