import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:preferences/preference_page.dart';
import 'package:preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}
  class  _SettingsPageState extends State<SettingsPage> {
@override
  Widget build(BuildContext context) {
  
  return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: PreferencePage([
        // PreferenceTitle('General'),
        // DropdownPreference(
        //   'Start Page',
        //   'start_page',
        //   defaultVal: 'Timeline',
        //   values: ['Posts', 'Timeline', 'Private Messages'],
        // ),
        PreferenceTitle('Language'),
        RadioPreference(
          'English',
          'en',
          'app_language',
          isDefault: true,
        ),
        RadioPreference(
          'Dutch',
          'nl',
          'app_language',
        ),
      ]),
    );
  }
    
  
}