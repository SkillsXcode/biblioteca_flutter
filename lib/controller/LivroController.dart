import 'package:trabalho/model/Livro.dart';

class LivroController {
  static List<Livro> livros = [];
  static Livro persistirTemp(
      String nome, String isbn, String opiniao, int anoPublicacao) {
    Livro livro = Livro(nome, isbn, opiniao, anoPublicacao);
    return livro;
  }

  static List<Livro> adicionarLivro(Livro livro) {
    livros.add(livro);
    return livros;
  }
  //criar uma lista de livros
}
