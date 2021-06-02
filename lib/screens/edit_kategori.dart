import 'package:uas_safira/models/kategori.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/provider/kategori_provider.dart';

class EditKategori extends StatefulWidget {
  final Kategori kategori;

  EditKategori([this.kategori]);

  @override
  _EditKategoriState createState() => _EditKategoriState();
}

class _EditKategoriState extends State<EditKategori> {
  final kodeController = TextEditingController();
  final namaController = TextEditingController();
  final stokController = TextEditingController();
  final ukuranController = TextEditingController();
  final warnaController = TextEditingController();

  @override
  void dispose() {
    kodeController.dispose();
    namaController.dispose();
    stokController.dispose();
    ukuranController.dispose();
    warnaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.kategori == null) {
      //New Record
      kodeController.text = "";
      namaController.text = "";
      stokController.text = "";
      ukuranController.text = "";
      warnaController.text = "";
      new Future.delayed(Duration.zero, () {
        final kategoriProvider =
            Provider.of<KategoriProvider>(context, listen: false);
        kategoriProvider.loadValues(Kategori());
      });
    } else {
      //Controller Update
      kodeController.text = widget.kategori.kode;
      namaController.text = widget.kategori.nama;
      stokController.text = widget.kategori.stok.toString();
      ukuranController.text = widget.kategori.ukuran.toString();
      warnaController.text = widget.kategori.warna;
      //State Update
      new Future.delayed(Duration.zero, () {
        final kategoriProvider =
            Provider.of<KategoriProvider>(context, listen: false);
        kategoriProvider.loadValues(widget.kategori);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kategoriProvider = Provider.of<KategoriProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Siswa')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: kodeController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Kode'),
              onChanged: (value) {
                kategoriProvider.changeKode(value);
              },
            ),
            TextField(
              controller: namaController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Nama'),
              onChanged: (value) {
                kategoriProvider.changeNama(value);
              },
            ),
            TextField(
              controller: stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Stok'),
              onChanged: (value) => kategoriProvider.changeStok(value),
            ),
            TextField(
              controller: ukuranController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Ukuran'),
              onChanged: (value) => kategoriProvider.changeUkuran(value),
            ),
            TextField(
              controller: warnaController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Warna'),
              onChanged: (value) => kategoriProvider.changeWarna(value),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                kategoriProvider.saveKategori();
                Navigator.of(context).pop();
              },
            ),
            (widget.kategori != null)
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
