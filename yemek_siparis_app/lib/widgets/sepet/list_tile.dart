import 'package:flutter/material.dart';

import '../../../data/entity/sepettekiler.dart';

class ListTileBasket extends StatelessWidget {
  final Sepettekiler sepet;

  const ListTileBasket({
    super.key,
    required this.sepet,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        sepet.sepet_yemek_adi,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        textAlign: TextAlign.left,
        "${sepet.sepet_yemek_fiyat}₺",
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black45,
        ),
      ),
    );
  }
}
