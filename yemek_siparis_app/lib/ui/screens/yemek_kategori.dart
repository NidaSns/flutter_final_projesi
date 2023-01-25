import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_app/ui/screens/yemek_detay_sayfa.dart';
import '../../data/entity/yemekler.dart';
import '../cubit/anasayfa_cubit.dart';

enum SecilenTab { yemek, icecek, tatli }

class YemekKategori extends StatefulWidget {
  final SecilenTab secilentab;

  const YemekKategori({required this.secilentab, Key? key}) : super(key: key);

  @override
  State<YemekKategori> createState() => _YemekKategoriState();
}

class _YemekKategoriState extends State<YemekKategori> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AnasayfaCubit, List<Yemekler>>(
      builder: (context, yemeklerListesi) {
        int? yiyecekLength;
        List<Yemekler> yemek = [];
        List<Yemekler> icecek = [];
        List<Yemekler> tatli = [];
        for (var element in yemeklerListesi) {
          if (element.yemek_adi == "Ayran" ||
              element.yemek_adi == "Fanta" ||
              element.yemek_adi == "Kahve" ||
              element.yemek_adi == "Su") {
            icecek.add(element);
            yiyecekLength = icecek.length;
          } else if (element.yemek_adi == "Sütlaç" ||
              element.yemek_adi == "Tiramisu" ||
              element.yemek_adi == "Kadayıf" ||
              element.yemek_adi == "Baklava") {
            tatli.add(element);
            yiyecekLength = tatli.length;
          } else {
            yemek.add(element);
            yiyecekLength = yemek.length;
          }
        }
        if (yemeklerListesi.isNotEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: yiyecekLength, //yemeklerListesi.length,
            itemBuilder: (context, index) {
              Yemekler food;
              if (widget.secilentab == SecilenTab.icecek) {
                food = icecek[index];
              } else if (widget.secilentab == SecilenTab.tatli) {
                food = tatli[index];
              } else {
                food = yemek[index];
              }
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              YemekDetaySayfa(yemek: food))).then((value) {
                    context.read<AnasayfaCubit>().yemekleriYukle();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: width / 3,
                          child: Image.network(
                              "http://kasimadalan.pe.hu/yemekler/resimler/${food.yemek_resim_adi}"),
                        ),
                        Text(
                          food.yemek_adi,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Fiyat:${food.yemek_fiyat}₺"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
