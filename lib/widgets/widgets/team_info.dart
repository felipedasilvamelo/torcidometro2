import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TeamInfo extends StatelessWidget {
  final String teamName; 
  final String imageUrl; 

  const TeamInfo({
    required this.teamName, 
    required this.imageUrl, 
    super.key, 
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl, 
          imageBuilder: (context, imageProvider) => CircleAvatar(
            radius: 24, 
            backgroundImage: imageProvider, 
          ),
          placeholder: (context, url) => const CircleAvatar(
            radius: 24, 
            backgroundColor: Colors.grey, 
            child: Icon(Icons.sports_soccer, color: Colors.white), 
          ),
          errorWidget: (context, url, error) => const CircleAvatar(
            radius: 24, 
            backgroundColor: Colors.red, 
            child: Icon(Icons.error, color: Colors.white), 
          ),
        ),
        const SizedBox(height: 5), 
      
        Text(
          teamName, 
       
          style: const TextStyle(fontSize: 14), 
      
        ),
      ],
    );
  
  }
}
