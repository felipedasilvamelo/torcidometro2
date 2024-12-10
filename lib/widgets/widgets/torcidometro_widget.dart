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

  bool isManualMode = false; // Define se está no modo manual ou com botões

  TextEditingController team1Controller = TextEditingController();
  TextEditingController empateController = TextEditingController();
  TextEditingController team2Controller = TextEditingController();

  double calcularAltura(int votos, int totalVotos) {
    if (totalVotos == 0) return 0.1; // Retorna altura mínima
    return votos / totalVotos;
  }

  void votar(String time) {
    if (!isManualMode) {
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

  Widget _buildManualSection(String label, String logoUrl, TextEditingController controller) {
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
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Votos',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVotingSection(
      String label, String logoUrl, Color color, void Function() onVote) {
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
            onPressed: onVote,
            child: const Text(
              'Votar',
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: const Center(
        child: Text(
          'Torcidômetro',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void salvarVotos() {
    setState(() {
      votosTeam1 = int.tryParse(team1Controller.text) ?? votosTeam1;
      votosEmpate = int.tryParse(empateController.text) ?? votosEmpate;
      votosTeam2 = int.tryParse(team2Controller.text) ?? votosTeam2;
    });
  }

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os valores atuais
    team1Controller.text = votosTeam1.toString();
    empateController.text = votosEmpate.toString();
    team2Controller.text = votosTeam2.toString();
  }

  @override
  Widget build(BuildContext context) {
    final int totalVotos = votosTeam1 + votosEmpate + votosTeam2;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                _buildTitleBar(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Modo Manual:'),
                      Switch(
                        value: isManualMode,
                        onChanged: (value) {
                          setState(() {
                            isManualMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          _buildBar(votosTeam1, totalVotos, Colors.blue),
                          const SizedBox(height: 10),
                          isManualMode
                              ? _buildManualSection(widget.team1Name, widget.team1Logo, team1Controller)
                              : _buildVotingSection(widget.team1Name, widget.team1Logo, Colors.blue,
                                  () => votar(widget.team1Name)),
                        ],
                      ),
                      Column(
                        children: [
                          _buildBar(votosEmpate, totalVotos, Colors.grey),
                          const SizedBox(height: 10),
                          isManualMode
                              ? _buildManualSection('Empate', '', empateController)
                              : _buildVotingSection('Empate', '', Colors.grey, () => votar('Empate')),
                        ],
                      ),
                      Column(
                        children: [
                          _buildBar(votosTeam2, totalVotos, Colors.red),
                          const SizedBox(height: 10),
                          isManualMode
                              ? _buildManualSection(widget.team2Name, widget.team2Logo, team2Controller)
                              : _buildVotingSection(widget.team2Name, widget.team2Logo, Colors.red,
                                  () => votar(widget.team2Name)),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isManualMode)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: salvarVotos,
                      child: const Text('Salvar'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
