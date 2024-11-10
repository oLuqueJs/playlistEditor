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
    // Carregar as músicas assim que a tela for inicializada
    Provider.of<MusicaController>(context, listen: false).loadMusicas();
  }

  @override
  Widget build(BuildContext context) {
    final musicaController = Provider.of<MusicaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Músicas'),
      ),
      body: Column(
        children: [
          // Formulário para adicionar nova música
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome da Música',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: linkController,
              decoration: InputDecoration(
                labelText: 'Link da Música',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final nome = nomeController.text;
              final link = linkController.text;
              if (nome.isNotEmpty && link.isNotEmpty) {
                // Criando o objeto Musica e passando para o controller
                final musica = Musica(
                  id: '0', // O ID será gerado automaticamente pelo MusicaController
                  nome: nome,
                  link: link,
                  icone: Icons.music_note, // O ícone fixo
                );

                await musicaController
                    .addMusica(musica); // Passando o objeto Musica
                nomeController.clear();
                linkController.clear();
              }
            },
            child: Text('Adicionar Música'),
          ),

          // Lista de músicas
          Expanded(
            child: musicaController.musicas.isEmpty
                ? Center(
                    child:
                        CircularProgressIndicator()) // Indicador de carregamento
                : ListView.builder(
                    itemCount: musicaController.musicas.length,
                    itemBuilder: (context, index) {
                      final musica = musicaController.musicas[index];
                      return MusicaCard(
                        musica: musica,
                        onDelete: () {
                          // Deletar música passando o id como String
                          musicaController.deleteMusica(musica.id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
