import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          title: const Text("E-livros")),
      body: const InicioEstadoBiblioteca(),
    );
  }
}

class InicioEstadoBiblioteca extends StatefulWidget {
  const InicioEstadoBiblioteca({Key? key}) : super(key: key);

  @override
  AdicionarLivro createState() => AdicionarLivro();
}

class AdicionarLivro extends State<InicioEstadoBiblioteca> {
  //const AdicionarLivro({Key? key}) : super(key: key);

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
  bool _preenchido = GlobalKey<FormState>() as bool;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro de um livro"),
        backgroundColor: Colors.purple[400],
      ),
      body: Column(children: [
        TextField(
          controller: _nomeCtrl,
          decoration: InputDecoration(
            hintText: "Nome do livro",
            errorText: _preenchido ? 'Este campo não pode ser vazio!' : null,
          ),
        ),
        TextField(
          controller: _isbnCtrl,
          decoration: const InputDecoration(hintText: "ISBN"),
        ),
        //tratamento para inserção de apenas números
        TextField(
          controller: _anoCtrl,
          decoration: const InputDecoration(hintText: "Ano"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        ),
        TextField(
          maxLines: 10,
          controller: _opiniaoCtrl,
          decoration: const InputDecoration(hintText: "Opinião"),
        ),
        const Spacer(), //separa o botão dos campos de texto
        SizedBox(
          width: 400,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple[400],
              ),
              onPressed: () {
                // setState(() {
                //   _nomeCtrl.text.isEmpty
                //       ? _preenchido = true
                //       : _preenchido = false;
                // });

                final String nome = _nomeCtrl.text;
                final String isbn = _isbnCtrl.text;
                final String opiniao = _opiniaoCtrl.text;
                final int anoPublicacao = int.parse(_anoCtrl.text);
                print(LivroController.persistirTemp(
                    nome, isbn, opiniao, anoPublicacao));
                //valida de o formulário está preenchido
              },
              child: const Text("Registrar")),
        ),
        SizedBox(
          width: 400,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Voltar")),
        ),
      ]),
    );
  }
}
