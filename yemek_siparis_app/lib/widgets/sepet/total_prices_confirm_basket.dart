import 'package:flutter/material.dart';

class TotalPricesConfirmBasket extends StatelessWidget {
  final String toplamFiyat;
  final double width;

  const TotalPricesConfirmBasket(
      {required this.toplamFiyat, required this.width, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        children: [
          Text(
            "Toplam Fiyat: $toplamFiyat ₺",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: width / 2,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check_circle_rounded),
              onPressed: () {},
              label: const Text("Sepeti Onayla"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
