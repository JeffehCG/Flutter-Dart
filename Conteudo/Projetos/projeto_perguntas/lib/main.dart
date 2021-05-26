import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_perguntas/questionario.dart';
import 'package:projeto_perguntas/resultado.dart';

main(List<String> args) {
  runApp(new PerguntaApp());
}

// Essa classe ira gerenciar o estado do compomente PerguntaApp
class _PerguntaAppState extends State<PerguntaApp> {
  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': 'Qual é a sua cor favorita?',
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 5},
        {'texto': 'Verde', 'pontuacao': 3},
        {'texto': 'Branco', 'pontuacao': 1}
      ]
    },
    {
      'texto': 'Qual é o seu animal favorito?',
      'respostas': [
        {'texto': 'Coelho', 'pontuacao': 10},
        {'texto': 'Cobra', 'pontuacao': 5},
        {'texto': 'Elefante', 'pontuacao': 3},
        {'texto': 'Leão', 'pontuacao': 1}
      ]
    },
    {
      'texto': 'Qual é o seu instrutor favorito?',
      'respostas': [
        {'texto': 'Maria', 'pontuacao': 10},
        {'texto': 'João', 'pontuacao': 5},
        {'texto': 'Leo', 'pontuacao': 3},
        {'texto': 'Pedro', 'pontuacao': 1}
      ]
    },
  ];

  var _pontuacaoTotal = 0;
  var _perguntaSelecionada = 0;
  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        // Tudo que ira sofrer alteração devera estar dentro de um setState para ser monitorado
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }

    print('Pergunta respondida!');
  }

  void _reiniciarQuestionario() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    // build, metodo que obrigatoriamente deve ser sobreescrito

    // for (var textoResposta in respostas) {
    //   widgeds.add(Resposta(textoResposta, _responder));
    // }

    // Arvore de Widget (Componentes que iram estruturar o APP) (Existem widgets visiveis e invisiveis)
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Perguntas'),
        ),
        body: temPerguntaSelecionada // Extrutura condicional para componentes
            ? Questionario(_perguntas, _perguntaSelecionada, _responder,
                temPerguntaSelecionada)
            : Resultado(_pontuacaoTotal, _reiniciarQuestionario),
      ),
    );
  }
}

// Componente principal da aplicação
class PerguntaApp extends StatefulWidget {
  // StatelessWidget - Sem estado , StatefulWidget - com estado
  @override
  // O estado que ira atender o componente Stateful
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}

// Em uma recente atualização do Flutter, os botões foram modificados e agora temos novos padrões a serem adotados. Quem instalar o Flutter na versão mais recente, receberá um aviso de que alguns botões estão deprecated. Mas podem ficar tranquilos que as mudanças não são tão grandes! Precisamos apenas trocar os tipos dos botões.
// Ou seja, No lugar de um FlatButton, usaremos TextButton. No lugar de RaisedButton, usaremos ElevatedButton.

// Statelles Vs Stateful
// No stateless o compenente não tem estado, ou seja, ele não sofre alteração internamente,
// apenas externamente atravez de um componente pai enviando parametros. Assim ocorre um reenderização
// Ja no Stateful o componente tem estado, ou seja, pode sofre alteração interna e externamente
// Assim ocorrendo tambem uma rerenderização