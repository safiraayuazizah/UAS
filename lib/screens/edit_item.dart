import 'package:uas_safira/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/provider/item_provider.dart';

class EditItem extends StatefulWidget {
  final Item item;

  EditItem([this.item]);

  @override
  _EditItemState createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  final kodeController = TextEditingController();
  final merkController = TextEditingController();

  @override
  void dispose() {
    kodeController.dispose();
    merkController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.item == null) {
      //New Record
      kodeController.text = "";
      merkController.text = "";
      new Future.delayed(Duration.zero, () {
        final itemProvider = Provider.of<ItemProvider>(context, listen: false);
        itemProvider.loadValues(Item());
      });
    } else {
      //Controller Update
      kodeController.text = widget.item.kode;
      merkController.text = widget.item.merk;
      //State Update
      new Future.delayed(Duration.zero, () {
        final itemProvider = Provider.of<ItemProvider>(context, listen: false);
        itemProvider.loadValues(widget.item);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: kodeController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Kode'),
              onChanged: (value) {
                itemProvider.changeKode(value);
              },
            ),
            TextField(
              controller: merkController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Merk'),
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
                itemProvider.saveItem();
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
