class UrunlerModel {
  final List<Urun> urunler;    // urun classından bir liste oluşturur
final List<kategori> kategoriler;  // kategori classından bir liste oluşturur

  UrunlerModel(this.urunler, this.kategoriler);   // constructor

  factory UrunlerModel.fromJson(Map<String, dynamic> json) {   // factory constructor json verisini alır ve UrunlerModel nesnesi oluşturur
    final List jsonUrunler = json['urunler'];  // json verisinden urunler listesini alır
    final List jsonKategoriler = json['kategoriler']; // json verisinden kategoriler listesini alır

    return UrunlerModel(   
      jsonUrunler.map((e) => Urun.fromJson(e)).toList(),  // urunler listesini Urun nesnelerine dönüştürür
      jsonKategoriler.map((e) => kategori.fromJson(e)).toList(),  // kategoriler listesini kategori nesnelerine dönüştürür
    );
  }
}
 // tolist yapmazsan listeyi döndürmez
class Urun {
  final int id;
  final int kategori;
  final String isim;
  final String resim;

  Urun(this.id, this.kategori, this.isim, this.resim);

  Urun.fromJson(Map<String, dynamic> json)  // json verisini alır ve Urun nesnesi oluşturur
    : id = json['id'],
      kategori = json['kategori'],
      isim = json['isim'],
      resim = json['resim'];
}

class kategori {
  final int id;
  final String isim;

  kategori(this.id, this.isim);

  kategori.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      isim = json['isim'];
}
