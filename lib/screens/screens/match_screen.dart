import 'package:flutter/material.dart';
// Importa widgets personalizados utilizados na interface
import 'package:torcidometro/widgets/widgets/tab_button.dart';
import 'package:torcidometro/widgets/widgets/team_info.dart';
import 'package:torcidometro/widgets/widgets/torcidometro_widget.dart';
import 'package:torcidometro/screens/screens/edit_team_dialog.dart'; // Importa o diálogo de edição dos times

// Define a tela principal como um StatefulWidget para gerenciar mudanças de estado
class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  _MatchScreenState createState() => _MatchScreenState(); // Cria o estado associado à tela
}

class _MatchScreenState extends State<MatchScreen> {
  // Define os nomes e logos iniciais dos times
  String team1Name = 'PSG';
  String team1Logo =
      'https://a.espncdn.com/i/teamlogos/soccer/500-dark/160.png';

  String team2Name = 'Milan';
  String team2Logo =
      'https://a.espncdn.com/combiner/i?img=/i/teamlogos/soccer/500/103.png';

  // Função para editar as informações de um time
  void _editTeam(int teamIndex) {
    final String initialName = teamIndex == 1 ? team1Name : team2Name; // Determina o nome inicial baseado no índice
    final String initialLogo = teamIndex == 1 ? team1Logo : team2Logo; // Determina o logo inicial baseado no índice

    // Exibe o diálogo de edição
    showDialog(
      context: context,
      builder: (context) => EditTeamDialog(
        initialName: initialName, // Passa o nome inicial ao diálogo
        initialLogo: initialLogo, // Passa o logo inicial ao diálogo
        onSave: (newName, newLogo) {
          setState(() {
            // Atualiza o estado com os novos dados
            if (teamIndex == 1) {
              team1Name = newName;
              team1Logo = newLogo;
            } else {
              team2Name = newName;
              team2Logo = newLogo;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define a barra superior da aplicação
      appBar: AppBar(
        backgroundColor: Colors.blue, // Define a cor de fundo da AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícone de voltar
          onPressed: () {}, // Adicionar funcionalidade de navegação
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o texto à esquerda
          children: [
            Text(
              'Champions League', // Título principal da tela
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'PSG x Milan', // Subtítulo com os nomes dos times
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            color: Colors.white, // Ícone de compartilhar
            icon: const Icon(Icons.share),
            onPressed: () {}, // Adicionar funcionalidade de compartilhamento
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de navegação entre abas
          Container(
            color: Colors.blue, // Fundo azul para destacar a barra
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaçamento uniforme entre os botões
              children: [
                TabButton(label: 'JOGO', isActive: true), // Aba ativa para "JOGO"
                TabButton(label: 'COMENTÁRIOS', isActive: false), // Aba inativa para "COMENTÁRIOS"
                TabButton(label: 'MÍDIAS', isActive: false), // Aba inativa para "MÍDIAS"
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10), // Espaçamento vertical
            child: Text(
              'GRUPO A x GRUPO B', // Texto indicando os grupos dos times
              style: TextStyle(fontSize: 16),
            ),
          ),
          // Container exibindo informações dos times
          Padding(
            padding: const EdgeInsets.all(8.0), // Espaçamento ao redor do container
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Fundo branco
                borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300, // Cor da sombra
                    blurRadius: 5, // Intensidade do desfoque
                    offset: const Offset(0, 3), // Direção da sombra
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Espaçamento interno
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, // Espaçamento uniforme entre os elementos
                children: [
                  GestureDetector(
                    onTap: () => _editTeam(1), // Editar informações do time 1 ao clicar
                    child: TeamInfo(teamName: team1Name, imageUrl: team1Logo), // Exibe informações do time 1
                  ),
                  const Text(
                    ':', // Separador entre os dois times
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => _editTeam(2), // Editar informações do time 2 ao clicar
                    child: TeamInfo(teamName: team2Name, imageUrl: team2Logo), // Exibe informações do time 2
                  ),
                ],
              ),
            ),
          ),
          // Componente do Torcidômetro
          TorcidometroWidget(
            team1Name: team1Name, // Passa o nome do time 1 para o widget
            team1Logo: team1Logo, // Passa o logo do time 1 para o widget
            team2Name: team2Name, // Passa o nome do time 2 para o widget
            team2Logo: team2Logo, // Passa o logo do time 2 para o widget
          ),
        ],
      ),
    );
  }
}
