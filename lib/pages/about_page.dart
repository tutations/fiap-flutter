import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Bolão entre amigos',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Você poderá ver a lista de jogos e realizar os seus palpites para os jogos',
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Ao clicar em um jogo na lista, você poderá incluir ou alterar um palpite caso o jogo não tenha iniciado.',
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'Ao acessar o menu Palpites você poderá ver todos os seus palpites já cadastrados.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
