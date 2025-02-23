// feed_screen.dart
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'username': 'usuario1',
      'image': 'https://via.placeholder.com/150',
      'description': 'Esta é uma postagem de exemplo 1.',
      'likes': '120 curtidas',
    },
    {
      'username': 'usuario2',
      'image': 'https://via.placeholder.com/150',
      'description': 'Esta é uma postagem de exemplo 2.',
      'likes': '95 curtidas',
    },
    {
      'username': 'usuario3',
      'image': 'https://via.placeholder.com/150',
      'description': 'Esta é uma postagem de exemplo 3.',
      'likes': '200 curtidas',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed')),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post['image']!),
                  ),
                  title: Text(post['username']!),
                ),
                Image.network(
                  post['image']!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post['description']!),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    post['likes']!,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ButtonBar(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        // Lógica para curtir a postagem
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Lógica para comentar na postagem
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // Lógica para compartilhar a postagem
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
