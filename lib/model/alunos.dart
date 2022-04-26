class Alunos {
  int codigo;
  String name;
  String curso;
  String email;
  

  Alunos(this.codigo, this.name, this.curso, this.email);

  //Transformar dados no formato JSON em um objeto
  //da classe Pais
  factory Alunos.fromJson(Map<String, dynamic> json) {
    return Alunos(
        json['codigo'],
        json["name"],
        json["curso"],
        json["email"]);
  }
}
