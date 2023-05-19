import 'package:flutter/material.dart';
import 'package:sharptrack/screens/profilepage.dart';
import 'package:sharptrack/screens/helpscreen.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:sharptrack/widgets/homepagecontent.dart';
import 'package:sharptrack/widgets/settings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_background/flutter_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Skeleton>(context, listen: false)
        .enableBackgoundService(context);
    enableBackgroundService();
  }

  void enableBackgroundService() async {
    const androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "Sharptrack",
      notificationText:
          "Background notification for keeping sharptrack running in the background",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(
          name: 'background_icon',
          defType: 'drawable'), // Default is ic_launcher from folder mipmap
    );
    print("enabling background");
    bool success =
        await FlutterBackground.initialize(androidConfig: androidConfig);
    if (success) {
      print("background enabled");
    } else {
      print("background not enabled");
    }
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage != 0) {
          setState(() {
            currentPage = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return const ProfilePage();
                      }),
                    ),
                  );
                },
                child: Consumer<Skeleton>(
                  builder: (context, value, child) => Text(
                    value.name[0],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: const Text('#Track'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Helpscreen();
                    }),
                  );
                },
                child: const Icon(
                  Icons.help_outline_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
        body: currentPage == 0 ? HomePageContent() : const Settings(),
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings')
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPage = index;
            });
          },
          selectedIndex: currentPage,
        ),
      ),
    );
  }
}
