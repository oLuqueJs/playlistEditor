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
      notifyListeners(); // Notifica que a lista foi atualizada
    } catch (e) {
      print("Erro ao carregar músicas: $e");
    }
  }

  // Função para adicionar uma nova música
  Future<void> addMusica(Musica musica) async {
    try {
      // Gerar o id local
      musica = Musica(
        id: _nextId.toString(), // Gerando um id incremental
        nome: musica.nome,
        link: musica.link,
        icone: musica.icone,
      );
      await _musicaService.addMusica(musica); // Adiciona música no json-server
      _nextId++; // Incrementa o contador de ID para a próxima música

      await loadMusicas(); // Recarrega a lista de músicas
    } catch (e) {
      print("Erro ao adicionar música: $e");
    }
  }

  // Função para deletar uma música
  Future<void> deleteMusica(String id) async {
    try {
      await _musicaService.deleteMusica(id); // Exclui a música no backend
      _musicas.removeWhere(
          (musica) => musica.id == id); // Remove a música da lista local
      notifyListeners(); // Atualiza a UI
    } catch (e) {
      print("Erro ao deletar música: $e");
    }
  }
}
