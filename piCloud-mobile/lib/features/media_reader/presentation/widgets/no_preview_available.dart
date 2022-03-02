import 'package:flutter/material.dart';

class NoPreviewAvailable extends StatefulWidget {
  const NoPreviewAvailable({
    Key? key,
    required this.path,
    required this.resourceName,
    required this.onDownloadRequested,
  }) : super(key: key);

  final String path;
  final String resourceName;
  final VoidCallback onDownloadRequested;

  @override
  _NoPreviewAvailableState createState() => _NoPreviewAvailableState();
}

class _NoPreviewAvailableState extends State<NoPreviewAvailable> {
  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No preview available',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const Icon(
              Icons.image_not_supported,
              size: 175,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            Text(
              widget.resourceName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onDownloadRequested,
              child: const Text('Download'),
            ),
          ],
        ),
      );
}
