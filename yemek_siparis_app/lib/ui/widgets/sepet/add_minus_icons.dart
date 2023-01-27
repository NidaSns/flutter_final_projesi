import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/entity/sepettekiler.dart';
import '../../cubit/sepet_cubit.dart';

class AddMinusIcons extends StatelessWidget {
  final String dropdownValue;
  final Sepettekiler sepet;

  const AddMinusIcons({
    super.key,
    required this.dropdownValue,
    required this.sepet,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.remove_circle_outline,
          ),
        ),
        Text(
          dropdownValue,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.add_circle_outline,
          ),
        ),
        IconButton(
          onPressed: () {
            context.read<SepetCubit>().sepettenYemekSil(
                int.parse(sepet.sepet_yemek_id), sepet.kullanici_adi);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
