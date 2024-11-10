import 'package:flutter/material.dart';
import 'package:app/models/musica.dart';

class MusicaCard extends StatelessWidget {
  final Musica musica;
  final VoidCallback onDelete;

  MusicaCard({required this.musica, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(musica.icone),
        title: Text(musica.nome),
        subtitle: Text(musica.link),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
