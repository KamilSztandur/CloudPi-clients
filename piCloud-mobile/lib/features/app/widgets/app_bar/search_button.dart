import 'package:app/features/app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => AutoRouter.of(context).push(
        SearchRoute(currentPath: path),
      ),
      icon: const Icon(
        Icons.search_outlined,
        color: Colors.white,
      ),
    );
  }
}
