import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:myapp/views/authentication/bloc/authentication_bloc.dart';

class UserPage extends StatelessWidget {
  static const routeName = '/user';
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final activeUser = context.watch<AuthenticationBloc>().activeUser;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: largeSize),
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      activeUser?.imageUrl ?? 'https://i.pravatar.cc/150',
                    ),
                  ),
                  title: Text(activeUser != null
                      ? '${activeUser.firstName} ${activeUser.lastName}'.trim()
                      : 'User Full Name'),
                  subtitle: Text(activeUser?.username ?? 'Username'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    largeSize,
                    0,
                    largeSize,
                    largeSize,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Followers: ${activeUser?.followerCount ?? 0}',
                      ),
                      const SizedBox(width: mediumSize),
                      Text(
                        'Following: ${activeUser?.followingCount ?? 0}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Logout'),
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLoggedOutEvent());
            },
          ),
        ],
      ),
    );
  }
}
