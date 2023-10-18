import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sibcode_test/pages/profile/cubit/profile_cubit.dart';
import 'package:sibcode_test/pages/profile/cubit/profile_state.dart';
import 'package:sibcode_test/route_names.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.goNamed(RouteNames.listNews);
            },
          ),
        ),
        body: BlocProvider(
            create: (context) => ProfileCubit(), child: const ProfileContent()),
      ),
    );
  }
}

class ProfileContent extends StatefulWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).loading();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Номер телефона',
            style: TextStyle(fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 32),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is Content) {
                  return Text(
                    state.phoneNumber ?? '',
                    style: const TextStyle(fontSize: 16),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              profileCubit.delete(context);
            },
            style: ElevatedButton.styleFrom(fixedSize: const Size(150, 20)),
            child: const Text('Выход'),
          ),
        ],
      ),
    );
  }
}