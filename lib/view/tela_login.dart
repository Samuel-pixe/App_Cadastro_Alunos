import 'dart:convert';
import 'dart:ui';
import 'package:app_parcial/view/sobre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_parcial/view/widget_foto.dart';


// TELA PRINCIPAL
// Stateful Widget = stf + TAB

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final String emailteste = "teste@gmail.com";
  final String senhateste = "123456";
  
  //---------------------------Armazenamento dos valores dos campos de texto--------//

  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  //Atributo responsável por identificar unicamente
  //o formulário da UI
  var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de alunos'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900, actions: [
            IconButton(onPressed: () {
            caixaDialogoSobre('Tema do App: Controle e cadastro de alunos no banco de dados\nObjetivo: Criar um aplicativo para poder fazer o cadastro de alunos no banco de dados para acessar a rede wifi\nSamuel Arantes Gonzales');  
            }, icon: const Icon(Icons.info_outline))//question_mark_rounded
          ],
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
                    Icons.article,//people_alt
                    size: 100,
                    color: Colors.grey.shade900,
                  ),
                  const SizedBox(height: 80),
                  campoTexto('E-mail', txtEmail,false,"email.exemplo@gmail.com"),
                  const SizedBox(height: 10),
                  campoTexto('Senha', txtSenha,true,"********"),
                  const SizedBox(height: 80),
                  botao('entrar'),
                  const SizedBox(height: 120),
                  botaoC('cadastrar'),
                  const SizedBox(height: 10),
                  //botaoS('?'),//sobre
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  //-------------------CAMPO DE TEXTO---------------//
  
  campoTexto(rotulo, variavel, senha, dica) {
    return TextFormField(
      //Associar a variável de controle
      controller: variavel,style: TextStyle(fontSize: 22,color: Colors.grey.shade900,),
      keyboardType: TextInputType.text,
     
      obscureText: senha,//Senha
      //maxLength: 100,//Quant. máxima de caracteres

      decoration: InputDecoration(labelText: rotulo,labelStyle: TextStyle(fontSize: 24,color: Colors.grey.shade600,),hintText: dica,hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400,),border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),),),
      
      //--------- Validação da entrada do usuário----------//
      
      validator: (value) {
        value = value!.replaceFirst(',', '.');
        //verificar se o usuário digitou um valor
        //numérico
        //(double.tryParse(value) == null) 
        if (value == null || value.isEmpty){
          return 'Nenhum valor registrado';
        } else {
          return null;
        }
     },
    //),
  );
}

  //-------------------BOTÃO----------------//
  
botao(rotulo) {
  return SizedBox(width: 250,height: 50,
    //Tipos de botões //ElevatedButton //TextButton //OutlinedButton
    //comportamento
      child: ElevatedButton(onPressed: () {  
          //Validação dos campos do formulário
          if (form.currentState!.validate()) {
            setState(() {
              String email = (txtEmail.text.replaceFirst(',', '.'));
              String senha = (txtSenha.text.replaceFirst(',', '.'));
              if (email != emailteste || senha != senhateste)
              {
              caixaDialogo('Senha ou e-mail invalidos');
              }
              else{
                Navigator.pushNamed(context, 't4');
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  elevation: 0,
                  content: Text('Login realizado com sucesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade900,),),
                  margin: const EdgeInsets.fromLTRB(100, 0, 100, 20),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.grey.shade400.withOpacity(0.3),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)),),
                ),
              );
              }         
            }
          );
        }
      },
        //aparência
        child: Text(rotulo,
        style: const TextStyle(fontSize: 24),),
          style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }

//-------BOTÂO-CADASTRO-----//

botaoC(rotulo) {
  return SizedBox(width: 150,height: 20,
    
      child: TextButton(//ElevatedButton
        onPressed: () {
          Navigator.pushNamed(context, 't3');

        },
        //aparência
        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: TextButton.styleFrom(primary: Colors.grey.shade900,),
      ),
    );
  }
  
  //----BOTÃO-SOBRE---//

  // botaoS(rotulo) {
  // return SizedBox(width: 20,height: 20,
  //   //Tipos de botões //ElevatedButton //TextButton //OutlinedButton
  //   //comportamento
  //     child: TextButton(
  //       onPressed: () {
  //         caixaDialogoSobre('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi turpis erat, feugiat et sagittis sed, accumsan congue massa. Phasellus lacus erat, placerat sed pellentesque eget, sodales et quam. Etiam vel arcu eleifend, ultricies arcu vitae, iaculis orci. Nullam sed interdum est. Sed aliquet rutrum convallis. Donec efficitur nibh ut sem feugiat, vitae auctor velit molestie. Vivamus sed dictum neque, eget ornare lectus. Duis ornare, justo nec finibus cursus, dolor lorem scelerisque magna, vel consequat elit leo in mauris. Sed imperdiet justo in augue viverra laoreet. Maecenas convallis volutpat eros, id facilisis tellus euismod vitae. Etiam rutrum massa sit amet neque efficitur pellentesque. Vestibulum orci eros, euismod sed semper nec, feugiat sed metus. Ut tempus dignissim cursus. Ut non justo urna.');

  //       },
  //       //aparência
  //       child: Text(rotulo,style: const TextStyle(fontSize: 14),),//style: ElevatedButton.styleFrom(primary: Colors.grey.shade900,),
  //     ),
  //   );
  // }

  //--------CAIXA DE DIÁLOGO-----//
  
  caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('-ERRO de login-'),//centerTitle: true,
          
          content: Text(
            msg,
            style: const TextStyle(fontSize: 24),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    txtEmail.clear();
                    txtSenha.clear();
                  });
                },
                child: const Text('fechar')),
          ],
        );
      },
    );
  }

   //--------CAIXA-DE-DIÁLOGO-SOBRE----//

  caixaDialogoSobre(msg) {
    return showDialog(
      context: context,
      
      builder: (BuildContext context) {
      return Sobre(text: msg);
      },
    );
  }

}
