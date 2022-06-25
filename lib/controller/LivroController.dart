import 'package:trabalho/model/Livro.dart';

class LivroController {
  static Livro persistirMemoria(
      String nome, String isbn, String opiniao, int anoPublicacao) {
    Livro livro = Livro(nome, isbn, opiniao, anoPublicacao);
    return livro;
  }
}
