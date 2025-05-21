import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/urunler_model.dart';


class Market extends StatefulWidget {
  const Market({super.key});

  @override
  State<Market> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Market> {
  UrunlerModel? _veriler;
  List<Urun> _urunler = [];

  void _loadData() async {   // json dosyasını yükler async uygulamanın asenkron çalışmasını sağlar
    final dataString = await rootBundle.loadString('assets/files/data (1).json');  // json dosyasını yükler
    final dataJson = jsonDecode(dataString); // json dosyasını decode eder 

    _veriler = UrunlerModel.fromJson(dataJson);  // json verisini UrunlerModel nesnesine dönüştürür
    _urunler = _veriler!.urunler;  // urunler listesini alır
    setState(() {});
  }

  void _filterData(int id) {
    _urunler = _veriler!.urunler  // urunler listesini alır
        .where((verilerEleman) => verilerEleman.kategori == id)  // kategori id'sine göre filtreler
        .toList();

    setState(() {});
  }

  void _resetFilter() {
    _urunler = _veriler!.urunler;
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _veriler == null  // veriler null ise yükleniyor yazısını gösterir
            ? const Text('Yükleniyor')
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // ana eksende içeriği ortalar
                children: [
                  ElevatedButton(
                    onPressed: _resetFilter,
                    child: const Text('Tüm Ürünler'),
                  ),
                  _kategorilerView(),
                  _urunlerView(),
                ],
              ),
      ),
    );
  }

  ListView _urunlerView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _urunler.length,
      itemBuilder: (context, index) {
        final Urun urun = _urunler[index];
        return ListTile(
          leading: Image.network(urun.resim,
              width: 50, height: 50, fit: BoxFit.cover),
          title: Text(urun.isim),
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 10),
    );
  }

  Row _kategorilerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _veriler!.kategoriler.length,
        (index) {
          final kategori = _veriler!.kategoriler[index];
          return GestureDetector(
            onTap: () => _filterData(kategori.id),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(kategori.isim),
            ),
          );
        },
      ),
    );
  }
}