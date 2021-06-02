import 'package:flutter/material.dart';
import 'package:uas_safira/screens/edit_kategori.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/models/kategori.dart';

class Kategoris extends StatelessWidget {
  static String routeName = '/kategori';

  @override
  Widget build(BuildContext context) {
    final kategoris = Provider.of<List<Kategori>>(context);
    return Scaffold(
        body: Container(
            child: Scaffold(
      appBar: AppBar(
        title: const Text('Kategori'),
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
                  builder: (context) => EditKategori(),
                ),
              );
            },
          )
        ],
      ),
      body: (kategoris != null)
          ? ListView.builder(
              itemCount: kategoris.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(kategoris[index].kode),
                  trailing: Text(
                    kategoris[index].nama,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditKategori(
                          kategoris[index],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    )));
  }
}
