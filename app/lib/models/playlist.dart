class Playlist {
  final String id;
  final String nome;
  List<String> musicas;

  Playlist({
    required this.id,
    required this.nome,
    required this.musicas,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      nome: json['nome'],
      musicas: List<String>.from(json['musicas']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'musicas': musicas,
    };
  }
}
