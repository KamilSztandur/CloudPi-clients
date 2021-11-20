import 'package:flutter/material.dart';

class AppBarSearchButton extends StatelessWidget {
  const AppBarSearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //TODO
      },
      icon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }
}

class SwitchFileExplorerView extends StatelessWidget {
  const SwitchFileExplorerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        //TODO
      },
      icon: const Icon(
        Icons.list,
        size: 35,
        color: Colors.white,
      ),
    );
  }
}
