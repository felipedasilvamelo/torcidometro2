import 'package:flutter/material.dart';
import 'package:torcidometro/widgets/widgets/tab_button.dart';
import 'package:torcidometro/widgets/widgets/team_info.dart';
import 'package:torcidometro/widgets/widgets/torcidometro_widget.dart';
import 'package:torcidometro/screens/screens/edit_team_dialog.dart'; // Import do diálogo

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  String team1Name = 'PSG';
  String team1Logo =
      'https://a.espncdn.com/i/teamlogos/soccer/500-dark/160.png';

  String team2Name = 'Milan';
  String team2Logo =
      'https://a.espncdn.com/combiner/i?img=/i/teamlogos/soccer/500/103.png';

  void _editTeam(int teamIndex) {
    final String initialName = teamIndex == 1 ? team1Name : team2Name;
    final String initialLogo = teamIndex == 1 ? team1Logo : team2Logo;

    showDialog(
      context: context,
      builder: (context) => EditTeamDialog(
        initialName: initialName,
        initialLogo: initialLogo,
        onSave: (newName, newLogo) {
          setState(() {
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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Champions League',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'PSG x Milan',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabButton(label: 'JOGO', isActive: true),
                TabButton(label: 'COMENTÁRIOS', isActive: false),
                TabButton(label: 'MÍDIAS', isActive: false),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'GRUPO A x GRUPO B',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _editTeam(1),
                    child: TeamInfo(teamName: team1Name, imageUrl: team1Logo),
                  ),
                  const Text(
                    ':',
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () => _editTeam(2),
                    child: TeamInfo(teamName: team2Name, imageUrl: team2Logo),
                  ),
                ],
              ),
            ),
          ),
          TorcidometroWidget(
            team1Name: team1Name,
            team1Logo: team1Logo,
            team2Name: team2Name,
            team2Logo: team2Logo,
          ),
        ],
      ),
    );
  }
}
