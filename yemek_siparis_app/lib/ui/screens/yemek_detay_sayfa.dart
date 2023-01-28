import 'package:flutter/material.dart';
import 'package:yemek_siparis_app/ui/cubit/sepet_cubit.dart';
import '../../constants/constants.dart';
import '../../data/entity/yemekler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/dropdown_button.dart';

// ignore: must_be_immutable
class YemekDetaySayfa extends StatefulWidget {
  Yemekler yemek;

  YemekDetaySayfa({required this.yemek, Key? key}) : super(key: key);

  @override
  State<YemekDetaySayfa> createState() => _YemekDetaySayfaState();
}

class _YemekDetaySayfaState extends State<YemekDetaySayfa> {
  @override
  void initState() {
    super.initState();
  }

  String dropdownValue = ApplicationConstants.instance!.adet.first.toString();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemek Detay"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        fit: StackFit.loose,
        children: [
          SizedBox(
            width: width,
            child: Image.asset(
              "assets/resimler/images.jpg",
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: height * 0.6,
                width: width * 0.75,
                child: Card(
                  borderOnForeground: true,
                  elevation: 50,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        child: Image.network(
                            "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
                      ),
                      Text(
                        widget.yemek.yemek_adi,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DropDownButtonTasarimi(
                              onChanged: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownValue: dropdownValue),
                          Text(
                            "${widget.yemek.yemek_fiyat}₺",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<SepetCubit>()
                              .sepeteEkle(
                                widget.yemek.yemek_adi,
                                widget.yemek.yemek_resim_adi,
                                widget.yemek.yemek_fiyat,
                                dropdownValue,
                                ApplicationConstants.kullaniciAdi,
                              )
                              .then((value) => Navigator.pop(context));
                        },
                        child: const Text("Sepete Ekle"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
