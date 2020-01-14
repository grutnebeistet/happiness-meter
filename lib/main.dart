import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happiness_meter/bloc/bloc_provider.dart';
import 'package:happiness_meter/data/database_helpers.dart';
import 'package:happiness_meter/global_translations.dart';
import 'package:happiness_meter/screens/meter_page.dart';
import 'package:happiness_meter/screens/record_list_page.dart';
import 'package:intl/intl.dart';
import 'package:preferences/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await PrefService.init(prefix: 'pref_');
  await allTranslations.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TranslationsBloc translationsBloc;
  HappinessRecord record;
   TabController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    translationsBloc = TranslationsBloc();
    //  _controller = TabController(length: 3);
    // _controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    translationsBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TranslationsBloc>(
      bloc: translationsBloc,
      child: StreamBuilder<Locale>(
          stream: translationsBloc.currentLocale,
          initialData: allTranslations.locale,
          builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
            return MaterialApp(
              locale: snapshot.data ?? allTranslations.locale,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: allTranslations.supportedLocales(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primaryColor: Colors.blueGrey,
              ),
              home: DefaultTabController(
                // length: choices.length,
                length: 3,
                child: Scaffold(
                    appBar: AppBar(
                        backgroundColor: Colors.white,
                        // actions: <Widget>[
                        //   Container(
                        //     child: IconButton(
                        //       icon: Icon(Icons.settings),
                        //       onPressed: () {
                        //         setState(() {
                        //           DatabaseHelper.instance.deleteAll();
                        //           // Navigator.push(
                        //           //     context,
                        //           //     MaterialPageRoute(
                        //           //         builder: (context) => SettingsPage()));
                        //         });
                        //       },
                        //     ),
                        //     alignment: Alignment.center,
                        //     // padding: const EdgeInsets.all(16.0),
                        //   ),
                        // ],
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(35),
                          child: Container(
                            child: SafeArea(
                              child: TabBar(
                                  indicator: UnderlineTabIndicator(
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent, width: 4.0),
                                      insets: EdgeInsets.fromLTRB(
                                          40.0, 20.0, 40.0, 0)),
                                  indicatorWeight: 15,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelColor: Color(0xff2d386b),
                                  labelStyle: TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 1.3,
                                      fontWeight: FontWeight.w500),
                                  unselectedLabelColor: Colors.black26,
                                  tabs: [
                                    Tab(
                                      text: "METER",
                                      icon: Icon(Icons.settings_input_composite, size: 40),
                                    ),
                                    Tab(
                                      text: "RECORDS",
                                      icon: Icon(Icons.book, size: 40),
                                    ),
                                    Tab(
                                      text: "PROFILE",
                                      icon: Icon(Icons.supervised_user_circle,
                                          size: 40),
                                    ),
                                  ]),
                            ),
                          ),
                        )),
                    body: TabBarView(
                      children: <Widget>[
                        Center(
                          child: MeterPage(null),
                        ),
                        Center(
                          child: RecordListPage(
                            onEditPressed:(HappinessRecord newRecord){
                              setState(() {
                                record = newRecord;
                                //  TODO complete a Tab change listener
                              });
                            }
                          ),
                        ),
                        Text("Profile, stats etc")
                      ],
                    )),
              ),
            );
            // home: HomePage());
          }),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Meter', icon: Icons.perm_data_setting),
  const Choice(title: 'Records', icon: Icons.book),
];


typedef RecordDetailCallback = void Function(HappinessRecord record);