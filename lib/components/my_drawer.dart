
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../constants/constants.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            //logo
              children: [
                const DrawerHeader(
                    child: Center(
                        child: Text(Constants.appTitle,style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),)
                    )),

                //home list tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text(Constants.homeText),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      //pop the drawer
                      Navigator.pop(context);

                    },
                  ),
                ),

                //setting list tile
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: const Text(Constants.settingsText),
                    leading: const Icon(Icons.settings),
                    onTap: () {
                      //pop the drawer
                      Navigator.pop(context);

                    },
                  ),
                ),

                //logout list tile
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    title: Text(Constants.logoutText),
                    leading: Icon(Icons.logout),

                  ),
                ),
              ]),
        ],
      ),
    );
  }
}