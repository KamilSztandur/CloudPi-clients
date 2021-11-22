import 'package:app/features/app/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => AutoRouter.of(context).navigate(const SearchRoute()),
      icon: const Icon(
        Icons.search_outlined,
        color: Colors.white,
      ),
    );
  }
}
