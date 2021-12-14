import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LoginProgressIndicator {
  void show(BuildContext context) => showDialog<void>(
        context: context,
        builder: (_) => _buildBody(),
        barrierDismissible: false,
      );

  void close(BuildContext context) => AutoRouter.of(context).pop();

  Widget _buildBody() {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: const <Widget>[
          SizedBox(
            height: 250,
            width: 250,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
          Text(
            'Loging in...',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
