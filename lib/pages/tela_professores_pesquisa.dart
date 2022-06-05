//import 'dart:convert';

import 'package:app_parcial/pages/widgets/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../model/professores.dart';

class TelaProfessoresPesquisa extends StatefulWidget {
  const TelaProfessoresPesquisa({Key? key}) : super(key: key);

  @override
  State<TelaProfessoresPesquisa> createState() => _TelaProfessoresPesquisaState();
}

class _TelaProfessoresPesquisaState extends State<TelaProfessoresPesquisa> {
  List<Professores> lista1 = [];
  List<Professores> lista2 = [];

  var txtPesquisar = TextEditingController();
  var nomeUsuario;

  carregarDados() async {
    if (txtPesquisar.text.isEmpty) {
      await FirebaseFirestore.instance.collection('professores').get().then((q) {
        lista1.clear();
        lista2.clear();
        for (var d in q.docs) {
          lista1.add(Professores.fromJson(d.id, d.data()));
          //print(d.data().toString());
        }
        lista2.addAll(lista1);
      });
    }
  }

/*  carregarJson() async {
    final String f = await rootBundle.loadString('alunos');
    final dynamic d = await json.decode(f);
    setState(() {
      d.forEach((item) {
        lista1.add(Alunos.fromJson(item));
      });
      lista2.addAll(lista1);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de Professores'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        actions: [
          Column(
            children: [
              IconButton(
                tooltip: 'sair',
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                icon: const Icon(Icons.logout),
              ),
              FutureBuilder(
                future: retornarNomeUsuario(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return Text(
                      nomeUsuario.toString(),
                      style: const TextStyle(fontSize: 12),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
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
            child: FutureBuilder(
                future: carregarDados(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: lista2.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                              lista2[index].nome,
                              style: const TextStyle(fontSize: 24),
                            ),
                            subtitle: Text(
                              'nome: ${lista2[index].nome} / email: ${lista2[index].email}', // codigo: ${lista2[index].codigo} / 
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("professores").doc(lista2[index].id).delete();
                                sucesso(context,'O documento foi apagado com sucesso.');
                              },
                            ),
                            onTap: () {
                            Navigator.pushNamed(
                              context,
                              'tela_cadastro_professores',
                              arguments: lista2[index].id,
                            );
                          },
                            

                            //leading: const Icon(Icons.perm_identity),
                            //trailing: const Icon(Icons.create_outlined),
                            //onTap: () {
                            //
                            // NAVEGAÇÃO
                            // Ir para Tela de Detalhes
                            //Navigator.pushNamed(context, 't2',
                            //arguments: lista2[index]);
                            //},
                            );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'tela_cadastro_professores');
        },
      ),
    );
  }

  //
  // PESQUISAR
  //
  void pesquisar(String q) {
    if (q.isNotEmpty) {
      List<Professores> tmp = [];
      for (Professores item in lista1) {
        if (item.nome.toLowerCase().contains(q.toLowerCase())) {
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

  retornarNomeUsuario() async {
    var uid = FirebaseAuth.instance.currentUser!.uid.toString();
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: uid)
        .get()
        .then((q) {
      if (q.docs.isNotEmpty) {
        nomeUsuario = q.docs[0].data()['nome'];
      } else {
        nomeUsuario = 'NENHUM';
      }
    });
  }
}
