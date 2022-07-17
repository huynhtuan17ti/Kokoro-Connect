//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';
import 'package:sus_app/models/models.dart';
import 'package:sus_app/screens/screens.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.currentTab,
  }) : super(key: key);

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: AppPages.home,
      key: const ValueKey(AppPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  final int currentTab;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static List<Widget> pages = const [
    HomeScreen(),
    SearchScreen(),
    MyPostsScreen(),
    NotifyScreen(),
  ];

  //User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateManager>(
      builder: (
        context,
        appStateManager,
        child,
      ) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: const Text('Kokoro Connect'),
            actions: [
              profileButton(),
            ],
          ),
          // extendBodyBehindAppBar: true,

          // body: StreamBuilder<DocumentSnapshot>(
          //   stream: FirebaseFirestore.instance
          //       .collection("users")
          //       .doc(user!.uid)
          //       .snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const Center(
          //         child: CircularProgressIndicator(
          //           //backgroundColor: Colors.greenAccent,
          //           color: Colors.greenAccent,
          //         ),
          //       );
          //     }
          //     final data = snapshot.data;
          //     /// Review: should add a check just in case parsing model from json cause
          //     /// error which will obviously break all the below code.
          //     switch (snapshot.data) {
          //       case null:
          //         return const Center(
          //           child: Text('Something gone wrong'),
          //         );
          //       default:
          //         try {
          //           loggedInUser = UserModel.fromMap(data);
          //         } catch (e) {
          //           return const Center(
          //             child: Text('Something gone wrong'),
          //           );
          //         }
          //         //print(loggedInUser.firstName);
          //         Provider.of<ProfileManager>(context, listen: true)
          //             .updateUserData(loggedInUser);
          //         return IndexedStack(
          //           index: widget.currentTab,
          //           children: pages,
          //         );
          //     }
          //   },
          // ),
          body: IndexedStack(
            index: widget.currentTab,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 30,
            backgroundColor: backgroundColor,
            selectedItemColor: textColor,
            unselectedItemColor: secondaryColor,
            currentIndex: widget.currentTab,
            showSelectedLabels: true,
            onTap: (index) {
              /// Review: can use shortcut like [context.read]
              context.read<AppStateManager>().goToTab(index);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Search',
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: 'Post',
                icon: Icon(Icons.post_add),
              ),
              BottomNavigationBarItem(
                label: 'Notification',
                icon: Icon(Icons.notifications),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget profileButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        child: const Icon(
          Icons.account_circle,
          size: 40,
          color: textColor,
        ),
        onTap: () {
          context.read<ProfileManager>().onProfilePressed(true);
        },
      ),
    );
  }
}
