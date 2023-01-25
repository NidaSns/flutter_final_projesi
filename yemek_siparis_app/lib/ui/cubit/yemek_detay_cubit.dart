import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/yemeklerdao_repository.dart';

class YemekDetayCubit extends Cubit {
  YemekDetayCubit() : super(0);

  var krepo = YemeklerDaoRepository();

  // Future<void> guncelle(int yemek_id, String yemek_adi, String kisi_tel) async {
  //   await krepo.guncelle(kisi_id, kisi_ad, kisi_tel);
  // }
}
