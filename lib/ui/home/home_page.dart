import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vizzano_report_tv/ui/home/provider/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: Center(
              child: Text('Selected Index: ${provider.selectedIndex}'),
            ),
          );
        },
      ),
    );
  }
}
