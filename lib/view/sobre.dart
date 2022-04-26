import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  final String text;
  const Sobre({ Key? key ,required this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          
          title: const Text('Sobre - App'),
          //centerTitle: true,
          
          content: Column(
            children: [
              Text(
              text,
              style: const TextStyle(fontSize: 24),
            ),
          const SizedBox(height: 30,),
          Image.network('assets/lib/imagens/foto.jpg',scale:1.8),
          //Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
          //Image.asset(imagem),
          ],
          ),
          actions: [
            
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('fechar')),
          ],
        );
      }
  }