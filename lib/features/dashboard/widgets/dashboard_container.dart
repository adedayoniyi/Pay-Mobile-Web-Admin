import 'package:flutter/material.dart';

import 'package:pay_mobile_web_admin/core/utils/color_constants.dart';
import 'package:pay_mobile_web_admin/core/utils/global_constants.dart';
import 'package:pay_mobile_web_admin/widgets/height_space.dart';

class DashboardContainer extends StatelessWidget {
  final Color color;
  final String title;
  final String mainData;
  final String topIcon;
  final Color topIconColor;
  final bool willContainRow;
  const DashboardContainer({
    Key? key,
    required this.color,
    required this.title,
    required this.mainData,
    required this.topIcon,
    required this.topIconColor,
    this.willContainRow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //height: 400,
        // width: 250,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(heightValue30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: topIconColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        topIcon,
                        height: 20,
                        color: secondaryAppColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: secondaryAppColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: topIconColor),
                    child: Center(
                      child: Image.asset(
                        topIcon,
                        height: 20,
                        color: secondaryAppColor,
                      ),
                    ),
                  ),
                ],
              ),
              willContainRow
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₦ ",
                          style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: secondaryAppColor,
                          ),
                        ),
                        Text(
                          amountFormatter.format(int.parse(mainData)),
                          style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.w800,
                            color: secondaryAppColor,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      amountFormatter.format(int.parse(mainData)),
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                        color: secondaryAppColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
