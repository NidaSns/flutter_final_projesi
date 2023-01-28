class ApplicationConstants {
  static final ApplicationConstants _instance = ApplicationConstants._init();

  static ApplicationConstants? get instance {
    return _instance;
  }

  ApplicationConstants._init();

  static const kullaniciAdi = "n";
  List<int> adet = List<int>.generate(51, (counter) => counter + 1);

  late String yemekData = "";
  late String sepetData = "";
}
