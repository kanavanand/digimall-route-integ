import 'dart:convert';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prachar/constants/configs.dart';
import 'package:prachar/constants/constants.dart';
import 'package:prachar/presentation/core/styles/colors.dart';
import 'package:prachar/presentation/routes/router.gr.dart';
import 'package:prachar/presentation/ui/order/order_page.dart';
import 'package:prachar/presentation/ui/products/products.dart';
import 'package:prachar/presentation/ui/store/pages/profile/user_profile.dart';
import 'package:prachar/services/local_notifications.dart';

import 'home/home_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with WidgetsBindingObserver {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final PageController _pagecontroller = PageController();
  Future<void> checkNotification() async {
    RemoteMessage message =
        await FirebaseMessaging.instance.getInitialMessage();
    print("message is $message");
    if (message != null &&
        message.data != null &&
        message.data.containsKey("content")) {
      final data = jsonDecode(message.data['content'] as String);
      if (data == null) {
        return;
      }
      print(data);
      final content = data['content'];
      final title = content['title'] as String;
      final body = content['body'] as String;
      final id = content['id'] as int;
      print("Message is");
      print(message.messageId);
      changeTab(2);
    }
  }

  void showForeGroundNotification() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('noti_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      log("Message Received");
      if (notification != null && android != null) {
        if (android.channelId != "new_order_noti") return;
        await flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: LocalNotification.new_order_notification_details,
          ),
        );
      }
    });
  }

  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkNotification();
    showForeGroundNotification();
    log("On Base Store Page");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkNotification();
      showForeGroundNotification();
    }
  }

  void changeTab(int index) {
    if (_pagecontroller.hasClients) {
      _pagecontroller.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInCubic,
      );
      setState(() {
        pageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Kolors.primaryColor,
        title: Text(
          APP_NAME,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: PageView(
        controller: _pagecontroller,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          ProductsPage(),
          OrderPage(),
          UserProfilePage(
            userProfileType: UserProfileType.store,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: onTap,
        items: [
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(Icons.home, size: 20, color: Colors.black45),
            label: "Home",
            backgroundColor: Kolors.primaryColor,
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.add_business,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(
              Icons.add_business,
              size: 20,
              color: Colors.black45,
            ),
            label: 'Products',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_bag_outlined,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 20,
              color: Colors.black45,
            ),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              size: 27,
              color: Kolors.PrimaryColorDark,
            ),
            icon: Icon(
              Icons.person,
              size: 20,
              color: Colors.black45,
            ),
            label: 'User',
          ),
        ],
      ),
    );
  }

  void onTap(int pageIndex) {
    _pagecontroller.animateToPage(pageIndex,
        duration: const Duration(microseconds: 200), curve: Curves.linear);
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }
}
