import 'package:flutter/material.dart';

class Musica {
  final String
      id; // Alteramos para String, já que o id pode ser tanto número quanto string
  final String nome;
  final String link;
  final IconData icone;

  Musica({
    required this.id,
    required this.nome,
    required this.link,
    required this.icone,
  });

  // Modificando o fromJson para lidar com id como String
  factory Musica.fromJson(Map<String, dynamic> json) {
    return Musica(
      id: json['id']
          .toString(), // Garantimos que id seja convertido para String
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
