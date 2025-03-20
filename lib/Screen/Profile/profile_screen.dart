import 'package:ar_furniture/Screen/Auth/auth_service.dart';
import 'package:ar_furniture/component/info-tile.dart';
import 'package:ar_furniture/constants.dart';
import 'package:ar_furniture/services/profile_service.dart';
import 'package:ar_furniture/component/profile_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileService profileService = Get.find();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot>(
          stream: profileService.getUserDataStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;
            final user = UserModel.fromMap(userData);

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // profile image
                    ProfileTile(name: user.name, email: user.email),
                    // other
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        'Account',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                        )),
                      ),
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Order.svg",
                      name: 'Orders',
                      onTap: () {},
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Return.svg",
                      name: 'Returns',
                      onTap: () {},
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Address.svg",
                      name: 'Addresss',
                      onTap: () {},
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Wallet.svg",
                      name: 'Payment History',
                      onTap: () {},
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        'Settings',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                        )),
                      ),
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Language.svg",
                      name: 'Language',
                      onTap: () {},
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Location.svg",
                      name: 'Location',
                      onTap: () {},
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Text(
                        'Help & Support',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: darkGreyColor,
                        )),
                      ),
                    ),
                    InfoTile(
                      imgPath: "assets/icons/Help.svg",
                      name: 'Get Help',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
