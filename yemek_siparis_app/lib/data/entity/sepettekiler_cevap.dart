import 'package:yemek_siparis_app/data/entity/sepettekiler.dart';

class SepettekilerCevap {
  List<Sepettekiler> sepettekiler;
  int success;

  SepettekilerCevap({required this.sepettekiler, required this.success});

  factory SepettekilerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    var sepet_yemekler = jsonArray
        .map((jsonArrayNesnesi) => Sepettekiler.fromJson(jsonArrayNesnesi))
        .toList();
    print(jsonArray);
    //var sepet_yemekler;
    int adet = 0;
    var existing = Map<String, dynamic>();
    for (final item in sepet_yemekler) {
      existing.putIfAbsent(item.sepet_yemek_adi, () => item);
      print("item:$item");
    }
    print("existing : $existing");
    sepet_yemekler = sepet_yemekler = jsonArray
        .map((jsonArrayNesnesi) => Sepettekiler.fromJson(jsonArrayNesnesi))
        .toList();
    return SepettekilerCevap(
        sepettekiler: sepet_yemekler, success: json["success"] as int);
  }

  void _addToMappedList(Map<String, double> sampleList, Map newData) {
    String title = newData["title"];
    double? value = double.tryParse(newData["value"].toString());

    sampleList[title] = value!;
  }
}
