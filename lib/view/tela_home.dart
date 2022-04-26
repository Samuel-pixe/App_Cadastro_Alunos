import 'package:app_parcial/view/sobre.dart';
import 'package:flutter/material.dart';


class TelaHome extends StatefulWidget {
  const TelaHome({ Key? key }) : super(key: key);

  @override
  State<TelaHome> createState() => _TelaHomeState();
}


class _TelaHomeState extends State<TelaHome> {
//----------------------------------------//

var form = GlobalKey<FormState>();


  Widget build (BuildContext context) {
    return Scaffold(
      //----------------------//
      appBar: AppBar(
        title: const Text('Cadastro de alunos'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900, actions: [
            IconButton(onPressed: () {
            caixaDialogoSobre('Tema do App: Controle e cadastro de alunos no banco de dados\nObjetivo: Criar um aplicativo para poder fazer o cadastro de alunos no banco de dados para acessar a rede wifi\nSamuel Arantes Gonzales');  
            }, icon: const Icon(Icons.info_outline))//question_mark_rounded
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
                  const SizedBox(height: 30),
                  botao2('Cadastro de Alunos'),
                  const SizedBox(height: 30),
                  botao3('Cadastro de Professores'),
                  const SizedBox(height: 30),
                  botao2('Reservas'),
                  const SizedBox(height: 30),
                  botao3('Ramais'),
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
  //-----------------------------------
  botao1(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
          Navigator.pushNamed(context, 't2');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }
  //----------------------------------
  botao2(rotulo) {
  return SizedBox(width: 190,height: 45,
    
      child: ElevatedButton(//TextButton
        onPressed: () {
         // Navigator.pushNamed(context, 't3');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }
  //---------------------------------
  botao3(rotulo) {
  return SizedBox(width: 190,height: 45,

      child: ElevatedButton(//TextButton
        onPressed: () {
         // Navigator.pushNamed(context, 't3');

        },
        //aparência
        child: Text(rotulo, style: const TextStyle(fontSize: 14),),style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
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



}