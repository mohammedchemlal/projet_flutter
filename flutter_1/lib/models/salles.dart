class salles{
  int idSalle;
  int etage;
  int batiment;
  int num;

  salles(
      this.idSalle,
      this.etage,
      this.batiment,
      this.num,
      );

  Map<String, dynamic> toJson() =>
      {
        'idS':idSalle.toString(),
        'name': etage,
        'username': batiment,
        'phoneNumber': num,
      };
}