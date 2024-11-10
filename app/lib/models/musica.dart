import 'package:flutter/material.dart';

class Musica {
  final String id;
  final String nome;
  final String link;
  final IconData icone;

  Musica({
    required this.id,
    required this.nome,
    required this.link,
    required this.icone,
  });

  factory Musica.fromJson(Map<String, dynamic> json) {
    return Musica(
      id: json['id'].toString(),
      nome: json['nome'],
      link: json['link'],
      icone: Icons.music_note, // Usando ícone fixo
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Mantemos o id como String
      'nome': nome,
      'link': link,
    };
  }
}
