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
      await _playlistService.createPlaylist(playlist);
      // Adiciona a playlist à lista local
      _playlists.add(playlist);
      // Recarregar playlists após a criação para garantir que a lista local está atualizada
      await loadPlaylists();
      notifyListeners(); // Notificar para reconstruir a UI
    } catch (e) {
      print("Erro ao criar playlist: $e");
    }
  }

  // Adicionar música à playlist
  Future<void> addMusicaToPlaylist(String playlistId, String musicaId) async {
    try {
      Playlist playlist = _playlists.firstWhere((p) => p.id == playlistId);

      if (!playlist.musicas.contains(musicaId)) {
        playlist.musicas.add(musicaId);
        await _playlistService.updatePlaylist(playlist);
        await loadPlaylists(); // Recarregar playlists
        notifyListeners();
      } else {
        print("A música já está na playlist.");
      }
    } catch (e) {
      print("Erro ao adicionar música à playlist: $e");
    }
  }

  // Remover música da playlist
  Future<void> removeMusicaFromPlaylist(
      String playlistId, String musicaId) async {
    try {
      Playlist playlist = _playlists.firstWhere((p) => p.id == playlistId);

      if (playlist.musicas.contains(musicaId)) {
        playlist.musicas.remove(musicaId);
        await _playlistService.updatePlaylist(playlist);
        await loadPlaylists(); // Recarregar playlists
        notifyListeners();
      } else {
        print("A música não existe na playlist.");
      }
    } catch (e) {
      print("Erro ao remover música da playlist: $e");
    }
  }

  // Deletar playlist
  Future<void> deletePlaylist(String playlistId) async {
    try {
      await _playlistService.deletePlaylist(playlistId);
      _playlists.removeWhere((playlist) => playlist.id == playlistId);
      notifyListeners();
    } catch (e) {
      print("Erro ao deletar playlist: $e");
    }
  }

  // Buscar músicas por ID
  List<Musica> getMusicasByIds(List<String> musicasIds) {
    return _musicas.where((musica) => musicasIds.contains(musica.id)).toList();
  }

  // Buscar músicas que não estão na playlist
  List<Musica> getMusicasDisponiveis(List<String> musicasIds) {
    return _musicas.where((musica) => !musicasIds.contains(musica.id)).toList();
  }
}
