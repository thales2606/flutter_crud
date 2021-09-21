import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  static final _form = GlobalKey<FormState>();
  static final Map<String, String> _formData = {};
  const UserForm({Key? key}) : super(key: key);

  void _loadFormData(User? user) {
    _formData['id'] = user?.id ?? '';
    _formData['name'] = user?.name ?? '';
    _formData['email'] = user?.email ?? '';
    _formData['avatarUrl'] = user?.avatarUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as User?;
    const iconSave = Icon(Icons.save);
    const titleUserForm = Text('Formulário de Usuário');
    _loadFormData(user);
    return Scaffold(
        appBar: AppBar(
          title: titleUserForm,
          actions: [
            IconButton(
                onPressed: () {
                  final isValid = _form.currentState?.validate() ?? false;
                  if (isValid) {
                    _form.currentState?.save();
                    Provider.of<Users>(context, listen: false).put(User(
                        id: _formData['id'],
                        name: _formData['name'] ?? '',
                        email: _formData['email'] ?? '',
                        avatarUrl: _formData['avatarUrl'] ?? ''));
                    Navigator.of(context).pop();
                  }
                },
                icon: iconSave)
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                      initialValue: _formData['name'],
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nome inválido';
                        }
                        if (value.trim().length < 3) {
                          return 'Nome muito pequeno. No mínimo 3 letras.';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['name'] = value ?? ''),
                  TextFormField(
                      initialValue: _formData['email'],
                      decoration: const InputDecoration(labelText: 'E-mail'),
                      onSaved: (value) => _formData['email'] = value ?? ''),
                  TextFormField(
                      initialValue: _formData['avatarUrl'],
                      decoration:
                          const InputDecoration(labelText: 'URL do Avatar'),
                      onSaved: (value) => _formData['avatarUrl'] = value ?? '')
                ],
              ),
            )));
  }
}
