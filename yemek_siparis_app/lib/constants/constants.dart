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

  // Login
  final String girisPasswordYz = 'Parola';
  final String girisButonYz = 'Giriş';
  final String girisSifreUnuttumYz = 'Şifremi Unuttum';
  final String girisMailYz = 'Email';
  final String loginKayitOlunYz = 'Üye değil misiniz? Kaydolmak için tıklayın';
  final String loginKaydolYz = 'Kayıt Ol';
  final String kullaniciAdiYz = 'Kullanıcı Adı';
  final String loginUyari = 'Boş geçilemez';
}
