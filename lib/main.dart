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
      title: "Biblioteca",
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
  final _preenchido = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro de um livro"),
          backgroundColor: Colors.purple[400],
        ),
        body: Form(
          key: _preenchido,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeCtrl,
                decoration: const InputDecoration(hintText: "Nome do livro"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não deixe este campo vazio!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _isbnCtrl,
                decoration: const InputDecoration(hintText: "ISBN"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não deixe este campo vazio!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anoCtrl,
                decoration:
                    const InputDecoration(hintText: "Ano de publicação"),
                //permite que apenas números sejam inseridos
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não deixe este campo vazio!";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _opiniaoCtrl,
                decoration: const InputDecoration(hintText: "Opiniao"),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Não deixe este campo vazio!";
                  }
                  return null;
                },
              ),
              const Spacer(),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.orange),
                  onPressed: () {
                    if (_preenchido.currentState!.validate()) {
                      final String nome = _nomeCtrl.text;
                      final String isbn = _isbnCtrl.text;
                      final String opiniao = _opiniaoCtrl.text;
                      final int anoPublicacao = int.parse(_anoCtrl.text);
                      print(LivroController.persistirTemp(
                          nome, isbn, opiniao, anoPublicacao));

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Livro gravado com sucesso!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                      _nomeCtrl.clear();
                      _isbnCtrl.clear();
                      _opiniaoCtrl.clear();
                      _anoCtrl.clear();
                    }
                  },
                  child: const Text("Registrar livro"),
                ),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple[400],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Voltar"),
                ),
              )),
            ],
          ),
        ));
  }
}
