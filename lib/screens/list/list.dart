import 'package:flutter/material.dart';
import 'package:studioghibli/services/api_service.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = ApiService();
    service.getMovies();
    return Scaffold(
      body: Center(child: Text('hi')),
    );
  }
}
