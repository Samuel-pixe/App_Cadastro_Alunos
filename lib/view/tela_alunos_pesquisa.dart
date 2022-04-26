import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../model/alunos.dart';

class TelaAlunosPesquisa extends StatefulWidget {
  const TelaAlunosPesquisa({ Key? key }) : super(key: key);

  @override
  State<TelaAlunosPesquisa> createState() => _TelaAlunosPesquisaState();
}

class _TelaAlunosPesquisaState extends State<TelaAlunosPesquisa> {

  List<Alunos> lista1 = [];
  List<Alunos> lista2 = [];

  var txtPesquisar = TextEditingController();


  carregarJson() async {
    final String f = await rootBundle.loadString('lib/data/alunos.json');
    final dynamic d = await json.decode(f);
    setState(() {
      d.forEach((item) {
        lista1.add(Alunos.fromJson(item));
      });
      lista2.addAll(lista1);
    });
  }

  //
  // PESQUISAR
  //
  void pesquisar(String q) {
    if (q.isNotEmpty) {
      List<Alunos> tmp = [];
      for (Alunos item in lista1) {
        if (item.name.toLowerCase().contains(q.toLowerCase())) {
          tmp.add(item);
        }
      }
      setState(() {
        lista2.clear();
        lista2.addAll(tmp);
      });
    } else {
      setState(() {
        lista2.clear();
        lista2.addAll(lista1);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await carregarJson();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Alunos'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
          children: [
            //
            // CAMPO DE PESQUISA
            //
            TextField(
              onChanged: (value) => pesquisar(value),
              controller: txtPesquisar,
              decoration: const InputDecoration(
              labelText: 'Pesquisar',
              hintText: 'Pesquisar',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
              Radius.circular(25),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),



      Expanded(
        child: ListView.builder(
            itemCount: lista2.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  lista1[index].name,
                  style: const TextStyle(fontSize: 24),
                ),
                subtitle: Text(
                  'Curso: ${lista2[index].curso} / codigo: ${lista2[index].codigo} / email: ${lista2[index].email}',
                  style: const TextStyle(fontSize: 18),
                ),
                leading: const Icon(Icons.perm_identity),
                trailing: const Icon(Icons.create_outlined),
                onTap: () {
                //
                // NAVEGAÇÃO
                // Ir para Tela de Detalhes
                Navigator.pushNamed(context, 't2',
                arguments: lista2[index]);
                },
              );
            },
          ),
        ),
      ]
    ),
  ),
);
}

//botao(){

//}
}
