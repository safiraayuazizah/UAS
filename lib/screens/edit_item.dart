import 'package:uas_safira/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/provider/item_provider.dart';

class EditItem extends StatefulWidget {
  Item item;
  final String idItem;
  final String kode;
  final String merk;

  EditItem(this.idItem, this.kode, this.merk);
  @override
  _EditItemState createState() =>
      _EditItemState(this.idItem, this.kode, this.merk);
}

class _EditItemState extends State<EditItem> {
  TextEditingController idItemController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController merkController = TextEditingController();
  String cek;
  @override
  void dispose() {
    kodeController.dispose();
    merkController.dispose();
    super.dispose();
  }

  _EditItemState(String idItem, String kode, String merk) {
    if (kode != null) {
      idItemController.text = idItem;
      kodeController.text = kode;
      merkController.text = merk;
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
      merkController.text = "";
    } else {
      new Future.delayed(Duration.zero, () {
        final itemProvider = Provider.of<ItemProvider>(context, listen: false);
        itemProvider.loadValues(
            idItemController.text, kodeController.text, merkController.text);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: kodeController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: 'Kode',
                labelText: 'Masukkan Kode',
                icon: Icon(Icons.create),
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
              ),
              onChanged: (value) {
                itemProvider.changeKode(value);
              },
            ),
            TextField(
              controller: merkController,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                hintText: 'Merk',
                labelText: 'Masukkan Merk',
                icon: Icon(Icons.create),
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0)),
              ),
              onChanged: (value) {
                itemProvider.changeMerk(value);
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                itemProvider.saveItem(cek);
                Navigator.of(context).pop();
              },
            ),
            (widget.item != null)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Delete'),
                    onPressed: () {
                      itemProvider.removeItem(widget.item.itemId);
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
