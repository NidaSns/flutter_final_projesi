import 'package:flutter/material.dart';
import '../../data/entity/sepettekiler.dart';

class ToplamFiyat extends StatelessWidget {
  const ToplamFiyat({required this.sepet, Key? key}) : super(key: key);
  final List<Sepettekiler> sepet;

  String calculateTotalPrice() {
    var totalPrice = 0;
    for (var item in sepet) {
      totalPrice += int.parse(item.sepet_yemek_fiyat) *
          int.parse(item.sepet_siparis_adet);
    }
    return totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Toplam Fiyat: calculateTotalPrice₺",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
