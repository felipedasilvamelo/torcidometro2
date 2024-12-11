import 'package:flutter/material.dart'; 
// Importa o pacote Flutter Material Design para criar interfaces visuais.

class TorcidometroWidget extends StatefulWidget {
  // Declaração de um widget que permite mudanças de estado.

  final String team1Name; // Nome do time 1.
  final String team1Logo; // URL ou caminho da logo do time 1.
  final String team2Name; // Nome do time 2.
  final String team2Logo; // URL ou caminho da logo do time 2.

  const TorcidometroWidget({
    required this.team1Name,
    required this.team1Logo,
    required this.team2Name,
    required this.team2Logo,
    super.key,
  });
  // Construtor que define os valores obrigatórios para criar a instância do widget.

  @override
  _TorcidometroWidgetState createState() => _TorcidometroWidgetState();
  // Define o estado do widget.
}

class _TorcidometroWidgetState extends State<TorcidometroWidget> {
  // Classe que gerencia o estado do widget.

  int votosTeam1 = 0; // Armazena os votos do time 1.
  int votosEmpate = 0; // Armazena os votos para empate.
  int votosTeam2 = 0; // Armazena os votos do time 2.

  bool isManualMode = false; 
  // Controla se o modo manual de edição de votos está ativado.

  TextEditingController team1Controller = TextEditingController();
  TextEditingController empateController = TextEditingController();
  TextEditingController team2Controller = TextEditingController();
  // Controladores para os campos de texto no modo manual.

  double calcularAltura(int votos, int totalVotos) {
    // Calcula a altura relativa da barra com base nos votos.
    if (totalVotos == 0) return 0.1; // Retorna altura mínima se não houver votos.
    return votos / totalVotos; // Retorna a proporção de votos em relação ao total.
  }

  void votar(String time) {
    // Adiciona um voto ao time ou empate.
    if (!isManualMode) {
      // Só funciona no modo automático.
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
    // Cria o widget visual da barra que representa os votos.
    final double altura = calcularAltura(votos, totalVotos) * 100;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end, // Alinha ao final.
      children: [
        Text(
          votos.toString(), // Exibe a quantidade de votos acima da barra.
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4), // Espaçamento entre texto e barra.
        Container(
          width: 30, // Define a largura da barra.
          height: altura > 0 ? altura : 1, 
          // Define a altura da barra com um mínimo de 1 pixel.
          color: color, // Define a cor da barra.
        ),
      ],
    );
  }

  Widget _buildManualSection(String label, String logoUrl, TextEditingController controller) {
    // Cria o widget para edição manual dos votos.
    return SizedBox(
      width: 100, // Define a largura do espaço.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza os itens.
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza horizontalmente.
            children: [
              logoUrl.isNotEmpty
                  ? Image.network(
                      logoUrl, // Carrega a logo via URL.
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover, // Ajusta o tamanho da imagem.
                    )
                  : const SizedBox.shrink(), 
              // Exibe um espaço vazio caso não haja logo.
              const SizedBox(width: 8), // Espaçamento entre logo e texto.
              Text(
                label, // Exibe o nome do time.
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8), // Espaçamento antes do campo de texto.
          TextField(
            controller: controller, // Controlador do campo.
            keyboardType: TextInputType.number, // Permite apenas números.
            textAlign: TextAlign.center, // Centraliza o texto.
            decoration: const InputDecoration(
              border: OutlineInputBorder(), // Adiciona borda ao campo.
              labelText: 'Votos', // Texto de dica.
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVotingSection(String label, String logoUrl, Color color, void Function() onVote) {
    // Cria o widget para votação automática.
    return SizedBox(
      width: 100, // Define a largura do espaço.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centraliza os itens.
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logoUrl.isNotEmpty
                  ? Image.network(
                      logoUrl, // Carrega a logo via URL.
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(width: 8),
              Text(
                label, // Exibe o nome do time.
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onVote, // Função executada ao pressionar o botão.
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
    // Cria a barra superior com o título.
    return Container(
      width: double.infinity, // Ocupa toda a largura disponível.
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Espaçamento interno.
      decoration: const BoxDecoration(
        color: Colors.blue, // Cor de fundo.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ), // Bordas arredondadas nos cantos superiores.
      ),
      child: const Center(
        child: Text(
          'Torcidômetro', // Título da barra.
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
    // Salva os votos inseridos manualmente.
    setState(() {
      votosTeam1 = int.tryParse(team1Controller.text) ?? votosTeam1;
      votosEmpate = int.tryParse(empateController.text) ?? votosEmpate;
      votosTeam2 = int.tryParse(team2Controller.text) ?? votosTeam2;
    });
  }

  @override
  void initState() {
    super.initState();
    // Inicializa os controladores com os valores atuais.
    team1Controller.text = votosTeam1.toString();
    empateController.text = votosEmpate.toString();
    team2Controller.text = votosTeam2.toString();
  }

  @override
  Widget build(BuildContext context) {
    // Constrói o layout principal.
    final int totalVotos = votosTeam1 + votosEmpate + votosTeam2;

    return Padding(
      padding: const EdgeInsets.all(16.0), // Margem externa.
      child: Column(
        children: [
          Card(
            elevation: 5, // Sombra do cartão.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ), // Borda arredondada.
            child: Column(
              children: [
                _buildTitleBar(), // Adiciona a barra superior.
                Padding(
                  padding: const EdgeInsets.all(16.0), // Espaçamento interno.
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Modo Manual:'), // Texto descritivo.
                      Switch(
                        value: isManualMode, // Estado do switch.
                        onChanged: (value) {
                          setState(() {
                            isManualMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16), // Espaçamento vertical.
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
                      onPressed: salvarVotos, // Salva os votos no modo manual.
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
