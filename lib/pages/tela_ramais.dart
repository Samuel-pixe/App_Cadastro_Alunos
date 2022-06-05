import 'package:app_parcial/pages/widgets/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/ramais.dart';

class TelaRamais extends StatefulWidget {
  const TelaRamais({Key? key}) : super(key: key);

  @override
  _TelaRamaisState createState() => _TelaRamaisState();
}

class _TelaRamaisState extends State<TelaRamais> {
  //Coleção de cafes
  var ramais;
  var nomeUsuario;

  @override
  void initState() {
    super.initState();
    //Recuperar os dados da coleção de caffes
    ramais = FirebaseFirestore.instance.collection('ramais').where('uid',
        isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString());
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

  Widget exibirDocumento(item) {
    //Converter um documento em um objeto
    Ramais c = Ramais.fromJson(item.id, item.data());
    return ListTile(
      title: Text(
        c.setor,
        style: const TextStyle(fontSize: 22),
      ),
      subtitle: Text(
        c.numero,
        style: const TextStyle(
          fontSize: 22,
          fontStyle: FontStyle.italic,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () {
          ramais.doc(item.id).delete();
          sucesso(context, 'O documento foi apagado com sucesso.');
        },
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          'tela_cadastro_ramal',
          arguments: item.id,
        );
      },
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ramais'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        //automaticallyImplyLeading: false,
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
      backgroundColor: Colors.grey[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: StreamBuilder<QuerySnapshot>(
          stream: ramais.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text('Não foi possível conectar'),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                //exibir os documentos da coleção
                final dados = snapshot.requireData;
                return ListView.builder(
                  itemCount: dados.size,
                  itemBuilder: (context, index) {
                    return exibirDocumento(dados.docs[index]);
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey.shade900,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'tela_cadastro_ramal');
        },
      ),
    );
  }
}