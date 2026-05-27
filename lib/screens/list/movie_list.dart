import 'package:flutter/material.dart';
import 'package:studioghibli/services/api_service.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ApiService();
    service.getMovies();
    return Scaffold(
      body: Center(child: Text('hi')),
    );
  }
}
