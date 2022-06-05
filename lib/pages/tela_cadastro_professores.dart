import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/campo_texto.dart';
import 'widgets/mensagem.dart';

class TelaCadastroProfessores extends StatefulWidget {
  const TelaCadastroProfessores({Key? key}) : super(key: key);

  @override
  _TelaCadastroProfessoresState createState() => _TelaCadastroProfessoresState();
}

class _TelaCadastroProfessoresState extends State<TelaCadastroProfessores> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
 // var txtCodigo = TextEditingController();

  //
  // getDocumentoById
  //
  getDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('professores')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtEmail.text = doc.get('email');
      //txtCodigo.text=doc.get('codigo');
    });
  }

  @override
  Widget build(BuildContext context) {
    //RECUPERAR o id do ALUNO que foi selecionado
    var id = ModalRoute.of(context)!.settings.arguments;
    if (id != null) {
      if (txtNome.text.isEmpty && txtEmail.text.isEmpty) {
        getDocumentoById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Professores'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            campoTexto('Nome', txtNome, Icons.people),
            const SizedBox(height: 20),
            campoTexto('Email', txtEmail, Icons.email),
            //const SizedBox(height: 20),
            //campoTexto('Codigo', txtCodigo, Icons.control_point),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.grey.shade900,
                    ),
                    child: const Text('salvar'),
                    onPressed: () {
                      if (id == null) {
                        FirebaseFirestore.instance.collection('professores').add(
                          {
                            'uid' : FirebaseAuth.instance.currentUser!.uid.toString(),
                            'nome': txtNome.text,
                            'email': txtEmail.text,
                            //'codigo': txtCodigo.text,
                          },
                        );
                        sucesso(context, 'O item foi adicionado com sucesso.');
                      } else {
                        FirebaseFirestore.instance
                            .collection('professores')
                            .doc(id.toString())
                            .set(
                          {
                            'uid' : FirebaseAuth.instance.currentUser!.uid.toString(),
                            'nome': txtNome.text,
                            'email': txtEmail.text,
                            //'codigo': txtCodigo.text,

                          },
                        );
                        sucesso(context, 'O item foi alterado com sucesso.');
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.grey.shade900,
                      ),
                      child: const Text('cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}