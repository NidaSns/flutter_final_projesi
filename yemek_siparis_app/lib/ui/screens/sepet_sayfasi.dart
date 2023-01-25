import 'package:flutter/material.dart';
import 'package:yemek_siparis_app/data/entity/sepettekiler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_app/ui/constants/constants.dart';
import '../cubit/sepet_cubit.dart';
import '../widgets/dropdown_button.dart';
import '../widgets/round_rectangle_border.dart';

class SepetSayfasi extends StatefulWidget {
  final String kullaniciAdi;

  const SepetSayfasi({required this.kullaniciAdi, Key? key}) : super(key: key);

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {
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
    double width = MediaQuery.of(context).size.width;
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
                    return ListView.builder(
                        key: widget.key,
                        itemCount: sepettekilerListesi.length,
                        itemBuilder: (context, index) {
                          var sepet = sepettekilerListesi[index];
                          String dropdownValue = sepet.sepet_siparis_adet;
                          //String dropdownValue = calculate(sepet, fiyat);
                          return Padding(
                            padding: const EdgeInsets.all(15),
                            child: Card(
                              borderOnForeground: true,
                              shape: RoundRectangleBorderTasarimi()
                                  .roundedRectangleBorder(context),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: width / 4,
                                                child: Image.network(
                                                    "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.sepet_yemek_resim_adi}"),
                                              ),
                                              Text(
                                                sepet.sepet_yemek_adi,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 25),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Column(
                                          children: [
                                            DropDownButtonTasarimi(
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    dropdownValue = value!;
                                                  });
                                                },
                                                dropdownValue: dropdownValue),
                                            Text(
                                              "Birim Fiyat: ${sepet.sepet_yemek_fiyat}₺",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    width: width / 2.5,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<SepetCubit>()
                                            .sepettenYemekSil(
                                                int.parse(sepet.sepet_yemek_id),
                                                sepet.kullanici_adi);
                                      },
                                      child: const Text("Sil"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  // Text(
                  //   "Toplam Fiyat: ${ApplicationConstants.toplamFiyat} ₺",
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(
                    width: width / 2,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.check_circle_rounded),
                      onPressed: () {
                        ///toDo
                      },
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
        ),
      ),
    );
  }

  // String calculate(Sepettekiler sepet, double fiyat) {
  //   String dropdownValue = sepet.sepet_siparis_adet;
  //   fiyat = double.parse(sepet.sepet_yemek_fiyat);
  //   int urunAdet = int.parse(dropdownValue);
  //   double birimToplam = urunAdet * fiyat;
  //   ApplicationConstants.toplamFiyat += birimToplam;
  //   return dropdownValue;
  // }
}
