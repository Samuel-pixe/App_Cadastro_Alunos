import 'package:flutter/material.dart';

class WidgetFoto extends StatelessWidget {

//Atributos que serão uasdos para receber
//dados atrvés do contrutor
  
  final String imagem;


  const WidgetFoto(this.imagem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margens
      //margin: const EdgeInsets.all(40),
      margin: const EdgeInsets.fromLTRB(40, 40, 40, 0),

      //espaçamento interno
      padding: const EdgeInsets.all(30),

      //bordas
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: Colors.black38,
        ),
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),

      width: MediaQuery.of(context).size.width * 0.90,
      height: 380,

      child: Column(
        children: [
          //Imagens
          Image.asset(imagem,scale:1.8,),
         // Image.network('')
        ],
      ),
    );
  }
}
