//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sus_app/models/models.dart';
import 'package:sus_app/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:sus_app/services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static MaterialPage page() {
    return const MaterialPage(
      name: AppPages.profilePath,
      key: ValueKey(AppPages.profilePath),
      child: ProfileScreen(),
    );
  }

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder<User>(
          future: ApiService.profile(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Some errors occurred!'),
                  );
                } else {
                  final User user = snapshot.data;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildProfile(user),
                          const SizedBox(height: 100),
                          SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: MaterialButton(
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: const Text(
                                'Log out',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                logout();

                                context
                                    .read<ProfileManager>()
                                    .onProfilePressed(false);

                                context.read<AppStateManager>().logout();

                                //context.read<ProfileManager>().logout();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }

  Widget buildProfile(User user) {
    double csize = 0.04;
    return Column(
      children: [
        const Icon(
          Icons.account_circle,
          size: 120,
          color: Color.fromRGBO(108, 196, 161, 1),
        ),
        const SizedBox(
          height: 25,
        ),
        ListTile(
          leading: Text(
            'Personal information',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            '',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            'Username:',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * csize,
            ),
          ),
          trailing: Text(
            user.username,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * csize,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            'Full name:',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * csize,
            ),
          ),
          trailing: Text(
            user.fullname,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * csize,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: Text(
            'Email:',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * csize),
          ),
          trailing: Text(
            user.email,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * csize),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        ListTile(
          leading: Text(
            'Service',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.phone,
            size: 30,
          ),
          title: Text(
            'Contact us',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * csize),
          ),
          trailing: Text(
            'korokoconnect@gmail.com',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * csize,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          child: ListTile(
            leading: const Icon(
              Icons.location_city,
              size: 30,
            ),
            title: Text(
              'Become an Organizer',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * csize),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> logout() async {
    ApiService.logout();
  }
}
