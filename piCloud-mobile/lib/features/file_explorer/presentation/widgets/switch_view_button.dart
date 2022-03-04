import 'package:app/common/models/view_mode.dart';
import 'package:app/common/preferences/view_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchViewButton extends StatefulWidget {
  const SwitchViewButton({
    Key? key,
    required this.viewSwitched,
  }) : super(key: key);

  final VoidCallback viewSwitched;

  @override
  _SwitchViewButtonState createState() => _SwitchViewButtonState();
}

class _SwitchViewButtonState extends State<SwitchViewButton> {
  @override
  Widget build(BuildContext context) {
    final viewMode = context.watch<ViewModeCubit>().state;

    return FutureBuilder(
      future: _getIcon(viewMode),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return IconButton(
            onPressed: () => _onSwitchPressed(context),
            icon: Icon(
              snapshot.data! as IconData,
              color: Colors.white,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Future<IconData> _getIcon(ViewMode viewMode) async {
    switch (viewMode) {
      case ViewMode.tile:
        return Icons.view_list_outlined;
      case ViewMode.list:
        return Icons.grid_view_outlined;
    }
  }

  Future<void> _onSwitchPressed(BuildContext context) async {
    context.read<ViewModeCubit>().toggleViewMode();
  }
}
