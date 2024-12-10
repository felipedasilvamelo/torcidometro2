import 'package:flutter/material.dart';

class TorcidometroWidget extends StatefulWidget {
  final String team1Name;
  final String team1Logo; // URL do logo do time 1
  final String team2Name;
  final String team2Logo; // URL do logo do time 2

  const TorcidometroWidget({
    required this.team1Name,
    required this.team1Logo,
    required this.team2Name,
    required this.team2Logo,
    super.key,
  });

  @override
  _TorcidometroWidgetState createState() => _TorcidometroWidgetState();
}

class _TorcidometroWidgetState extends State<TorcidometroWidget> {
  int votosTeam1 = 0;
  int votosEmpate = 0;
  int votosTeam2 = 0;

  void votar(String time) {
    setState(() {
      if (time == widget.team1Name) {
        votosTeam1++;
      } else if (time == 'Empate') {
        votosEmpate++;
      } else if (time == widget.team2Name) {
        votosTeam2++;
      }
    });
  }

  double calcularAltura(int votos, int totalVotos) {
    if (totalVotos == 0) return 0.1; // Retorna altura mínima
    return votos / totalVotos;
  }

  Widget _buildBar(int votos, int totalVotos, Color color) {
    final double altura = calcularAltura(votos, totalVotos) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          votos.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 30,
          height: altura > 0 ? altura : 1, // Garante altura mínima de 1 pixel
          color: color,
        ),
      ],
    );
  }

  Widget _buildFixedSection(String label, String logoUrl, int votos, Color color) {
    return SizedBox(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoUrl.isNotEmpty
                  ? Image.network(
                      logoUrl,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(), // Não mostra nada se não houver logo
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => votar(label),
            child: const Text(
              'Votar',
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalVotos = votosTeam1 + votosEmpate + votosTeam2;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue, width: 1.5),
            ),
            child: const Text(
              'Torcidômetro',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      _buildBar(votosTeam1, totalVotos, Colors.blue),
                      const SizedBox(height: 10),
                      _buildFixedSection(widget.team1Name, widget.team1Logo, votosTeam1, Colors.blue),
                    ],
                  ),
                  Column(
                    children: [
                      _buildBar(votosEmpate, totalVotos, Colors.grey),
                      const SizedBox(height: 10),
                      _buildFixedSection('Empate', '', votosEmpate, Colors.grey),
                    ],
                  ),
                  Column(
                    children: [
                      _buildBar(votosTeam2, totalVotos, Colors.red),
                      const SizedBox(height: 10),
                      _buildFixedSection(widget.team2Name, widget.team2Logo, votosTeam2, Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
