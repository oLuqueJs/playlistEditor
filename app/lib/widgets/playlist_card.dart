import 'package:flutter/material.dart';
import 'package:app/models/playlist.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback onTap;
  final VoidCallback onDelete; // Callback para deletar playlist

  PlaylistCard({
    required this.playlist,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.playlist_play),
        title: Text(playlist.nome),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete, // Chama a função de deletar
        ),
      ),
    );
  }
}
