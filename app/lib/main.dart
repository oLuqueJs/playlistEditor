import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/controllers/musica_controller.dart';
import 'package:app/controllers/playlist_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MusicaController()),
        ChangeNotifierProvider(create: (context) => PlaylistController()),
      ],
      child: MaterialApp(
        title: 'Music App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
