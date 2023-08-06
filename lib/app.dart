import 'package:flutter/material.dart';

import 'posts/view/posts_page.dart';

class MyApp extends MaterialApp {
  const MyApp({super.key}) : super(home: const PostsPage(), debugShowCheckedModeBanner: false);
}