import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/sepettekiler.dart';
import '../../data/repo/yemeklerdao_repository.dart';

class SepetCubit extends Cubit<List<Sepettekiler>> {
  SepetCubit() : super(<Sepettekiler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> sepeteEkle(String yemekAdi, String yemekResimAdi,
      String yemekFiyat, String yemekSiparisAdet, String kullaniciAdi) async {
    await krepo.sepeteEkle(
        yemekAdi, yemekResimAdi, yemekFiyat, yemekSiparisAdet, kullaniciAdi);
  }

  Future<void> sepettekiYemekleriGetir(String kullaniciAdi) async {
    var liste = await krepo.sepettekiYemekleriGetir(kullaniciAdi);
    emit(liste);
  }

  Future<void> sepettenYemekSil(int sepetYemekId, String kullaniciAdi) async {
    await krepo.sepettenYemekSil(sepetYemekId, kullaniciAdi);
    await sepettekiYemekleriGetir(kullaniciAdi);
  }
}
