import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pay_mobile_web_admin/core/utils/assets.dart';
import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/validators.dart';
import 'package:pay_mobile_web_admin/features/notifications/services/notifications_services.dart';
import 'package:pay_mobile_web_admin/widgets/custom_button.dart';
import 'package:pay_mobile_web_admin/widgets/custom_textfield.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';
import 'package:pay_mobile_web_admin/widgets/width_space.dart';

class SendPushNotificationsScreen extends StatefulWidget {
  const SendPushNotificationsScreen({super.key});

  @override
  State<SendPushNotificationsScreen> createState() =>
      _SendPushNotificationsScreenState();
}

class _SendPushNotificationsScreenState
    extends State<SendPushNotificationsScreen> {
  final NotificationServices notificationServices = NotificationServices();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final sendPushNotificationFormKey = GlobalKey<FormState>();

  void sendPushNotifications() {
    if (sendPushNotificationFormKey.currentState!.validate()) {
      notificationServices.sendPushNotificationToAllDevices(
        context: context,
        title: titleController.text,
        body: bodyController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.text;
    bodyController.text;
  }

  @override
  void initState() {
    super.initState();
    titleController.text = "Welcome";
    bodyController.text =
        "We are very excited to have you here with all of us at Pay Mobile";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: sendPushNotificationFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Send Push Notifications",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  HeightSpace(heightValue10),
                  const Text(
                      "Send push notifications to all registered users in the Pay Mobile app"),
                  CustomTextField(
                    hintText: "Title",
                    controller: titleController,
                    validator: validateField,
                    onChanged: (title) {
                      setState(() {});
                    },
                  ),
                  HeightSpace(heightValue10),
                  CustomTextField(
                    hintText: "Body",
                    controller: bodyController,
                    maxLines: 4,
                    validator: validateField,
                    onChanged: (body) {
                      setState(() {});
                    },
                  ),
                  CustomButton(
                      buttonText: "Send Now",
                      buttonTextColor: secondaryAppColor,
                      borderRadius: 30,
                      onTap: () {
                        sendPushNotifications();
                      }),
                  HeightSpace(10),
                  Stack(
                    children: [
                      Image.asset(
                        iphone,
                        height: 500,
                      ),
                      Positioned(
                        top: 65,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          width: 300,
                          height: 100,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: primaryAppColor,
                                                  ),
                                                  child: Center(
                                                    child: Image.asset(
                                                      invertedLogo,
                                                      height: 28,
                                                    ),
                                                  ),
                                                ),
                                                WidthSpace(10),
                                                const Text("Pay Mobile")
                                              ],
                                            ),
                                            const Text(
                                              "now",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          titleController.text,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        Text(
                                          bodyController.text,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
