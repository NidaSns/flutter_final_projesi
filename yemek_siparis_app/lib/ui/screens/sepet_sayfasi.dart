import 'package:flutter/material.dart';
import 'package:yemek_siparis_app/data/entity/sepettekiler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_app/ui/screens/toplam_fiyat.dart';
import '../../constants/constants.dart';
import '../../widgets/sepet/add_minus_icons.dart';
import '../../widgets/sepet/list_tile.dart';
import '../../widgets/sepet/total_prices_confirm_basket.dart';
import '../cubit/sepet_cubit.dart';

class SepetSayfasi extends StatefulWidget {
  final String kullaniciAdi;

  const SepetSayfasi({required this.kullaniciAdi, Key? key}) : super(key: key);

  @override
  State<SepetSayfasi> createState() => _SepetSayfasiState();
}

class _SepetSayfasiState extends State<SepetSayfasi> {
  String toplamFiyat = "";
  late AssetImage image;

  @override
  void initState() {
    context
        .read<SepetCubit>()
        .sepettekiYemekleriGetir(widget.kullaniciAdi)
        .whenComplete(
            () => ApplicationConstants.instance!.sepetData = "Sepet Boş");
    image = const AssetImage("assets/gif/delivery.gif");
    super.initState();
  }

  @override
  void dispose() {
    image.evict();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SepetCubit>().sepettekiYemekleriGetir(widget.kullaniciAdi);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Column(
                  children: [
                    PreferredSize(
                      preferredSize: const Size.fromHeight(4),
                      child: Container(
                        color: Colors.red,
                        height: 4,
                        child: const LinearProgressIndicator(
                          color: Colors.red,
                          value: 0.7,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: width / 3,
                          height: height / 5,
                          child: Image(
                            image: image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(
                          width: 150,
                          child: Text.rich(
                            TextSpan(
                              text: "Tahmini Teslimat",
                              children: [
                                TextSpan(
                                    text: " Hemen (30 DK)",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              BlocBuilder<SepetCubit, List<Sepettekiler>>(
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
                                return Card(
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
                                );
                              }),
                        ),
                        TotalPricesConfirmBasket(
                            width: width, toplamFiyat: toplamFiyat),
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
            ],
          ),
        ),
      ),
    );
  }
}
