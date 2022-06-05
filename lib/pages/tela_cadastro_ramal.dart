import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/campo_texto.dart';
import 'widgets/mensagem.dart';

class TelaCadastroRamal extends StatefulWidget {
  const TelaCadastroRamal({Key? key}) : super(key: key);

  @override
  _TelaCadastroRamalState createState() => _TelaCadastroRamalState();
}

class _TelaCadastroRamalState extends State<TelaCadastroRamal> {
  var txtSetor = TextEditingController();
  var txtNumero = TextEditingController();
  //var txtCodigo = TextEditingController();

  //
  // getDocumentoById
  //
  getDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('ramais')
        .doc(id)
        .get()
        .then((doc) {
      txtSetor.text = doc.get('setor');
      txtNumero.text = doc.get('numero');
    });
  }

  @override
  Widget build(BuildContext context) {
    //RECUPERAR o id do ALUNO que foi selecionado
    var id = ModalRoute.of(context)!.settings.arguments;
    if (id != null) {
      if (txtSetor.text.isEmpty && txtNumero.text.isEmpty) {
        getDocumentoById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Alunos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade900,
      ),
      backgroundColor: Colors.grey[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            campoTexto('Setor', txtSetor, Icons.people),
            const SizedBox(height: 20),
            campoTexto('Numero', txtNumero, Icons.local_phone),
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
                        FirebaseFirestore.instance.collection('ramais').add(
                          {
                            'uid' : FirebaseAuth.instance.currentUser!.uid.toString(),
                            'setor': txtSetor.text,
                            'numero': txtNumero.text,
                            //'codigo': txtCodigo.text,
                          },
                        );
                        sucesso(context, 'O item foi adicionado com sucesso.');
                      } else {
                        FirebaseFirestore.instance
                            .collection('alunos')
                            .doc(id.toString())
                            .set(
                          {
                            'uid' : FirebaseAuth.instance.currentUser!.uid.toString(),
                            'setor': txtSetor.text,
                            'numero': txtNumero.text,
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