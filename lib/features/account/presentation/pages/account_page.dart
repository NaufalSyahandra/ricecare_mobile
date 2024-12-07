import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/account/presentation/pages/edit_profile_page.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<AccountPage> {
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  color: Color(0xFF15B392),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 35),
                    Text(
                      'Pengaturan',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage:
                      AssetImage('assets/images/profile.png'),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Farmer',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditProfilePage()),
                      );
                    },
                  ),
                  const Divider(thickness: 1),
                  SwitchListTile(
                    title: const Text('Notifikasi'),
                    value: isNotificationOn,
                    onChanged: (bool value) {
                      setState(() {
                        isNotificationOn = value;
                      });
                    },
                    activeColor: const Color(0xFF15B392),
                    inactiveThumbColor:
                    Colors.grey,
                    inactiveTrackColor:
                    Colors.grey[300],
                  ),
                  const Divider(thickness: 1),
                  ListTile(
                    title: const Text('Keluar'),
                    trailing: Image.asset(
                      "assets/images/profile.png",
                      height: 24,
                      width: 24,
                    ),
                    onTap: () {
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const NavbarWidget(initialIndex: 4),
    );
  }
}
