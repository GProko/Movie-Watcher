import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_watcher/models/movie.dart';

class AddMovieScreen extends StatefulWidget {
  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _videoUrlController = TextEditingController();

  Future<void> _addMovie() async {
    if (_titleController.text.isNotEmpty &&
        _genreController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _imageUrlController.text.isNotEmpty &&
        _videoUrlController.text.isNotEmpty) {
      Movie movie = Movie(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        genre: _genreController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        videoUrl: _videoUrlController.text.trim(),
      );

      await FirebaseFirestore.instance
          .collection('movies')
          .doc(movie.id)
          .set(movie.toMap());
      Navigator.pop(context); //to go back to home screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Movie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image Url '),
            ),
            TextField(
              controller: _videoUrlController,
              decoration: InputDecoration(labelText: 'Youtube Video Url'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _addMovie, child: Text('Add Movie')),
          ],
        ),
      ),
    );
  }
}
