import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entity/sepettekiler.dart';
import '../entity/sepettekiler_cevap.dart';
import '../entity/yemekler.dart';
import '../entity/yemekler_cevap.dart';

class YemeklerDaoRepository {
  List<Sepettekiler> sepetCevap = [];

  List<Yemekler> parseYemeklerCevap(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<Sepettekiler> parseSepettekilerCevap(String cevap) {
    if (cevap == "\n\n\n\n\n") {
      sepetCevap = [];
    } else {
      sepetCevap = SepettekilerCevap.fromJson(json.decode(cevap)).sepettekiler;
    }
    return sepetCevap;
  }

  Future<void> sepeteEkle(
    String yemekAdi,
    String yemekResimAdi,
    String yemekFiyat,
    String yemekSiparisAdet,
    String kullaniciAdi,
  ) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    // sepette zaten olan yemek bulunur
    for (var element in sepetCevap) {
      if (element.sepet_yemek_adi == yemekAdi) {
        sepettenYemekSil(int.parse(element.sepet_yemek_id), kullaniciAdi);
        yemekSiparisAdet = (int.parse(yemekSiparisAdet) + 1).toString();
      }
    }
    var veri = {
      "yemek_adi": yemekAdi,
      "yemek_resim_adi": yemekResimAdi,
      "yemek_fiyat": yemekFiyat,
      "yemek_siparis_adet": yemekSiparisAdet,
      "kullanici_adi": kullaniciAdi
    };
    await http.post(url, body: veri);
  }

  Future<List<Yemekler>> tumYemekleriGetir() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<List<Sepettekiler>> sepettekiYemekleriGetir(
      String kullaniciAdi) async {
    var url = Uri.parse(
        "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri = {"kullanici_adi": kullaniciAdi};
    var cevap = await http.post(url, body: veri);
    return parseSepettekilerCevap(cevap.body);
  }

  Future<List<Yemekler>> sepeteYemekEkle() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var cevap = await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }

  Future<void> sepettenYemekSil(int sepetYemekId, String kullaniciAdi) async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri = {
      "sepet_yemek_id": sepetYemekId.toString(),
      "kullanici_adi": kullaniciAdi
    };
    await http.post(url, body: veri);
  }
}
