import 'package:flutter/material.dart';
import 'package:uas_safira/screens/edit_item.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/models/item.dart';

class Items extends StatelessWidget {
  static String routeName = '/item';

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context);
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
                  builder: (context) => EditItem(),
                ),
              );
            },
          )
        ],
      ),
      body: (items != null)
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].kode),
                  trailing: Text(
                    items[index].merk,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditItem(
                          items[index],
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
