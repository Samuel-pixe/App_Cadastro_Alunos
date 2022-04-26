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
            caixaDialogoSobre('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi turpis erat, feugiat et sagittis sed, accumsan congue massa. Phasellus lacus erat, placerat sed pellentesque eget, sodales et quam. Etiam vel arcu eleifend, ultricies arcu vitae, iaculis orci. Nullam sed interdum est. Sed aliquet rutrum convallis. Donec efficitur nibh ut sem feugiat, vitae auctor velit molestie. Vivamus sed dictum neque, eget ornare lectus. Duis ornare, justo nec finibus cursus, dolor lorem scelerisque magna, vel consequat elit leo in mauris. Sed imperdiet justo in augue viverra laoreet. Maecenas convallis volutpat eros, id facilisis tellus euismod vitae. Etiam rutrum massa sit amet neque efficitur pellentesque. Vestibulum orci eros, euismod sed semper nec, feugiat sed metus. Ut tempus dignissim cursus. Ut non justo urna.');  
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
                  botao2('-X-'),
                  const SizedBox(height: 30),
                  botao3('-X-'),
                  const SizedBox(height: 30),
                  botao2('-X-'),
                  const SizedBox(height: 30),
                  botao3('-X-'),
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
  return SizedBox(width: 170,height: 40,

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
  return SizedBox(width: 170,height: 40,
    
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
  return SizedBox(width: 170,height: 40,

      child: ElevatedButton(//TextButton
        onPressed: () {
         // Navigator.pushNamed(context, 't3');

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
        return AlertDialog(
          title: const Text('Sobre'),//centerTitle: true,
          
          content: Text(
            msg,
            style: const TextStyle(fontSize: 24),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('fechar')),
          ],
        );
      },
    );
  }



}