import 'package:flutter/material.dart';
import 'package:my_news/src/services/news_service.dart';
import 'package:provider/provider.dart';

import 'package:my_news/src/theme/dark.dart';
import 'package:my_news/src/pages/tabs_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new NewsService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: myTheme,
        home: TabsPage(),
      ),
    );
  }
}
