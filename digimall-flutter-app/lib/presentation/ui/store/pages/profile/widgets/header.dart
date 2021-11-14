import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/ui/store/pages/profile/user_profile.dart';

class ProfileHeader extends StatelessWidget {
  final UserProfileType userProfileType;
  const ProfileHeader({
    Key key,
    @required this.userProfileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final image = userProfileType == UserProfileType.user
        ? context.read<AuthenticationBloc>().state?.storeUser?.image ?? ''
        : context.read<AuthenticationBloc>().state?.storeUser?.store?.image ??
            '';
    final name = userProfileType == UserProfileType.user
        ? context.read<AuthenticationBloc>().state?.storeUser?.name ??
            "Buyer's Name"
        : context.read<AuthenticationBloc>().state?.storeUser?.store?.name ??
            "Buyer's Name";
    return Row(
      children: [
        if (image.isNotEmpty)
          Image.network(
            image,
            height: 80,
            width: 120,
          )
        else
          Image.network(
            "https://i.pinimg.com/originals/77/c3/66/77c366436d8bd35fe8b3ce5b8c66992e.png",
            height: 80,
            width: 120,
          ),
        const SizedBox(
          width: 15,
        ),
        Text(
          name ?? "Buyer's Name",
          style: const TextStyle(
            color: Kolors.PrimaryColorDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
