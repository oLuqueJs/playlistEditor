import 'package:app/models/musica.dart';
import 'package:app/models/playlist.dart';
import 'package:app/services/playlist_service.dart';
import 'package:flutter/material.dart';

class PlaylistController with ChangeNotifier {
  final PlaylistService _playlistService = PlaylistService();
  List<Playlist> _playlists = [];
  List<Musica> _musicas = [];

  List<Playlist> get playlists => _playlists;
  List<Musica> get musicas => _musicas;

  // Carregar todas as playlists
  Future<void> loadPlaylists() async {
    try {
      _playlists = await _playlistService.getPlaylists();
      notifyListeners();
    } catch (e) {
      print("Erro ao carregar playlists: $e");
    }
  }

  // Carregar todas as músicas
  Future<List<Musica>> loadMusicas() async {
    try {
      if (_musicas.isEmpty) {
        _musicas = await _playlistService.getMusicas();
      }
      return _musicas;
    } catch (e) {
      throw Exception("Erro ao carregar músicas: $e");
    }
  }

  // Criar uma nova playlist
  Future<void> createPlaylist(Playlist playlist) async {
    try {
      // Cria a playlist no backend
      await _playlistService.createPlaylist(playlist);
      // Recarrega a lista de playlists após a criação
      await loadPlaylists();
    } catch (e) {
      print("Erro ao criar playlist: $e");
    }
  }

  // Adicionar música à playlist
  Future<void> addMusicaToPlaylist(String playlistId, String musicaId) async {
    try {
      // Primeiro, obtemos a playlist
      Playlist playlist = _playlists.firstWhere((p) => p.id == playlistId);

      // Adiciona o ID da música à lista de músicas da playlist
      playlist.musicas.add(musicaId);

      // Atualiza a playlist no backend
      await _playlistService.updatePlaylist(playlist);

      // Recarrega as playlists para refletir a mudança
      await loadPlaylists();
    } catch (e) {
      print("Erro ao adicionar música à playlist: $e");
    }
  }

  // Remover música da playlist
  Future<void> removeMusicaFromPlaylist(
      String playlistId, String musicaId) async {
    try {
      // Primeiramente, obtemos a playlist
      Playlist playlist = _playlists.firstWhere((p) => p.id == playlistId);

      // Remove o ID da música da lista de músicas da playlist
      playlist.musicas.remove(musicaId);

      // Atualiza a playlist no backend
      await _playlistService.updatePlaylist(playlist);

      // Recarrega as playlists para refletir a mudança
      await loadPlaylists();
    } catch (e) {
      print("Erro ao remover música da playlist: $e");
    }
  }

  // Deletar playlist
  Future<void> deletePlaylist(String playlistId) async {
    try {
      await _playlistService.deletePlaylist(playlistId);
      // Recarregar playlists após exclusão
      await loadPlaylists();
    } catch (e) {
      print("Erro ao deletar playlist: $e");
    }
  }

  // Buscar músicas por ID
  List<Musica> getMusicasByIds(List<String> musicasIds) {
    return _musicas.where((musica) => musicasIds.contains(musica.id)).toList();
  }
}
