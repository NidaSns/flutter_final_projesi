import 'package:flutter/material.dart';
import 'package:yemek_siparis_app/ui/screens/yemek_kategori.dart';
import 'package:yemek_siparis_app/ui/screens/yemekler_sayfasi.dart';
import '../../constants/constants.dart';
import 'sepet_sayfasi.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
  }

  int secilenIndex = 0;

  @override
  Widget build(BuildContext context) {
    var sayfaListesi = const [
      YemeklerSayfasi(secilenTab: SecilenTab.icecek),
      SepetSayfasi(kullaniciAdi: ApplicationConstants.kullaniciAdi)
    ];
    return Scaffold(
      appBar: AppBar(
        title:
            secilenIndex == 0 ? const Text("Yemekler") : const Text("Sepetim"),
      ),
      body: sayfaListesi[secilenIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_sharp),
            label: "Sepetim",
          ),
        ],
        currentIndex: secilenIndex,
        onTap: (index) {
          setState(() {
            secilenIndex = index;
          });
        },
      ),
    );
  }
}
