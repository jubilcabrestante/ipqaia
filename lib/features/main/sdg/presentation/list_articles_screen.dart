import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ListArticlesScreen extends StatefulWidget {
  const ListArticlesScreen({super.key});

  @override
  State<ListArticlesScreen> createState() => _ListArticlesScreenState();
}

class _ListArticlesScreenState extends State<ListArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Text("list");
  }
}
