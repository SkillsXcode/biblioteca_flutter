class Livro {
  final String nome;
  final String isbn;
  final String opiniao;
  final int anoPublicacao;

  Livro(this.nome, this.isbn, this.opiniao, this.anoPublicacao);

  @override
  String toString() {
    return 'Livro{nome: $nome, isbn: $isbn, opiniao: $opiniao, anoPublicacao: $anoPublicacao}';
  }
}
