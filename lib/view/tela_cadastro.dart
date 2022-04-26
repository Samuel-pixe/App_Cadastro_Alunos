import 'package:app_parcial/view/sobre.dart';
import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({ Key? key }) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {

  var txtDDD = TextEditingController(); 
  var txtNome = TextEditingController(); 
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController(); 
  var txtSenha1 = TextEditingController();
  var txtTelefone = TextEditingController();
  var txtSobrenome = TextEditingController();

  var form = GlobalKey<FormState>();

  
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Cadastrar novo usuario'),centerTitle: true,backgroundColor: Colors.grey.shade900,
    actions: [
            IconButton(onPressed: () {
            caixaDialogoSobre('Tema do App: Controle e cadastro de alunos no banco de dados\nObjetivo: Criar um aplicativo para poder fazer o cadastro de alunos no banco de dados para acessar a rede wifi\nSamuel Arantes Gonzales');  
            }, icon: const Icon(Icons.info_outline))//question_mark_rounded
          ],
    ),//-AppBar-//
    backgroundColor: Colors.grey.shade300, //-----------------FUNDO-----------------//
    
    body: SingleChildScrollView(//-------------------BODY--------------------//
        child: Padding(//-------------------PADDING-AppBar-CAMPO--DE-TEXTO---------------------//
          padding: const EdgeInsets.all(20),//----------------ESPAÇAMENTO-DO-PADDING--------------------//
          child: Center(
            //-----------------------------FORMULARIO--------------------//
            child: Form(
              key: form,
                child: Column(
                  children: [//-------Caixas de Texto----//
                    const SizedBox(height: 10),
                    campoTexto('E-mail', txtEmail,false),
                    const SizedBox(height: 10),
                    campoTexto('Nome', txtNome,false),
                    const SizedBox(height: 10),
                    campoTexto('Sobrenome', txtSobrenome,false),
                    const SizedBox(height: 10),
                    campoTexto('DDD', txtDDD,false),
                    const SizedBox(height: 10),
                    campoTexto('Telefone', txtTelefone,false),
                    const SizedBox(height: 30),
                    campoTexto('Senha', txtSenha, true),
                    const SizedBox(height: 10),
                    campoTexto('Senha', txtSenha1, true),
                    botao('cadastrar'),
                    ],
                  ),
            ),
          ),
        )
    ),
  );   
}


campoTexto(rotulo, variavel,senha){
  return TextFormField(
      //Associar a variável de controle
      controller: variavel,style: TextStyle(fontSize: 22,color: Colors.grey.shade900,),
      keyboardType: TextInputType.text,//Teclado numérico
     
      obscureText: senha,//Senha
      maxLength: 100,//Quant. máxima de caracteres

      decoration: InputDecoration(labelText: rotulo,labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade600,),hintText:'',hintStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400,), border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),),),//Border.all(width: 2.0),
      
      //--------- Validação da entrada do usuário----------//
      
      validator: (value) {
        value = value!.replaceFirst(',', '.');
        //verificar se o usuário digitou um valor
        //numérico ->(double.tryParse(value) == null) 
        if (value == null || value.isEmpty){
          return 'Nenhum valor registrado';
        } else {
          return null;
        }
     },
    //),
  );
}

botao(rotulo){
  return SizedBox(width: 150,height: 50,
    //Tipos de botões //ElevatedButton //TextButton //OutlinedButton
    //comportamento
      child: ElevatedButton(onPressed: () {  
          //Validação dos campos do formulário
          if (form.currentState!.validate()) {
            setState(() {
              //
              String senha = (txtSenha.text.replaceFirst(',', '.'));
              String senha1 = (txtSenha1.text.replaceFirst(',', '.'));
              
              if (senha != senha1)
              {
              caixaDialogo('Senha não corresponde');

              }
              else{
                Navigator.pushNamed(context, 't1');
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 3),
                  elevation: 0,
                  content: Text('Cadastro realizado com sucesso',
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

caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Senha invalida'),
          content: Text(
            msg,
            style: const TextStyle(fontSize: 24),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    txtSenha1.clear();
                    //txtSenha.clear();
                  });
                },
                child: const Text('fechar')),
          ],
        );
      },
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