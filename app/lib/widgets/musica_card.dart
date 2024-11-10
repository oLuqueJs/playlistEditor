import 'package:flutter/material.dart';
import 'package:app/models/musica.dart';

class MusicaCard extends StatelessWidget {
  final Musica musica;
  final VoidCallback
      onDelete; // Função chamada ao pressionar o ícone de deletar

  MusicaCard({required this.musica, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(musica.icone), // Ícone fixo
        title: Text(musica.nome), // Nome da música
        subtitle: Text(musica.link), // Link da música
        trailing: IconButton(
          icon: Icon(Icons.delete), // Ícone de deletar
          onPressed: onDelete, // Ação de deletar
        ),
      ),
    );
  }
}
