import 'package:app/common/auth/auth_manager.dart';
import 'package:app/contracts/client_index.dart';
import 'package:app/features/app/widgets/app_bar/user_profile_image.dart';
import 'package:app/features/settings/data/admin_services/users_service.dart';
import 'package:app/features/user_wizard/data/models/user.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteUserView extends StatefulWidget {
  const DeleteUserView({
    Key? key,
    required this.user,
    required this.onConfirm,
  }) : super(key: key);

  final User user;
  final VoidCallback onConfirm;

  @override
  _DeleteUserViewState createState() => _DeleteUserViewState();
}

class _DeleteUserViewState extends State<DeleteUserView> {
  late UsersService service;

  @override
  void initState() {
    service = UsersService(context.read<Api>(), context.read<AuthManager>());
    super.initState();
  }

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
          child: UserProfileImage(
            username: widget.user.username,
            size: 20,
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
        child: Text(
          'Cancel',
          style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
      ElevatedButton(
        onPressed: _onDeletePressed,
        style: ElevatedButton.styleFrom(primary: Colors.red),
        child: const Text('Delete'),
      ),
    ];
  }

  Future<void> _onDeletePressed() async {
    await service.deleteUser(widget.user.username);
    widget.onConfirm();
    await AutoRouter.of(context).pop();
  }

  void _onCancelPressed() => AutoRouter.of(context).pop();
}
