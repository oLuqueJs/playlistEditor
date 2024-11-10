import 'package:app/models/musica.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MusicaService {
  static const String apiUrl =
      'http://localhost:3000/musicas'; // URL do json-server

  // Função para buscar todas as músicas
  Future<List<Musica>> getMusicas() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
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

  // Função para adicionar uma música
  Future<void> addMusica(Musica musica) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(musica.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Erro ao adicionar música');
      }
    } catch (e) {
      throw Exception('Erro ao adicionar música: $e');
    }
  }

  // Função para deletar uma música
  Future<void> deleteMusica(String id) async {
    try {
      final response = await http
          .delete(Uri.parse('$apiUrl/$id')); // Passando o id como String

      if (response.statusCode != 200) {
        throw Exception('Erro ao deletar música');
      }
    } catch (e) {
      throw Exception('Erro ao deletar música: $e');
    }
  }
}
