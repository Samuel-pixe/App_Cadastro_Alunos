class Professores {
  String id;
  String nome;
  //String curso;
  String email;
  //String codigo;
  

  Professores(this.id, this.nome, this.email);

  //Transformar dados no formato JSON em um objeto
  //da classe Pais
  factory Professores.fromJson(String id,Map<String, dynamic> json) {
    return Professores(
        id,
        json["nome"],
        //json["curso"],
        json["email"],
       // json["codigo"]
        );
  }
}
