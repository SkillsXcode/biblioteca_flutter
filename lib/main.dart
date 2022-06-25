import 'package:flutter/material.dart';
import 'package:trabalho/controller/LivroController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Biblioteca(),
    );
  }
}

class Biblioteca extends StatelessWidget {
  const Biblioteca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple[400],
          centerTitle: true,
          title: Text("E-livros")),
      body: const BotaoAdicionarLivro(),
    );
  }
}

class BotaoAdicionarLivro extends StatelessWidget {
  const BotaoAdicionarLivro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormCadastroLivro()),
          );
        },
        backgroundColor: Colors.purple[400],
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormCadastroLivro extends StatelessWidget {
  FormCadastroLivro({Key? key}) : super(key: key);

  final TextEditingController _nomeCtrl = TextEditingController();
  final TextEditingController _isbnCtrl = TextEditingController();
  final TextEditingController _opiniaoCtrl = TextEditingController();
  final TextEditingController _anoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de um livro"),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(children: [
        TextField(
          controller: _nomeCtrl,
          decoration: InputDecoration(hintText: "Nome do livro"),
        ),
        TextField(
          controller: _isbnCtrl,
          decoration: InputDecoration(hintText: "ISBN"),
        ),
        TextField(
          controller: _anoCtrl,
          decoration: InputDecoration(hintText: "Ano"),
        ),
        TextField(
          controller: _opiniaoCtrl,
          decoration: InputDecoration(hintText: "Opinião"),
        ),
        Spacer(), //separa o botão dos campos de texto
        Container(
          width: 400,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[400],
              ),
              onPressed: () {
                final String nome = _nomeCtrl.text;
                final String isbn = _isbnCtrl.text;
                final String opiniao = _opiniaoCtrl.text;
                final int anoPublicacao = int.parse(_anoCtrl.text);
                print(LivroController.persistirTemp(
                    nome, isbn, opiniao, anoPublicacao));
              },
              child: const Text("Registrar")),
        ),
        Container(
          width: 400,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.purple[600]),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Voltar")),
        ),
      ]),
    );
  }
}
