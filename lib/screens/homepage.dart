import 'package:flutter/material.dart';
import 'package:sharptrack/screens/profilepage.dart';
import 'package:sharptrack/screens/helpscreen.dart';
import 'package:sharptrack/skeleton.dart';
import 'package:sharptrack/widgets/homepagecontent.dart';
import 'package:sharptrack/widgets/settings.dart';
import 'package:provider/provider.dart';

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
                        return ProfilePage();
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
        body: currentPage == 0 ? HomePageContent() : Settings(),
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
