import 'package:flutter/material.dart';
import 'data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _theme = ThemeData(
    brightness: Brightness.light,
  );

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.teal),
  );

  void toggleTheme() {
    setState(() {
      _theme = _theme.brightness == Brightness.dark ? _lightTheme : _darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _theme,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Url Launcher ',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Url Launcher'),
          actions: [
            IconButton(
              onPressed: () => toggleTheme(),
              icon: const Icon(Icons.dark_mode),
            )
          ],
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.map((item) {
        return Card(
          child: ListTile(
            onTap: () => _launchURL(item['url']),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: FaIcon(
                item['icon'],
                color: item['color'],
                size: 25,
              ),
            ),
            title: Text(
              item['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(item['url']),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => _launchURL(item['url']),
            ),
          ),
        );
      }).toList(),
    );
  }
}
