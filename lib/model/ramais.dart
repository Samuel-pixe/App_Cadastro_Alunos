class Ramais {
  String id;
  String setor;
  String numero;
  

  Ramais(this.id, this.setor, this.numero);

  //Transformar dados no formato JSON em um objeto
  //da classe Ramais
  factory Ramais.fromJson(String id,Map<String, dynamic> json) {
    return Ramais(
        id,
        json["setor"],
        json["numero"],
        );
  }
}
