import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      'username': 'usuario1',
      'image': 'https://via.placeholder.com/150',
      'description': 'Esta é uma postagem de exemplo 1.',
      'likes': 120,
      'isLiked': false,
      'comments':
          <String>[], // Lista de comentários (agora tipada como List<String>)
    },
    {
      'username': 'usuario2',
      'image': 'https://via.placeholder.com/150',
      'description': 'Esta é uma postagem de exemplo 2.',
      'likes': 95,
      'isLiked': false,
      'comments': <String>[],
    },
    {
      'username': 'usuario3',
      'image': 'https://via.placeholder.com/150',
      'description': 'Esta é uma postagem de exemplo 3.',
      'likes': 200,
      'isLiked': false,
      'comments': <String>[],
    },
  ];
  // Função para curtir/descurtir uma postagem
  void _toggleLike(int index) {
    setState(() {
      posts[index]['isLiked'] = !posts[index]['isLiked'];
      if (posts[index]['isLiked']) {
        posts[index]['likes'] += 1;
      } else {
        posts[index]['likes'] -= 1;
      }
    });
  }

  void _navigateToCreatePost(BuildContext context) async {
    // Navegar para a tela de postagem e aguardar o resultado
    final newPostContent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreatePostScreen()),
    );

    // Se houver resultado, adicione a nova postagem ao feed
    if (newPostContent != null) {
      setState(() {
        posts.insert(0, {
          'username': 'Usuário Teste',
          'image': 'https://via.placeholder.com/150',
          'description': newPostContent,
          'likes': '0 curtidas',
          'isLiked': false,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreatePost(context),
        child: Icon(Icons.add),
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
                    '${post['likes']} curtidas',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ButtonBar(
                  children: [
                    IconButton(
                      icon: Icon(
                        post['isLiked']
                            ? Icons.thumb_up
                            : Icons.thumb_up_alt_outlined,
                        color: post['isLiked'] ? Colors.blue : null,
                      ),
                      onPressed:
                          () =>
                              _toggleLike(index), // Chama a função _toggleLike
                    ),
                    IconButton(
                      icon: Icon(Icons.comment),
                      onPressed: () {
                        // Navegar para a tela de comentários
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => CommentScreen(
                                  postId:
                                      index
                                          .toString(), // Passa o ID da postagem
                                  comments: List<String>.from(
                                    post['comments'],
                                  ), // Converte para List<String>
                                ),
                          ),
                        );
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

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Usuário Teste";
  String userEmail = "usuario@teste.com";
  String userDescription =
      "Olá! Eu sou um usuário de exemplo nesta rede social.";
  final String userPhotoUrl =
      "https://via.placeholder.com/150"; // URL da foto de perfil

  void _navigateToEditProfile(BuildContext context) async {
    // Navegar para a tela de edição e aguardar o resultado
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditProfileScreen(
              userName: userName,
              userEmail: userEmail,
              userDescription: userDescription,
            ),
      ),
    );

    // Se houver resultado, atualize os dados do perfil
    if (result != null) {
      setState(() {
        userName = result['name'];
        userEmail = result['email'];
        userDescription = result['description'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _navigateToEditProfile(context),
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
              onPressed: () => _navigateToEditProfile(context),
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de Edição de Perfil
class EditProfileScreen extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userDescription;

  EditProfileScreen({
    required this.userName,
    required this.userEmail,
    required this.userDescription,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userName);
    _emailController = TextEditingController(text: widget.userEmail);
    _descriptionController = TextEditingController(
      text: widget.userDescription,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Aqui você pode salvar as alterações
    String newName = _nameController.text;
    String newEmail = _emailController.text;
    String newDescription = _descriptionController.text;

    print('Nome: $newName');
    print('Email: $newEmail');
    print('Descrição: $newDescription');

    // Navegar de volta para a tela de perfil com os novos dados
    Navigator.pop(context, {
      'name': newName,
      'email': newEmail,
      'description': newDescription,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveProfile)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de Postagem
class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _postController = TextEditingController();

  void _publishPost() {
    String postContent = _postController.text;

    if (postContent.isNotEmpty) {
      // Aqui você pode adicionar a lógica para publicar a postagem
      print('Postagem publicada: $postContent');

      // Retornar a postagem para a tela de feed
      Navigator.pop(context, postContent);
    } else {
      // Mostrar uma mensagem de erro se o campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, escreva algo para publicar.')),
      );
    }
  }

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Postagem')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _postController,
              decoration: InputDecoration(
                labelText: 'O que você está pensando?',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _publishPost,
              child: Text('Publicar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de Comentários
class CommentScreen extends StatefulWidget {
  final String postId; // Identificador da postagem
  final List<String>
  comments; // Lista de comentários (agora tipada como List<String>)

  CommentScreen({required this.postId, required this.comments});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = [];

  @override
  void initState() {
    super.initState();
    comments = widget.comments; // Inicializa a lista de comentários
  }

  void _addComment() {
    String newComment = _commentController.text;

    if (newComment.isNotEmpty) {
      setState(() {
        comments.add(newComment); // Adiciona o novo comentário à lista
      });
      _commentController.clear(); // Limpa o campo de texto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comentários')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(comments[index]));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Escreva um comentário...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: _addComment),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
