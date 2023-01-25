class Sepettekiler {
  String sepet_yemek_id;
  String sepet_yemek_adi;
  String sepet_yemek_resim_adi;
  String sepet_yemek_fiyat;
  String sepet_siparis_adet;
  String kullanici_adi;

  Sepettekiler(
      {required this.sepet_yemek_id,
      required this.sepet_yemek_adi,
      required this.sepet_yemek_resim_adi,
      required this.sepet_yemek_fiyat,
      required this.kullanici_adi,
      required this.sepet_siparis_adet});

  factory Sepettekiler.fromJson(Map<String, dynamic> json) {
    return Sepettekiler(
      sepet_yemek_id: json["sepet_yemek_id"] as String,
      sepet_yemek_adi: json["yemek_adi"] as String,
      sepet_yemek_resim_adi: json["yemek_resim_adi"] as String,
      sepet_yemek_fiyat: json["yemek_fiyat"] as String,
      sepet_siparis_adet: json["yemek_siparis_adet"] as String,
      kullanici_adi: json["kullanici_adi"] as String,
    );
  }
}
