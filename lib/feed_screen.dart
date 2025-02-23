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
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navegar para a tela de perfil
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
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

// Tela de Perfil (agora dentro de feed_screen.dart)
class ProfileScreen extends StatelessWidget {
  final String userName = "Usuário Teste";
  final String userEmail = "usuario@teste.com";
  final String userDescription =
      "Olá! Eu sou um usuário de exemplo nesta rede social.";
  final String userPhotoUrl =
      "https://via.placeholder.com/150"; // URL da foto de perfil

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Navegar para a tela de edição de perfil (a ser implementada)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Funcionalidade de edição em desenvolvimento'),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userPhotoUrl),
              radius: 50,
            ),
            SizedBox(height: 16.0),
            Text(
              userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(userEmail, style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 16.0),
            Text(
              userDescription,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para editar o perfil
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Funcionalidade de edição em desenvolvimento',
                    ),
                  ),
                );
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
