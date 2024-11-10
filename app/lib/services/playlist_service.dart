import 'package:app/models/musica.dart';
import 'package:app/models/playlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PlaylistService {
  static const String apiUrl = 'http://localhost:3000/playlists';

  // Função para buscar todas as playlists
  Future<List<Playlist>> getPlaylists() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Playlist.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar playlists');
      }
    } catch (e) {
      throw Exception('Erro ao carregar playlists: $e');
    }
  }

  // Função para buscar todas as músicas
  Future<List<Musica>> getMusicas() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/musicas'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Musica.fromJson(json)).toList();
      } else {
        throw Exception('Erro ao carregar músicas');
      }
    } catch (e) {
      throw Exception('Erro ao carregar músicas: $e');
    }
  }

  // Função para criar uma nova playlist
  Future<void> createPlaylist(Playlist playlist) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(playlist.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Erro ao criar playlist');
      }
    } catch (e) {
      throw Exception('Erro ao criar playlist: $e');
    }
  }

  // Função para atualizar a playlist no banco
  Future<void> updatePlaylist(Playlist playlist) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/${playlist.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(playlist.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Erro ao atualizar playlist');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar playlist: $e');
    }
  }

  // Função para excluir uma playlist
  Future<void> deletePlaylist(String playlistId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/$playlistId'),
      );
      if (response.statusCode != 200) {
        throw Exception('Erro ao excluir playlist');
      }
    } catch (e) {
      throw Exception('Erro ao excluir playlist: $e');
    }
  }
}
