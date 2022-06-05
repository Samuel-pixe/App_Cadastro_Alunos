//import 'dart:convert';
//import 'dart:ui';
import 'package:app_parcial/pages/widgets/sobre.dart';
import 'package:flutter/material.dart';
import 'widgets/mensagem.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:flutter/services.dart';
//import 'package:app_parcial/view/widget_foto.dart';


// TELA PRINCIPAL
// Stateful Widget = stf + TAB

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {

//---------Armazenamento dos valores dos campos de texto--------//
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  bool isLoading = false;

  //Atributo responsável por identificar unicamente
  //o formulário da UI
  //var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de alunos'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900, actions: [
          IconButton(
            onPressed: () {
            caixaDialogoSobre('Tema do App: Controle e cadastro de alunos no banco de dados\nObjetivo: Criar um aplicativo para poder fazer o cadastro de alunos no banco de dados para acessar a rede wifi\nSamuel Arantes Gonzales');  
            }, icon: const Icon(Icons.info_outline))//question_mark_rounded
          ],
      ),
      backgroundColor: Colors.grey.shade300,
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
          const SizedBox(height: 20),
          campoTexto('E-mail', txtEmail,"email.exemplo@gmail.com", Icons.email),
          const SizedBox(height: 30),
          campoTexto('Senha', txtSenha,"********", Icons.lock, senha: true),
          const SizedBox(height: 80),
          
         // SizedBox(//width: 200,height: 40,
          //child: 
          OutlinedButton(
            
            style: OutlinedButton.styleFrom(
              
              primary: Colors.white,
              minimumSize: const Size(200, 45),
              backgroundColor: Colors.grey.shade900
              ),
              child: const Text('entrar'),
              
              onPressed: () {
                login(txtEmail.text, txtSenha.text);
              },
            ),
          //),
          
            const SizedBox(height: 50),
            
            TextButton(
              style: OutlinedButton.styleFrom(
              primary: Colors.grey.shade900,
              ),
              child: const Text('cadastrar'),
              onPressed: () {
                Navigator.pushNamed(context, 'tela_cadastro');
              },
            ),

          ],
        ),
      ),
    );  
  }


//-------------------CAMPO DE TEXTO---------------//
  
campoTexto(texto, controller, dica, icone, {senha}) {
    return TextFormField(
      controller: controller,
      obscureText: senha != null ? true : false,

      style: TextStyle(fontWeight: FontWeight.w300,color: Colors.grey.shade900,
      ),

      decoration: InputDecoration(
        prefixIcon: Icon(icone, color: Colors.grey.shade900),
        prefixIconColor: Colors.grey.shade900,
        labelText: texto,
        labelStyle: const TextStyle(fontSize: 15,color: Colors.grey),
        hintText: dica,hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade400,),
        border: const OutlineInputBorder(),
        focusColor: Colors.grey.shade900,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 0.0,
          ),
        ),
      ),
      
      validator: (value) {
        value = value!.replaceFirst(',', '.');
        //verificar se o usuário digitou um valor
        //numérico
        //(double.tryParse(value) == null) 
        if (value.isEmpty){
          return 'Nenhum valor registrado';
        } else {
          return null;
        }
     },    
    );
  }



//-------------------BOTÃO----------------//
  
//-------BOTÂO-CADASTRO-----//

//botaoC(rotulo) {
//  return SizedBox(width: 150,height: 20,
//    
//      child: TextButton(//ElevatedButton
//        onPressed: () {
//          Navigator.pushNamed(context, 't3');
//
//        },
//        //aparência
//        child: Text(rotulo,style: const TextStyle(fontSize: 14),),style: TextButton.styleFrom(primary: Colors.grey.shade900,),
//      ),
//    );
//  }
  
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

//---------VALIDAR-LOGIN---------//

void login(email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      sucesso(context, 'Usuário autenticado com sucesso!');

      Navigator.pushReplacementNamed(context, 'home');
      
    }).catchError((e) {
      //print('LOGIN ERRO: ' + e.code.toString());

      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');
          break;
        default:
          erro(context, e.code.toString());
      }
    });
  }



}
