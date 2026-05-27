import 'package:flutter/material.dart';
import 'package:studioghibli/core/injectables.dart';
import 'package:studioghibli/screens/list/movie_list_bloc.dart';
import 'package:studioghibli/screens/list/movie_list_events.dart';
import 'package:studioghibli/screens/list/movie_list_state.dart';

class ListScreen extends StatelessWidget {
  final MovieBloc bloc = di<MovieBloc>()..add(const MovieEventFetch());

  @override
  Widget build(BuildContext context) {
    switch (bloc.state) {
      case MovieStateLoading():
        return const CircularProgressIndicator();
      case MovieStateError():
        return const Text('Oops something went wrong');
      case MovieStateLoaded():
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Studio Ghibli'),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Text(
                    (bloc.state as MovieStateLoaded).movies[index].title,
                  );
                }, childCount: (bloc.state as MovieStateLoaded).movies.length),
              ),
            ],
          ),
        );
    }
  }
}
