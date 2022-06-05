import 'package:app_parcial/pages/widgets/sobre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class TelaHome extends StatefulWidget {
  const TelaHome({ Key? key }) : super(key: key);

  @override
  State<TelaHome> createState() => _TelaHomeState();
}


class _TelaHomeState extends State<TelaHome> {
//----------------------------------------//

var form = GlobalKey<FormState>();
var nomeUsuario;

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      //----------------------//
      appBar: AppBar(
        title: const Text('Cadastro de alunos'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900, actions: [
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
              //IconButton(onPressed: () {
              //caixaDialogoSobre('Tema do App: Controle e cadastro de alunos no banco de dados\nObjetivo: Criar um aplicativo para poder fazer o cadastro de alunos no banco de dados para acessar a rede wifi\nSamuel Arantes Gonzales');  
              //},icon: const Icon(Icons.info_outline))//question_mark_rounded
            ],
          ),          
        ],
        
        //------------------//
      ),
      
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
               
            //------------------------------------- FORMULÁRIO----------------------------------//        
            child: Form(
              key: form,
              child: Column(
                children: [
                  Icon(
                    Icons.assignment_ind,//people_alt //article
                    size: 100,
                    color: Colors.grey.shade900,
                  ),
                  const SizedBox(height: 60),
                  botao1('Consulta de Alunos'),
                  const SizedBox(height: 20),
                  botao2('Cadastro de Alunos'),
                  const SizedBox(height: 20),
                  botao3('Consulta de Professores'),
                  const SizedBox(height: 20),
                  botao4('Cadastro de Professores'),
                  const SizedBox(height: 20),
                  //botao5('Reservas'),
                  //const SizedBox(height: 30),
                  //botao6('Perfil'),
                  //const SizedBox(height: 20),
                  botao7('Ramais'),
                  const SizedBox(height: 30),                  
                  //botaoS('?'),//sobre
                ],
              ),
            ),
          ),
        ),
      ),
    );
   }

  //----------------------------------//

  botao1(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
          Navigator.pushNamed(context, 'tela_alunos_pesquisa');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }

  //----------------------------------//

  botao2(rotulo) {
  return SizedBox(width: 190,height: 45,
    
      child: ElevatedButton(//TextButton
        onPressed: () {
         Navigator.pushNamed(context, 'tela_cadastro_alunos');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }
  //-----------------------------------//
  botao3(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
         Navigator.pushNamed(context, 'tela_professores_pesquisa');

        },
        //aparência
        child: Text(rotulo, style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }


  
  //----------------------------------//

  botao4(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
         Navigator.pushNamed(context, 'tela_cadastro_professores');

        },
        //aparência
        child: Text(rotulo, style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }

  //----------------------------------//

  botao5(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
          Navigator.pushNamed(context, 'tela_reservas');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }

  //----------------------------------//
  
  botao6(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
          Navigator.pushNamed(context, 'tela_perfil');
          //Navigator.pushNamed(context,'tela_perfil',arguments: lista2[index].id,);

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }

  //----------------------------------//

  botao7(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
          Navigator.pushNamed(context, 'tela_ramais');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }

  caixaDialogoSobre(msg) {
    return showDialog(
      context: context,
      
      builder: (BuildContext context) {
      return Sobre(text: msg);
      },
    );
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