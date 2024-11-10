import 'package:app/controllers/playlist_controller.dart';
import 'package:app/models/musica.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMusicaDialog extends StatelessWidget {
  final String playlistId;

  AddMusicaDialog({required this.playlistId});

  @override
  Widget build(BuildContext context) {
    final playlistController = Provider.of<PlaylistController>(context);

    return FutureBuilder<List<Musica>>(
      future: playlistController.loadMusicas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar músicas!'));
        }

        final musicas = snapshot.data ?? [];

        return AlertDialog(
          title: Text('Escolha uma música'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: musicas.length,
              itemBuilder: (context, index) {
                final musica = musicas[index];
                return ListTile(
                  title: Text(musica.nome),
                  onTap: () {
                    playlistController.addMusicaToPlaylist(
                        playlistId, musica.id);
                    Navigator.pop(context); // Fecha o diálogo
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
