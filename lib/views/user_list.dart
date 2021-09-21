import 'package:flutter/material.dart';
import 'package:flutter_crud/components/user_tile.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  final Users users = Provider.of(context);
  const titleUserList = Text('Lista de Usuários');
    return Scaffold(
        appBar: AppBar(
          title: titleUserList,
          actions: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.userForm);
            }, icon: Icon(Icons.add))
          ],
        ),
        body: ListView.builder(
            itemCount: users.count,
            itemBuilder: (ctx, i) =>
                UserTile(user: users.byIndex(i))));
  }
}
