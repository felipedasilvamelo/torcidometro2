import 'package:flutter/material.dart'; 
// Importa o pacote principal do Flutter, necessário para construir interfaces gráficas.

// Define uma classe de widget estático (sem estado) chamada EditTeamDialog.
class EditTeamDialog extends StatelessWidget {
  final String initialName; 
  // Campo para armazenar o nome inicial do time, recebido como parâmetro.
  final String initialLogo; 
  // Campo para armazenar o URL inicial da logo do time, recebido como parâmetro.
  final Function(String, String) onSave; 
  // Função de callback para salvar as alterações feitas no nome e logo do time.

  const EditTeamDialog({
    required this.initialName, 
    // Nome inicial é obrigatório.
    required this.initialLogo, 
    // URL inicial da logo é obrigatório.
    required this.onSave, 
    // A função de callback é obrigatória.
    super.key, 
    // Passa uma chave opcional ao widget (usado para identificação no Flutter).
  });

  @override
  Widget build(BuildContext context) {
    // Método build, responsável por construir a interface do widget.

    final TextEditingController nameController =
        TextEditingController(text: initialName);
    // Controlador para o campo de texto do nome do time, inicializado com o nome atual.

    final TextEditingController logoController =
        TextEditingController(text: initialLogo);
    // Controlador para o campo de texto do URL da logo, inicializado com a URL atual.

    return AlertDialog(
      // Define o layout do diálogo como um AlertDialog.
      title: const Text('Editar Time'), 
      // Título do diálogo.
      content: Column(
        // Conteúdo principal do diálogo organizado em uma coluna.
        mainAxisSize: MainAxisSize.min,
        // Faz a coluna ocupar apenas o espaço necessário.
        children: [
          TextField(
            controller: nameController, 
            // Controlador do campo de texto vinculado ao nome do time.
            decoration: const InputDecoration(labelText: 'Nome do Time'),
            // Decoração do campo com um rótulo explicativo.
          ),
          const SizedBox(height: 10), 
          // Espaçamento entre os dois campos de texto.
          TextField(
            controller: logoController, 
            // Controlador do campo de texto vinculado ao URL da logo.
            decoration: const InputDecoration(labelText: 'URL da Logo'),
            // Decoração do campo com um rótulo explicativo.
          ),
        ],
      ),
      actions: [
        // Define os botões de ação do diálogo.
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            // Fecha o diálogo sem realizar nenhuma ação adicional.
          },
          child: const Text('Cancelar'), 
          // Texto do botão para cancelar.
        ),
        ElevatedButton(
          onPressed: () {
            onSave(nameController.text, logoController.text);
            // Chama a função de callback `onSave` com os valores editados.
            Navigator.of(context).pop();
            // Fecha o diálogo após salvar as alterações.
          },
          child: const Text('Salvar'), 
          // Texto do botão para salvar as alterações.
        ),
      ],
    );
    // Retorna o AlertDialog configurado.
  }
}
