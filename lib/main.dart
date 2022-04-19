import 'package:flutter/material.dart';
import 'data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Url Launcher ',
      home: HomePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Url Launcher'),
      ),
      body: ListView(
        children: data.map((item) {
          return Card(
            child: ListTile(
              onTap: () => _launchURL(item['url']),
              leading: FaIcon(
                item['icon'],
                color: item['color'],
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
      ),
    );
  }
}
