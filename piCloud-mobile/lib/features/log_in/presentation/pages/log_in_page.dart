import 'package:app/features/log_in/presentation/widgets/login_header.dart';
import 'package:app/features/log_in/presentation/widgets/login_panel.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool animationExecuted = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!animationExecuted) {
        setState(() {
          animationExecuted = true;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final panelHeight = MediaQuery.of(context).size.height * 0.55;
    final panelWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const LoginHeader(),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1100),
                opacity: animationExecuted ? 1.0 : 0.0,
                child: AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 1000),
                  height: animationExecuted ? panelHeight : panelHeight * 0.75,
                  width: panelWidth,
                  child: const LoginPanel(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
