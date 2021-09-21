import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/routes/app_routes.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({
    required this.user,
    Key? key,
  }) : super(key: key);
  static const circleAvatarPerson = CircleAvatar(child: Icon(Icons.person));
  static const iconEdit = Icons.edit;
  static const iconDelete = Icons.delete;

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? circleAvatarPerson
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: () {              
              Navigator.of(context).pushNamed(AppRoutes.userForm,
              arguments: user);
            }, icon: const Icon(iconEdit), color: Colors.orange),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete), color: Colors.red)
          ],
        ),
      ),
    );
  }
}
