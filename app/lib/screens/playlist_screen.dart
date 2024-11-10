import 'package:app/widgets/AddMusicaDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/controllers/playlist_controller.dart';

class PlaylistScreen extends StatelessWidget {
  final String playlistId;

  PlaylistScreen({required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final playlistController = Provider.of<PlaylistController>(context);

    // Carregar a playlist ao inicializar
    final playlist =
        playlistController.playlists.firstWhere((p) => p.id == playlistId);

    // Obtenção das músicas da playlist usando o método getMusicasByIds
    final musicas = playlistController.getMusicasByIds(playlist.musicas);

    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.nome),
      ),
      body: Column(
        children: [
          // Exibir músicas da playlist
          Expanded(
            child: ListView.builder(
              itemCount: musicas.length,
              itemBuilder: (context, index) {
                final musica = musicas[index];
                return ListTile(
                  title: Text(musica.nome),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      playlistController.removeMusicaFromPlaylist(
                          playlist.id, musica.id.toString());
                    },
                  ),
                );
              },
            ),
          ),
          // Botão para adicionar música
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Exibir todas as músicas para adicionar à playlist
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddMusicaDialog(
                      playlistId: playlist.id,
                    );
                  },
                );
              },
              child: Text(
                'Adicionar Música',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
