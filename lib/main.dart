import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trabalho/controller/LivroController.dart';
import 'package:trabalho/model/Livro.dart';

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
        home: const Biblioteca());
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
      body: ListView.builder(
        itemCount: LivroController.livros.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: const Icon(Icons.book),
              trailing: const Text(
                "\$",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              onLongPress: () {
                LivroController.removerLivro(index);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Biblioteca()));
              },
              title: Text(LivroController.livros.elementAt(index).nome));
        },
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
                  return "N??o deixe este campo vazio!";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _isbnCtrl,
              decoration: const InputDecoration(
                  hintText: "ISBN ou outro identificador"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "N??o deixe este campo vazio!";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _anoCtrl,
              decoration: const InputDecoration(hintText: "Ano de publica????o"),
              //permite que apenas n??meros sejam inseridos
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "N??o deixe este campo vazio!";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _opiniaoCtrl,
              decoration: const InputDecoration(hintText: "Opini??o"),
              maxLines: 10,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "N??o deixe este campo vazio!";
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
                    Livro livroTemp = LivroController.persistirTemp(
                        nome, isbn, opiniao, anoPublicacao);
                    LivroController.adicionarLivro(livroTemp);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Livro gravado com sucesso!"),
                        duration:
                            Duration(seconds: 2), //tempo de duracao do snackBar
                        backgroundColor: Colors.green,
                      ),
                    );
                    //limpa os campos
                    _nomeCtrl.clear();
                    _isbnCtrl.clear();
                    _opiniaoCtrl.clear();
                    _anoCtrl.clear();
                    exibirMensagemConfirmacao(context);
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Biblioteca()));
                },
                child: const Text("Voltar"),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

exibirMensagemConfirmacao(BuildContext context) {
  Widget botarFicar = TextButton(
    child: const Text("Desejo cadastrar outro livro."),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget botaoSair = TextButton(
    child: const Text("Desejo sair."),
    //retorna ?? pilha ao estado inicial
    onPressed: () {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const Biblioteca())); //estrat??gia para fugir do setState
    },
  );
  AlertDialog aviso = AlertDialog(
    title: const Text("Oi! ????"),
    content: const Text("O que voc?? deseja fazer?"),
    actions: [
      botarFicar,
      botaoSair,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return aviso;
    },
  );
}
