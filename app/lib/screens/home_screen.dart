import 'package:flutter/material.dart';
import 'package:app/screens/musicas_screen.dart';
import 'package:app/screens/playlists_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MusicasScreen()),
                );
              },
              child: const Text('Músicas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaylistsScreen()),
                );
              },
              child: const Text('Playlists'),
            ),
          ],
        ),
      ),
    );
  }
}
