import 'package:flutter/material.dart';
// Importa o pacote principal do Flutter, usado para construir interfaces gráficas.

class TabButton extends StatelessWidget {
  // Define um widget estático para representar um botão de aba/tab.
  final String label; 
  // O rótulo do botão (texto que será exibido no botão).
  final bool isActive; 
  // Indica se o botão está ativo (selecionado) ou não.

  const TabButton({
    required this.label, 
    // O rótulo é obrigatório.
    required this.isActive, 
    // A propriedade que indica se está ativo também é obrigatória.
    super.key, 
    // Passa uma chave opcional ao widget (usado para identificação no Flutter).
  });

  @override
  Widget build(BuildContext context) {
    // Método build, que constrói a interface do botão.

    return TextButton(
      // Um botão de texto estilizado do Flutter.
      onPressed: () {}, 
      // Função a ser executada ao pressionar o botão. No momento, não faz nada.

      child: Text(
        // O texto exibido no botão.
        label, 
        // O texto é definido pelo valor passado para a propriedade `label`.
        style: TextStyle(
          // Estiliza o texto do botão.
          fontSize: 16, 
          // Define o tamanho da fonte.
          color: isActive ? Colors.white : Colors.white70, 
          // Define a cor do texto com base no estado `isActive`:
          // - Branco se o botão estiver ativo.
          // - Branco acinzentado (70% de opacidade) se o botão não estiver ativo.
        ),
      ),
    );
    // Retorna o botão estilizado com o texto.
  }
}
