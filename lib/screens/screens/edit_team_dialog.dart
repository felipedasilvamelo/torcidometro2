import 'package:flutter/material.dart';

// Define uma classe de widget estático (sem estado) chamada EditTeamDialog.
class EditTeamDialog extends StatelessWidget {
  final String initialName;

  final String initialLogo;

  final Function(String, String) onSave;

  const EditTeamDialog({
    required this.initialName,
    required this.initialLogo,
    required this.onSave,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Método build, responsável por construir a interface do widget.

    final TextEditingController nameController =
        TextEditingController(text: initialName);

    final TextEditingController logoController =
        TextEditingController(text: initialLogo);

    return AlertDialog(
      // Define o layout do diálogo como um AlertDialog.
      title: const Text('Editar Time'),

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nome do Time'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: logoController,
            decoration: const InputDecoration(labelText: 'URL da Logo'),
          ),
        ],
      ),
      actions: [
        // Define os botões de ação do diálogo.
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            onSave(nameController.text, logoController.text);

            Navigator.of(context).pop();
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
