import 'package:app/widgets/AddMusicaDialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/controllers/playlist_controller.dart';

class PlaylistScreen extends StatefulWidget {
  final String playlistId;

  PlaylistScreen({required this.playlistId});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
    final playlistController =
        Provider.of<PlaylistController>(context, listen: false);
    playlistController.loadPlaylists(); // Carregar playlists
    playlistController.loadMusicas(); // Carregar músicas
  }

  @override
  Widget build(BuildContext context) {
    final playlistController = Provider.of<PlaylistController>(context);

    final playlist = playlistController.playlists
        .firstWhere((p) => p.id == widget.playlistId);

    final musicas = playlistController.getMusicasByIds(playlist.musicas);

    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.nome),
      ),
      body: Column(
        children: [
          Expanded(
            child: musicas.isEmpty
                ? Center(child: Text('Nenhuma música na playlist'))
                : ListView.builder(
                    itemCount: musicas.length,
                    itemBuilder: (context, index) {
                      final musica = musicas[index];
                      return ListTile(
                        title: Text(musica.nome),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () {
                            playlistController.removeMusicaFromPlaylist(
                                playlist.id, musica.id.toString());
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddMusicaDialog(
                      playlistId: playlist.id,
                    );
                  },
                );
              },
              child: Text(
                'Adicionar Música',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
