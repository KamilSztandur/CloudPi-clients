import 'package:app/features/create_new_user/data/models/user.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DeleteUserView extends StatefulWidget {
  DeleteUserView({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UsersService service = UsersService();
  final User user;

  @override
  _DeleteUserViewState createState() => _DeleteUserViewState();
}

class _DeleteUserViewState extends State<DeleteUserView> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: const EdgeInsets.only(
        top: 30,
        right: 40,
        left: 40,
        bottom: 10,
      ),
      title: _buildTitle(context),
      content: _buildBody(context),
      actions: _buildActions(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 2,
      text: TextSpan(
        text: 'Are you sure you want to delete ',
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
        children: <TextSpan>[
          TextSpan(
            text: widget.user.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const TextSpan(text: '?'),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            foregroundImage: Image.asset('assets/profilepic.jpg').image,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "This will also result in all \n user's data termination.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'This operation cannot be undone.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      OutlinedButton(
        onPressed: _onCancelPressed,
        style: OutlinedButton.styleFrom(
          primary: Colors.black.withOpacity(0.65),
        ),
        child: const Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: _onDeletePressed,
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: const Text('Delete'),
      ),
    ];
  }

  void _onDeletePressed() {
    //TODO
  }

  void _onCancelPressed() => AutoRouter.of(context).pop();
}
