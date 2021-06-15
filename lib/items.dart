import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas_safira/provider/item_provider.dart';
import 'package:uas_safira/screens/edit_item.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/models/item.dart';
import 'package:uas_safira/sign_in.dart';

class Items extends StatefulWidget {
  static String routeName = '/item';
  final Item item;

  Items([this.item]);
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
        body: Container(
            child: Scaffold(
                appBar: AppBar(
                  title: const Text('Item'),
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
                            builder: (context) => EditItem(null, null, null),
                          ),
                        );
                      },
                    )
                  ],
                ),
                body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('items')
                      .where('userId', isEqualTo: uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Text('Tunggu')
                        : ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data.docs[index];
                              return ListTile(
                                title: Text(data['kode']),
                                trailing: GestureDetector(
                                  child: Icon(Icons.delete),
                                  onTap: () {
                                    itemProvider.removeItem(data.id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditItem(
                                        data.id.toString(),
                                        data['kode'].toString(),
                                        data['merk'].toString(),
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
