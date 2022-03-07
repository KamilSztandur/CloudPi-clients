import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DownloadIndicatorPopup {
  DownloadIndicatorPopup({
    required this.context,
    required this.progress,
  });

  final BuildContext context;
  double progress;

  void show() => showDialog<void>(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: Stack(
                  children: [
                    Center(child: _buildCircleIndicator()),
                    Center(child: _buildTextIndicator()),
                  ],
                ),
              );
            },
          );
        },
      );

  Widget _buildCircleIndicator() {
    final size = MediaQuery.of(context).size.shortestSide * 0.5;
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        backgroundColor: Colors.white,
        value: _isProgressValid() ? progress : null,
      ),
    );
  }

  Widget _buildTextIndicator() {
    final message =
        _isProgressValid() ? 'Downloading...' : '${(progress * 100).round()}%';

    return Text(
      message,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  bool _isProgressValid() => progress > 1.0 || progress < 0;

  void updateProgress(
    void Function(void Function()) setState,
    double progress,
  ) =>
      setState(() {
        this.progress = progress;
      });

  void close() => AutoRouter.of(context).pop();
}
