import 'package:flutter/material.dart';
import 'package:project_tuter/widgets/list_tile_card.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Get Started",
                    style: TextStyle(fontSize: 34),
                  ),
                  Spacer(),
                  Text("Your personal tuter/assistant")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
              ),
              child: Text(
                "Don't know how use? start with Greatings",
                style: TextStyle(
                  color: const Color.fromARGB(83, 0, 0, 0),
                ),
              ),
            ),
            ListTileCard(
              titleText: "Greatings",
              duration: "4 min",
              onClick: () {},
            ),
            ListTileCard(
              titleText: "Introduction",
              duration: "5 min",
              onClick: () {},
            ),
            ListTileCard(
              titleText: "Prayar",
              duration: "6 min",
              onClick: () {},
            ),
            ListTileCard(
              titleText: "Arguing",
              duration: "8 min",
              onClick: () {},
            ),
            ListTileCard(
              titleText: "Lacturing",
              duration: "10 min",
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}
