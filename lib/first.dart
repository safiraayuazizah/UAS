import 'package:flutter/material.dart';
import 'package:uas_safira/routes.dart';
import 'package:uas_safira/items.dart';
import 'package:uas_safira/kategoris.dart';
import 'package:uas_safira/login_page.dart';

void main() => runApp(First());

class First extends StatelessWidget {
  static String _title = 'Drawer Example';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/my.png'),
          //fit: BoxFit.contain,
        )),
        child: const Text('Selamat Datang !',
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            )),
      ),
      appBar: AppBar(
        title: Text('Admin My ShoeBett'),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey),
              child: Text(
                'Admin My ShoeBett',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Item'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Items())),
            ),
            ListTile(
              leading: Icon(Icons.create),
              title: Text('Kategori'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Kategoris())),
            ),
            ListTile(
              leading: Icon(Icons.meeting_room),
              title: Text('Logout'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage())),
              // }),
            ),
          ],
        ),
      ),
    );
  }
}
