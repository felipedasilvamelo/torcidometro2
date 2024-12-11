import 'package:flutter/material.dart';
// Importa o pacote principal do Flutter, usado para criar interfaces gráficas.
import 'package:cached_network_image/cached_network_image.dart';
// Importa o pacote 'cached_network_image', usado para carregar imagens da internet com cache.

class TeamInfo extends StatelessWidget {
  // Define um widget estático que exibe informações de um time.
  final String teamName; 
  // Nome do time, recebido como parâmetro.
  final String imageUrl; 
  // URL da imagem do time, recebido como parâmetro.

  const TeamInfo({
    required this.teamName, 
    // O nome do time é obrigatório.
    required this.imageUrl, 
    // O URL da imagem também é obrigatório.
    super.key, 
    // Passa uma chave opcional ao widget (usado para identificação no Flutter).
  });

  @override
  Widget build(BuildContext context) {
    // Método build, que constrói a interface do widget.

    return Column(
      // Organiza os elementos em uma coluna (vertical).
      children: [
        // Adiciona os widgets filhos na coluna.
        CachedNetworkImage(
          // Carrega a imagem a partir de uma URL com suporte a cache.
          imageUrl: imageUrl, 
          // URL da imagem a ser carregada.
          imageBuilder: (context, imageProvider) => CircleAvatar(
            // Quando a imagem for carregada com sucesso, ela será exibida em um avatar circular.
            radius: 24, 
            // Define o raio do avatar circular.
            backgroundImage: imageProvider, 
            // Define a imagem carregada como plano de fundo do avatar.
          ),
          placeholder: (context, url) => const CircleAvatar(
            // Mostra um avatar circular enquanto a imagem está carregando.
            radius: 24, 
            // Define o raio do avatar.
            backgroundColor: Colors.grey, 
            // Cor de fundo cinza enquanto a imagem carrega.
            child: Icon(Icons.sports_soccer, color: Colors.white), 
            // Ícone temporário para indicar que é um time de futebol.
          ),
          errorWidget: (context, url, error) => const CircleAvatar(
            // Mostra um avatar circular se ocorrer um erro ao carregar a imagem.
            radius: 24, 
            // Define o raio do avatar.
            backgroundColor: Colors.red, 
            // Cor de fundo vermelha para indicar um erro.
            child: Icon(Icons.error, color: Colors.white), 
            // Ícone de erro dentro do avatar.
          ),
        ),
        const SizedBox(height: 5), 
        // Espaçamento vertical de 5 pixels entre a imagem e o nome do time.
        Text(
          teamName, 
          // Exibe o nome do time.
          style: const TextStyle(fontSize: 14), 
          // Define o estilo do texto (tamanho da fonte).
        ),
      ],
    );
    // Retorna a coluna contendo a imagem e o nome do time.
  }
}
