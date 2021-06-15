import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uas_safira/provider/item_provider.dart';
import 'package:uas_safira/provider/kategori_provider.dart';
import 'package:provider/provider.dart';
import 'package:uas_safira/routes.dart';
import 'package:uas_safira/items.dart';
import 'package:uas_safira/kategoris.dart';
import 'service/firestore_service.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ItemProvider()),
          StreamProvider(
            create: (context) => firestoreService.getItems(),
            initialData: null,
          ),
          ChangeNotifierProvider(create: (context) => KategoriProvider()),
          StreamProvider(
            create: (context) => firestoreService.getKategoris(),
            initialData: null,
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My ShoeBett',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoginPage(),
          routes: {
            routes.item: (context) => Items(),
            routes.kategori: (context) => Kategoris(),
          },
        ));
  }
}
