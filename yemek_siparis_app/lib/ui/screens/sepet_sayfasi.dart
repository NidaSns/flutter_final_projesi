import 'package:flutter/material.dart';
import 'package:yemek_siparis_app/data/entity/sepettekiler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_app/ui/constants/constants.dart';
import 'package:yemek_siparis_app/ui/screens/toplam_fiyat.dart';
import '../cubit/sepet_cubit.dart';
import '../widgets/sepet/add_minus_icons.dart';
import '../widgets/sepet/list_tile.dart';

class SepetSayfasi extends StatefulWidget {
  final String kullaniciAdi;

  const SepetSayfasi({required this.kullaniciAdi, Key? key}) : super(key: key);

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {
  String toplamFiyat = "";

  @override
  void initState() {
    context
        .read<SepetCubit>()
        .sepettekiYemekleriGetir(widget.kullaniciAdi)
        .whenComplete(
            () => ApplicationConstants.instance!.sepetData = "Sepet Boş");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SepetCubit>().sepettekiYemekleriGetir(widget.kullaniciAdi);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: BlocBuilder<SepetCubit, List<Sepettekiler>>(
                builder: (context, sepettekilerListesi) {
                  if (sepettekilerListesi.isNotEmpty) {
                    toplamFiyat = ToplamFiyat(sepet: sepettekilerListesi)
                        .calculateTotalPrice();
                    return Column(
                      children: [
                        SizedBox(
                          height: height / 1.5,
                          child: ListView.builder(
                              key: widget.key,
                              itemCount: sepettekilerListesi.length,
                              itemBuilder: (context, index) {
                                var sepet = sepettekilerListesi[index];
                                String dropdownValue = sepet.sepet_siparis_adet;
                                return Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Card(
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          child: Image.network(
                                              "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.sepet_yemek_resim_adi}"),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              ListTileBasket(sepet: sepet),
                                              AddMinusIcons(
                                                dropdownValue: dropdownValue,
                                                sepet: sepet,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                        Align(
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
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: ApplicationConstants.instance!.sepetData == ""
                          ? const Center(child: CircularProgressIndicator())
                          : Text(ApplicationConstants.instance!.sepetData),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
