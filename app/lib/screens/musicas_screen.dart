import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/controllers/musica_controller.dart';
import 'package:app/models/musica.dart';
import 'package:app/widgets/musica_card.dart';

class MusicasScreen extends StatefulWidget {
  @override
  _MusicasScreenState createState() => _MusicasScreenState();
}

class _MusicasScreenState extends State<MusicasScreen> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<MusicaController>(context, listen: false).loadMusicas();
  }

  @override
  Widget build(BuildContext context) {
    final musicaController = Provider.of<MusicaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Músicas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da Música',
                labelStyle: TextStyle(color: Colors.white70),
                fillColor: Colors.white12,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: linkController,
              decoration: InputDecoration(
                labelText: 'Link da Música',
                labelStyle: TextStyle(color: Colors.white70),
                fillColor: Colors.white12,
                filled: true,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final nome = nomeController.text;
                final link = linkController.text;
                if (nome.isNotEmpty && link.isNotEmpty) {
                  final musica = Musica(
                    id: '0',
                    nome: nome,
                    link: link,
                    icone: Icons.music_note,
                  );

                  await musicaController.addMusica(musica);
                  nomeController.clear();
                  linkController.clear();
                }
              },
              child: Text('Adicionar Música'),
            ),
            Expanded(
              child: musicaController.musicas.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: musicaController.musicas.length,
                      itemBuilder: (context, index) {
                        final musica = musicaController.musicas[index];
                        return MusicaCard(
                          musica: musica,
                          onDelete: () {
                            musicaController.deleteMusica(musica.id);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
