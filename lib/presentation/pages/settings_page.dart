import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//My imports
import 'package:hacker_news_clone/presentation/theme/theme.dart';
import 'package:hacker_news_clone/presentation/widgets/settings/info_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Card(
                elevation: 1,
                margin: EdgeInsets.fromLTRB(16, 20, 16, 25),
                color: Color(0xFFFF965b),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: ListTile(
                  title: Text(
                    'HackerNews Reader v1.0.0',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17.5, color: Colors.black),
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const SizedBox(
                  height: 0.1,
                ),
                title: Text('About'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).accentColor)),
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                ),
                title: const Text(
                  'App Info',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const AppInfoPage(),
                        fullscreenDialog: true,
                      ));
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Divider(),
              ListTile(
                leading: const SizedBox(
                  height: 0.1,
                ),
                title: Text('General'.toUpperCase(),
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).accentColor)),
              ),
              Consumer<ThemeNotifier>(
                builder: (BuildContext context, ThemeNotifier notifier,
                        Widget? child) =>
                    SwitchListTile(
                        title: const Text(
                          'Dark Theme',
                          style: TextStyle(fontSize: 16),
                        ),
                        secondary: const Icon(Icons.brightness_6_outlined),
                        activeColor: Colors.deepOrangeAccent,
                        value: notifier.darkTheme,
                        onChanged: (bool value) {
                          notifier.toggleTheme();
                        }),
              ),
              const Divider(),
              const SizedBox(
                height: 10.0,
              ),
              const Center(child: Text('LOGO')),
            ],
          ),
        ));
  }
}
