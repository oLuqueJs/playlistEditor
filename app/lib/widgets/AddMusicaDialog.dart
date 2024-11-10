import 'package:flutter/material.dart';
import 'package:app/models/musica.dart';
import 'package:app/controllers/playlist_controller.dart';
import 'package:provider/provider.dart';

class AddMusicaDialog extends StatelessWidget {
  final String playlistId;

  AddMusicaDialog({required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final playlistController = Provider.of<PlaylistController>(context);

    // Carregar as músicas antes de exibir o diálogo
    return AlertDialog(
      title: Text('Escolha uma música para adicionar à playlist'),
      content: FutureBuilder<List<Musica>>(
        future: playlistController.loadMusicas(), // Carregar todas as músicas
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar músicas'));
          }

          final musicas = snapshot.data ?? [];

          if (musicas.isEmpty) {
            return Center(child: Text('Não há músicas disponíveis.'));
          }

          return ListView.builder(
            itemCount: musicas.length,
            itemBuilder: (context, index) {
              final musica = musicas[index];
              return ListTile(
                title: Text(musica.nome),
                onTap: () {
                  // Adiciona a música à playlist
                  playlistController.addMusicaToPlaylist(playlistId, musica.id);
                  Navigator.pop(context); // Fecha o diálogo após adicionar
                },
              );
            },
          );
        },
      ),
    );
  }
}
