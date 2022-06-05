import 'dart:js';

import 'package:app_parcial/pages/tela_cadastro_alunos.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_parcial/pages/tela_cadastro.dart';
import 'package:app_parcial/pages/tela_ramais.dart';
import 'package:app_parcial/pages/tela_cadastro_ramal.dart';
import 'package:app_parcial/pages/tela_cadastro_professores.dart';
import 'package:app_parcial/pages/tela_professores_pesquisa.dart';



import 'pages/tela_login.dart';
import 'pages/tela_alunos_pesquisa.dart';
import 'pages/tela_cadastro.dart';
import 'pages/tela_home.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(

    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Alunos',
      initialRoute: 'login',
      routes: {
        'login' : (context) => const TelaLogin(),
        'tela_alunos_pesquisa' : (context) => const TelaAlunosPesquisa(),
        'tela_cadastro' : (context) => const TelaCadastro(), 
        'home' : (context) => const TelaHome(),
        'tela_cadastro_alunos' : (context) => const TelaCadastroAlunos(),
        'tela_ramais' : (context) => const TelaRamais(),
        'tela_cadastro_ramal' : (context) => const TelaCadastroRamal(),
        'tela_cadastro_professores' : (context) => const TelaCadastroProfessores(),
        'tela_professores_pesquisa' : (context) => const TelaProfessoresPesquisa(),
        
      },
    )
  );
}
