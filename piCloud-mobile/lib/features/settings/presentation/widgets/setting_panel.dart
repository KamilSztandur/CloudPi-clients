import 'package:flutter/material.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({
    Key? key,
    required this.header,
    required this.icon,
    required this.subPanel,
  }) : super(key: key);

  final String header;
  final IconData icon;
  final Widget subPanel;

  @override
  _SettingsPanelState createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final panel = ExpansionPanel(
      headerBuilder: (context, isExpanded) => _Header(
        header: widget.header,
        icon: widget.icon,
      ),
      body: widget.subPanel,
      isExpanded: isExpanded,
      canTapOnHeader: true,
    );

    final wrappedPanel = Dialog(
      elevation: 2,
      insetPadding: const EdgeInsets.all(10),
      child: ExpansionPanelList(
        children: [panel],
        expansionCallback: (panelIndex, value) => _onTap(),
      ),
    );

    return wrappedPanel;
  }

  void _onTap() => setState(() => isExpanded = !isExpanded);
}

class _Header extends StatelessWidget {
  const _Header({
    required this.header,
    required this.icon,
  });

  final String header;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const SizedBox(width: 17.5),
          Icon(
            icon,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 10),
          Text(
            header,
            style: const TextStyle(
              fontSize: 17.5,
            ),
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
