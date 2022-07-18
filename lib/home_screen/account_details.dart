import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    height: 180,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Positioned(
                          top: -40,
                          child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(user.photoURL!)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 60),
                            const Text(
                              'Account Details ',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              ' Name :  ${user.displayName!}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              ' Email :  ${user.email!}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        icon: const Icon(
          Icons.account_circle,
          size: 32,
          color: Colors.white,
        ));
  }
}
