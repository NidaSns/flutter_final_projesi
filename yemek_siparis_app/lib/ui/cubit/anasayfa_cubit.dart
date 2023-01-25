import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/yemekler.dart';
import '../../data/repo/yemeklerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);

  var krepo = YemeklerDaoRepository();

  Future<void> yemekleriYukle() async {
    var liste = await krepo.tumYemekleriGetir();
    emit(liste);
  }
}
