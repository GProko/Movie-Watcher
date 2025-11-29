import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movie_watcher/models/movie.dart';

class ModifyMovieScreen extends StatefulWidget {
  final String movieId;
  const ModifyMovieScreen({required this.movieId});

  @override
  State<ModifyMovieScreen> createState() => _ModifyMovieScreenState();
}

class _ModifyMovieScreenState extends State<ModifyMovieScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _videoUrlController =
      TextEditingController(); // New field for video URL
  @override
  void initState() {
    super.initState();
    _fetchMovieDetails(); // Fetch movie details on initialization
  }

  Future<void> _fetchMovieDetails() async {
    DocumentSnapshot snapshot =
        await firestore.collection('movies').doc(widget.movieId).get();
    if (snapshot.exists) {
      Movie movie = Movie.fromMap(snapshot.data() as Map<String, dynamic>);
      _titleController.text = movie.title;
      _genreController.text = movie.genre;
      _descriptionController.text = movie.description;
      _imageUrlController.text = movie.imageUrl;
      _videoUrlController.text = movie.videoUrl; // Populate video URL
    } else {
      // Handle case where the movie does not exist
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Movie not found')),
      );
      Navigator.pop(context); // Go back if movie is not found
    }
  }

  Future<void> _updateMovie() async {
    Movie updatedMovie = Movie(
      id: widget.movieId,
      title: _titleController.text.trim(),
      genre: _genreController.text.trim(),
      description: _descriptionController.text.trim(),
      imageUrl: _imageUrlController.text.trim(),
      videoUrl: _videoUrlController.text.trim(), // Set video URL
    );
    await firestore
        .collection('movies')
        .doc(updatedMovie.id)
        .update(updatedMovie.toMap());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Movie updated successfully')),
    );
    Navigator.pop(context); // Go back after updating
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modify Movie')),
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
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _videoUrlController, // New field for video URL
              decoration: InputDecoration(labelText: 'YouTube Video URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: _updateMovie, child: Text('Update Movie')),
          ],
        ),
      ),
    );
  }
}
