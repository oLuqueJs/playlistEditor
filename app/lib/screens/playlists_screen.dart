import 'package:app/models/playlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/controllers/playlist_controller.dart';
import 'package:app/widgets/playlist_card.dart';
import 'package:app/screens/playlist_screen.dart';

class PlaylistsScreen extends StatefulWidget {
  @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  @override
  void initState() {
    super.initState();
    // Carregar playlists assim que a tela for carregada
    final playlistController =
        Provider.of<PlaylistController>(context, listen: false);
    playlistController.loadPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    final playlistController = Provider.of<PlaylistController>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Playlists')),
      body: Column(
        children: [
          // Lista de playlists
          Expanded(
            child: playlistController.playlists.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: playlistController.playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = playlistController.playlists[index];
                      return PlaylistCard(
                        playlist: playlist,
                        onTap: () {
                          // Navegar para a tela da playlist
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PlaylistScreen(playlistId: playlist.id),
                            ),
                          );
                        },
                        onDelete: () {
                          // Excluir playlist do banco
                          playlistController.deletePlaylist(playlist.id);
                        },
                      );
                    },
                  ),
          ),
          // Botão para criar nova playlist
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final nome = await showDialog<String>(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: Text('Nome da Playlist'),
                      content: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: 'Digite o nome da playlist'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, controller.text);
                          },
                          child: Text('Criar'),
                        ),
                      ],
                    );
                  },
                );
                if (nome != null && nome.isNotEmpty) {
                  // Criar uma nova playlist com ID contador
                  final playlist = Playlist(
                    id: (playlistController.playlists.length + 1).toString(),
                    nome: nome,
                    musicas: [],
                  );
                  await playlistController.createPlaylist(playlist);
                }
              },
              child: Text('Criar Playlist'),
            ),
          ),
        ],
      ),
    );
  }
}
