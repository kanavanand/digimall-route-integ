import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prachar/application/auth/authentication/authentication_bloc.dart';
import 'package:prachar/presentation/core/strings.dart';
import 'package:share/share.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prachar/constants/constants.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = context.read<AuthenticationBloc>().state.storeUser.store.id;
    String name = context.read<AuthenticationBloc>().state.storeUser.store.name;
    String dynamicLinkUrl =
        context.read<AuthenticationBloc>().state.storeUser.store.dynamicLinkUrl;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            LINK_TO_YOUR_STORE,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[100],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    dynamicLinkUrl,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: dynamicLinkUrl));
                        Fluttertoast.showToast(msg: COPIED_TO_CLIPBOARD);
                      },
                      child: const Icon(
                        Icons.copy_outlined,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Share.share(
                            'Hi  \n Checkout $name webstore and order online on the app.\nClick on- \n $dynamicLinkUrl');
                      },
                      child: const Icon(
                        Icons.share_outlined,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
