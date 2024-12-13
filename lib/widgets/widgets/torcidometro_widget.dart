import 'package:flutter/material.dart';

class TorcidometroWidget extends StatefulWidget {
  final String team1Name;
  final String team1Logo;
  final String team2Name;
  final String team2Logo;
  final bool isManualMode;

  const TorcidometroWidget({// Define se o modo manual está ativado (true) ou não (false)
    required this.team1Name,
    required this.team1Logo,
    required this.team2Name,
    required this.team2Logo,
    this.isManualMode = true,
    super.key,
  });

  @override
  _TorcidometroWidgetState createState() => _TorcidometroWidgetState();
}

class _TorcidometroWidgetState extends State<TorcidometroWidget> {
  int votosTeam1 = 0;
  int votosEmpate = 0;
  int votosTeam2 = 0;

  // Controladores de texto para os campos de placar do modo manual
  TextEditingController team1Controller = TextEditingController();
  TextEditingController team2Controller = TextEditingController();

  // Calcula a altura proporcional das barras do gráfico com base nos votos
  double calcularAltura(int votos, int totalVotos) {
    if (totalVotos == 0) return 0.1; // Evita altura zero quando não há votos
    return votos / totalVotos;
  }

  // Salva os votos inseridos manualmente no placar
  void salvarVotos() {
    setState(() {
      // Obtém os valores dos placares inseridos pelo usuário
      int team1Score = int.tryParse(team1Controller.text) ?? 0;
      int team2Score = int.tryParse(team2Controller.text) ?? 0;

      // Atualiza os contadores de votos com base nos placares
      if (team1Score > team2Score) {
        votosTeam1 += 1;
      } else if (team2Score > team1Score) {
        votosTeam2 += 1;
      } else if (team1Score == team2Score) {
        votosEmpate += 1;
      }
    });
  }

  // Incrementa votos para o time 1
  void votarTeam1() {
    setState(() {
      votosTeam1++;
    });
  }

  // Incrementa votos para empates
  void votarEmpate() {
    setState(() {
      votosEmpate++;
    });
  }

  // Incrementa votos para o time 2
  void votarTeam2() {
    setState(() {
      votosTeam2++;
    });
  }

  // Cria uma barra no gráfico com altura proporcional aos votos
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
          height:
              altura > 0 ? altura : 1, // Evita altura zero para visibilidade
          color: color,
        ),
      ],
    );
  }

  // Cria a seção manual para inserir placares
  Widget _buildManualSection(
      String label, String logoUrl, TextEditingController controller) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exibe o logo do time, se disponível
              logoUrl.isNotEmpty
                  ? Image.network(
                      logoUrl,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controller, // Controlador vinculado ao campo
              keyboardType: TextInputType.number, // Aceita apenas números
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Placar',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cria a barra de título do widget
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int totalVotos =
        votosTeam1 + votosEmpate + votosTeam2; // Total de votos

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
                _buildTitleBar(), // Barra de título
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          _buildBar(votosTeam1, totalVotos,
                              Colors.blue), // Barra do time 1
                          const SizedBox(height: 10),
                          if (widget.isManualMode)
                            _buildManualSection(widget.team1Name,
                                widget.team1Logo, team1Controller)
                          else
                            ElevatedButton(
                              onPressed: votarTeam1,
                              child: const Text('Votar'),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          _buildBar(votosEmpate, totalVotos,
                              Colors.grey), // Barra de empates
                          const SizedBox(height: 10),
                          if (widget.isManualMode)
                            const Column(
                              children: [
                                const SizedBox(
                                  width: 80,
                                  child: Center(
                                    child: Text(
                                      'Empate',
                                      style: TextStyle(fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: 80,
                                  height:
                                      40, // Define a altura igual às outras caixas
                                  child: TextField(
                                    enabled: false, // Campo desabilitado
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'X', // Indica empate
                                      labelStyle: TextStyle(
                                        fontSize: 16,
                                      ),
                                      contentPadding: EdgeInsets.all(35),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            ElevatedButton(
                              onPressed: votarEmpate,
                              child: const Text('Votar'),
                            ),
                        ],
                      ),
                      Column(
                        children: [
                          _buildBar(votosTeam2, totalVotos, Colors.red),
                          const SizedBox(height: 10),
                          if (widget.isManualMode)
                            _buildManualSection(widget.team2Name,
                                widget.team2Logo, team2Controller)
                          else
                            ElevatedButton(
                              onPressed: votarTeam2,
                              child: const Text('Votar'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (widget.isManualMode)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed:
                          salvarVotos, // Salva os placares inseridos manualmente
                      child: const Text('Salvar Placar'),
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
