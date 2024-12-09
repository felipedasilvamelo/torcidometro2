import 'package:flutter/material.dart';

class TorcidometroWidget extends StatefulWidget {
  final String team1Name;
  final String team2Name;

  const TorcidometroWidget({
    required this.team1Name,
    required this.team2Name,
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
    if (totalVotos == 0) return 0.0;
    return votos / totalVotos;
  }

  Widget _buildBar(int votos, int totalVotos, Color color) {
    final double altura = calcularAltura(votos, totalVotos) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Exibe o número de votos acima da barra
        Text(
          votos.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        // Barra de votação
        Container(
          width: 30,
          height: altura,
          color: color,
        ),
      ],
    );
  }

  Widget _buildFixedSection(String label, int votos, Color color) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Nome do time ou "Empate"
          Text(
            label,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Botão de votar
          ElevatedButton(
            onPressed: () => votar(label),
            child: const Text('Votar', style: TextStyle(fontSize: 13, color: Colors.black)),
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
          // Título Torcidômetro
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
          // Card com gráficos e elementos fixos
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
                  // Coluna do primeiro time
                  Column(
                    children: [
                      _buildBar(votosTeam1, totalVotos, Colors.blue),
                      const SizedBox(height: 10),
                      _buildFixedSection(widget.team1Name, votosTeam1, Colors.blue),
                    ],
                  ),
                  // Coluna de empate
                  Column(
                    children: [
                      _buildBar(votosEmpate, totalVotos, Colors.grey),
                      const SizedBox(height: 10),
                      _buildFixedSection('Empate', votosEmpate, Colors.grey),
                    ],
                  ),
                  // Coluna do segundo time
                  Column(
                    children: [
                      _buildBar(votosTeam2, totalVotos, Colors.red),
                      const SizedBox(height: 10),
                      _buildFixedSection(widget.team2Name, votosTeam2, Colors.red),
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


//numeros abaixo das barras de votação

// import 'package:flutter/material.dart';

// class TorcidometroWidget extends StatefulWidget {
//   final String team1Name;
//   final String team2Name;

//   const TorcidometroWidget({
//     required this.team1Name,
//     required this.team2Name,
//     super.key,
//   });

//   @override
//   _TorcidometroWidgetState createState() => _TorcidometroWidgetState();
// }

// class _TorcidometroWidgetState extends State<TorcidometroWidget> {
//   int votosTeam1 = 0;
//   int votosEmpate = 0;
//   int votosTeam2 = 0;

//   void votar(String time) {
//     setState(() {
//       if (time == widget.team1Name) {
//         votosTeam1++;
//       } else if (time == 'Empate') {
//         votosEmpate++;
//       } else if (time == widget.team2Name) {
//         votosTeam2++;
//       }
//     });
//   }

//   double calcularAltura(int votos, int totalVotos) {
//     if (totalVotos == 0) return 0.0;
//     return votos / totalVotos;
//   }

//   Widget _buildBar(int votos, int totalVotos, Color color) {
//     final double altura = calcularAltura(votos, totalVotos) * 100; // Altura da barra

//     return Container(
//       width: 30,
//       height: altura,
//       color: color,
//     );
//   }

//   Widget _buildFixedSection(String label, int votos, Color color) {
//     return SizedBox(
//       width: 80, // Tamanho fixo para evitar mudanças no layout
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Nome do time ou "Empate"
//           Text(
//             label,
//             style: const TextStyle(fontSize: 14),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 8),
//           // Número de votos
//           Text(
//             votos.toString(),
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           // Botão de votar
//           ElevatedButton(
//             onPressed: () => votar(label),
//             child: const Text('Votar', style: TextStyle(fontSize: 12)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int totalVotos = votosTeam1 + votosEmpate + votosTeam2;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Título Torcidômetro
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: Colors.blue, width: 1.5),
//             ),
//             child: const Text(
//               'Torcidômetro',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Card com gráficos e elementos fixos
//           Card(
//             elevation: 5,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 crossAxisAlignment: CrossAxisAlignment.end, // Alinha os gráficos na parte inferior
//                 children: [
//                   // Coluna do primeiro time
//                   Column(
//                     children: [
//                       _buildBar(votosTeam1, totalVotos, Colors.blue),
//                       const SizedBox(height: 10),
//                       _buildFixedSection(widget.team1Name, votosTeam1, Colors.blue),
//                     ],
//                   ),
//                   // Coluna de empate
//                   Column(
//                     children: [
//                       _buildBar(votosEmpate, totalVotos, Colors.grey),
//                       const SizedBox(height: 10),
//                       _buildFixedSection('Empate', votosEmpate, Colors.grey),
//                     ],
//                   ),
//                   // Coluna do segundo time
//                   Column(
//                     children: [
//                       _buildBar(votosTeam2, totalVotos, Colors.red),
//                       const SizedBox(height: 10),
//                       _buildFixedSection(widget.team2Name, votosTeam2, Colors.red),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
