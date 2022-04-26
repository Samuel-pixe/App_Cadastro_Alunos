import 'package:flutter/material.dart';
import 'view/tela_login.dart';
import 'view/tela_alunos_pesquisa.dart';
import 'view/tela_cadastro.dart';
import 'view/tela_home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Alunos',
      initialRoute: 't1',
      routes: {
        't1' : (context) => const TelaLogin(),
        't2' : (context) => const TelaAlunosPesquisa(),
        't3' : (context) => const TelaCadastro(), 
        't4' : (context) => const TelaHome(),
      },
    )
  );
}

