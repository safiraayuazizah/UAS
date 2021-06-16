import 'package:uas_safira/models/kategori.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/provider/kategori_provider.dart';

class EditKategori extends StatefulWidget {
  Kategori kategori;
  final String kategoriId;
  final String kode;
  final String nama;
  final int stok;
  final int ukuran;
  final String warna;

  EditKategori(this.kategoriId, this.kode, this.nama, this.stok, this.ukuran,
      this.warna);
  @override
  _EditKategoriState createState() => _EditKategoriState(this.kategoriId,
      this.kode, this.nama, this.stok, this.ukuran, this.warna);
}

class _EditKategoriState extends State<EditKategori> {
  TextEditingController kategoriIdController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController ukuranController = TextEditingController();
  TextEditingController warnaController = TextEditingController();
  String cek;
  @override
  void dispose() {
    kodeController.dispose();
    namaController.dispose();
    stokController.dispose();
    ukuranController.dispose();
    warnaController.dispose();
    super.dispose();
  }

  _EditKategoriState(String kategoriId, String kode, String nama, int stok,
      int ukuran, String warna) {
    if (kode != null) {
      kategoriIdController.text = kategoriId;
      kodeController.text = kode;
      namaController.text = nama;
      stokController.text = stok.toString();
      ukuranController.text = ukuran.toString();
      warnaController.text = warna;
      cek = "a";
    } else {
      cek = "nol";
    }
  }
  @override
  void initState() {
    if (cek == "nol") {
      //New Record
      kodeController.text = "";
      namaController.text = "";
      stokController.text = "";
      ukuranController.text = "";
      warnaController.text = "";
    } else {
      new Future.delayed(Duration.zero, () {
        final kategoriProvider =
            Provider.of<KategoriProvider>(context, listen: false);
        kategoriProvider.loadValues(
            kategoriIdController.text,
            kodeController.text,
            namaController.text,
            int.parse(stokController.text),
            int.parse(ukuranController.text),
            warnaController.text);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kategoriProvider = Provider.of<KategoriProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Kategori'),
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: TextField(
                  controller: kodeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Kode',
                    labelText: 'Masukkan Kode',
                    icon: Icon(Icons.create),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (value) {
                    kategoriProvider.changeKode(value);
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Nama',
                    labelText: 'Masukkan Nama',
                    icon: Icon(Icons.create),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (value) {
                    kategoriProvider.changeNama(value);
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Stok',
                    labelText: 'Masukkan Stok',
                    icon: Icon(Icons.create),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (value) => kategoriProvider.changeStok(value),
                )),
            Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: TextField(
                  controller: ukuranController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Ukuran',
                    labelText: 'Masukkan Ukuran',
                    icon: Icon(Icons.create),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (value) => kategoriProvider.changeUkuran(value),
                )),
            Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: TextField(
                  controller: warnaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Warna',
                    labelText: 'Masukkan Warna',
                    icon: Icon(Icons.create),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                  onChanged: (value) => kategoriProvider.changeWarna(value),
                )),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[400],
                onPrimary: Colors.black,
              ),
              child: Text('Save'),
              onPressed: () {
                kategoriProvider.saveKategori(cek);
                Navigator.of(context).pop();
              },
            ),
            (cek != "nol")
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Delete'),
                    onPressed: () {
                      kategoriProvider
                          .removeKategori(widget.kategori.kategoriId);
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
