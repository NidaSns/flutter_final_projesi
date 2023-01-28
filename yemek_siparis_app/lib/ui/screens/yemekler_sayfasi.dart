import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/yemek_kategori.dart';
import '../../constants/constants.dart';
import '../cubit/anasayfa_cubit.dart';

class YemeklerSayfasi extends StatefulWidget {
  final SecilenTab secilenTab;

  const YemeklerSayfasi({required this.secilenTab, Key? key}) : super(key: key);

  @override
  State<YemeklerSayfasi> createState() => _YemeklerSayfasiState();
}

class _YemeklerSayfasiState extends State<YemeklerSayfasi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle().whenComplete(() {
      setState(() {
        ApplicationConstants.instance!.yemekData = "Yemekler geldi";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      fit: StackFit.loose,
      children: [
        SizedBox(
          width: width,
          child: Image.asset(
            "assets/resimler/images.jpg",
            fit: BoxFit.contain,
          ),
        ),
        DefaultTabController(
          length: 3,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  pinned: true,
                  toolbarHeight: 80,
                  leadingWidth: 80,
                  expandedHeight: 200.0,
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "İçecek",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Yemek",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Tatlı",
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: ApplicationConstants.instance!.yemekData == ""
                ? const Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const TabBarView(
                    children: [
                      YemekKategori(
                        secilentab: SecilenTab.icecek,
                      ),
                      YemekKategori(
                        secilentab: SecilenTab.yemek,
                      ),
                      YemekKategori(
                        secilentab: SecilenTab.tatli,
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
