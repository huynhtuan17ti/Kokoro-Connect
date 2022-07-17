import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';
import 'package:sus_app/models/models.dart';
import 'package:sus_app/screens/screens.dart';
import 'package:provider/provider.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({Key? key}) : super(key: key);

  static MaterialPage page() {
    return const MaterialPage(
      name: AppPages.initalizePath,
      key: ValueKey(AppPages.initalizePath),
      child: InitializeScreen(),
    );
  }

  @override
  InitializeScreenState createState() => InitializeScreenState();
}

class InitializeScreenState extends State<InitializeScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              child: Image.asset(
                'assets/logo.gif',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
