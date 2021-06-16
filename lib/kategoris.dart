import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_safira/provider/kategori_provider.dart';
import 'package:uas_safira/screens/edit_kategori.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/models/kategori.dart';
import 'package:uas_safira/sign_in.dart';

class Kategoris extends StatefulWidget {
  static String routeName = '/kategori';
  final Kategori kategori;

  Kategoris([this.kategori]);
  @override
  _KategorisState createState() => _KategorisState();
}

class _KategorisState extends State<Kategoris> {
  Widget build(BuildContext context) {
    final kategoris = Provider.of<List<Kategori>>(context);
    final kategoriProvider = Provider.of<KategoriProvider>(context);
    return Scaffold(
        body: Container(
            child: Scaffold(
                appBar: AppBar(
                  title: Text('Kategori'),
                  backgroundColor: Colors.grey.shade400,
                  centerTitle: true,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditKategori(
                                null, null, null, null, null, null),
                          ),
                        );
                      },
                    )
                  ],
                ),
                body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('kategoris')
                      .where('userId', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Text('Tunggu')
                        : ListView.builder(
                            itemCount: kategoris.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data.docs[index];
                              return ListTile(
                                title: Text(data['kode']),
                                subtitle: Text("Nama: " +
                                    data['nama'] +
                                    "  Stock: " +
                                    data['stok'].toString() +
                                    "  Ukuran: " +
                                    data['ukuran'].toString() +
                                    "  Warna: " +
                                    data['warna']),
                                trailing: GestureDetector(
                                  child: Icon(Icons.delete),
                                  onTap: () {
                                    kategoriProvider.removeKategori(data.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditKategori(
                                        data.id.toString(),
                                        data['kode'].toString(),
                                        data['nama'].toString(),
                                        data['stok'],
                                        data['ukuran'],
                                        data['warna'].toString(),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                  },
                ))));
  }
}
