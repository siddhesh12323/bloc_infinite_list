import 'package:bloc_infinite_list/posts/bloc/post_bloc.dart';
import 'package:bloc_infinite_list/posts/bloc/post_event.dart';
import 'package:bloc_infinite_list/posts/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_loader.dart';
import '../widgets/post_list_item.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key});

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      switch (state.status) {
        case PostStatus.failure:
          return Center(child: Text('Failed to fetch posts', style: Theme.of(context).textTheme.displayMedium,),);
        case PostStatus.initial:
          return const Center(child: CircularProgressIndicator(),);
        case PostStatus.success:
          if(state.posts.isEmpty) {
            return Center(child: Text('No more posts', style: Theme.of(context).textTheme.displayMedium,),);
          }
          return ListView.builder(itemBuilder: (context, index) {
            return index >= state.posts.length ? const BottomLoader() : PostListItem(post: state.posts[index]);
          }, itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1, controller: _scrollController,); 
      }
    });
  }

  @override
  void dispose() {
    _scrollController..removeListener(_onScroll)..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}