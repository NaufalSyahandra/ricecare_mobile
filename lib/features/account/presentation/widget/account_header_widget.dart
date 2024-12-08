import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/account/domain/entities/account.dart';

class AccountHeaderWidget extends StatelessWidget {
  final Account profile;

  const AccountHeaderWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 3,
          decoration: const BoxDecoration(
            color: Color(0xFF15B392),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const Text(
                'Pengaturan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(profile.profile_picture),
              ),
              const SizedBox(height: 15),
              Text(
                profile.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
