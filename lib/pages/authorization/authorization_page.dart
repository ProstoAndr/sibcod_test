import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sibcode_test/pages/authorization/cubit/authorization_cubit.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({super.key});

  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Авторизация'),
      ),
      body: BlocProvider(
        create: (_) => AuthorizationCubit(),
        child: AuthorizationContent(
          numberController: _numberController,
        ),
      ),
    );
  }
}

class AuthorizationContent extends StatefulWidget {
  final TextEditingController numberController;

  const AuthorizationContent({
    super.key,
    required this.numberController,
  });

  @override
  State<AuthorizationContent> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationContent> {
  final _authorizationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authorizationCubit = BlocProvider.of<AuthorizationCubit>(context);

    return Form(
      key: _authorizationKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 64, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Введите номер телефона',
                    prefixIcon: Icon(Icons.phone),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1))),
                keyboardType: TextInputType.phone,
                maxLength: 11,
                controller: widget.numberController,
                validator: _validatorNumber,
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_authorizationKey.currentState!.validate()) {
                      authorizationCubit.authorization(
                          widget.numberController.text, context);
                    }
                  },
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(150, 20)),
                  child: const Text('Вход'))
            ],
          ),
        ),
      ),
    );
  }

  String? _validatorNumber(String? value) {
    final fieldExp = RegExp(r'^[0-9]+');
    if (value == null || value.isEmpty) {
      return 'Введите номер телефона.';
    } else if (!fieldExp.hasMatch(value)) {
      return 'Введите только числа.';
    } else if (value == '911') {
      return 'Такой номер не допустим.';
    } else {
      return null;
    }
  }
}
