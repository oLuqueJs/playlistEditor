import 'package:flutter/material.dart';
import 'package:app/services/musica_service.dart';
import 'package:app/models/musica.dart';

class MusicaController with ChangeNotifier {
  final MusicaService _musicaService = MusicaService();
  List<Musica> _musicas = [];
  int _nextId = 1; // Contador de IDs locais

  List<Musica> get musicas => _musicas;

  // Função para carregar as músicas do backend
  Future<void> loadMusicas() async {
    try {
      _musicas =
          await _musicaService.getMusicas(); // Carrega músicas do json-server
      // Atualiza o próximo ID local a partir do maior ID da lista de músicas
      if (_musicas.isNotEmpty) {
        _nextId = _musicas
                .map((musica) => int.tryParse(musica.id) ?? 0)
                .reduce((a, b) => a > b ? a : b) +
            1;
      }
      notifyListeners();
    } catch (e) {
      print("Erro ao carregar músicas: $e");
    }
  }

  // Função para adicionar uma nova música
  Future<void> addMusica(Musica musica) async {
    try {
      musica = Musica(
        id: _nextId.toString(),
        nome: musica.nome,
        link: musica.link,
        icone: musica.icone,
      );
      await _musicaService.addMusica(musica);
      _nextId++;

      await loadMusicas();
    } catch (e) {
      print("Erro ao adicionar música: $e");
    }
  }

  // Função para deletar uma música
  Future<void> deleteMusica(String id) async {
    try {
      await _musicaService.deleteMusica(id);
      _musicas.removeWhere((musica) => musica.id == id);
      notifyListeners();
    } catch (e) {
      print("Erro ao deletar música: $e");
    }
  }
}
