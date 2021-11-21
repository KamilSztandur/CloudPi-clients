import 'package:flutter/material.dart';

class FileExplorerErrorWidget extends StatelessWidget {
  const FileExplorerErrorWidget({
    Key? key,
    this.errorMessage,
  }) : super(key: key);

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            size: 150,
            color: Colors.black,
          ),
          const SizedBox(height: 7.5),
          const Text(
            'Oops! Something went wrong.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Text(
            errorMessage ?? '',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
