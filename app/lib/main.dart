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
          primaryColor: Color(0xFF1DB954),
          scaffoldBackgroundColor: Colors.black87,
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFF1DB954),
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.white70),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
