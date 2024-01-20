// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:auto_pond_app/presentation/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AutoPondPageView extends StatefulWidget {
  const AutoPondPageView({super.key});

  @override
  State<AutoPondPageView> createState() => _AutoPondPageViewState();
}

class _AutoPondPageViewState extends State<AutoPondPageView> {
  final controller = Get.put(AutoPondController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        centerTitle: false,
        title: const Text(
          'Automated Pond',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GetBuilder<AutoPondController>(
        init: AutoPondController(),
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 30,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      _dataCard(
                        iconData: Icons.device_thermostat_rounded,
                        iconColor: Colors.red[400],
                        title: "Temperature (F)",
                        value: controller.temperature,
                      ),
                      const SizedBox(height: 60),
                      _dataCard(
                        iconData: Icons.water_drop_outlined,
                        iconColor: Colors.blue[500],
                        title: "TDS (ppm)",
                        value: controller.tds,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                controller.isPumpingIn == true ||
                        controller.isPumpingOut == true
                    ? _showPumping(controller.isPumpingIn)
                    : TextButton(
                        onPressed: () {
                          print('Custom Button pressed');
                          controller.mqttPublish("CW");
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade900,
                          fixedSize: Size(size.width / 2.5, 50),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Change Water",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _showPumping(bool isIn) {
    return Container(
      width: 300,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isIn ? Colors.teal : Colors.amber,
      ),
      child: Center(
        child: Text(
          isIn ? "Pumping in <<<" : "Pumping out >>>",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _dataCard({
    required IconData? iconData,
    required Color? iconColor,
    required String? title,
    var value,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: iconColor,
              ),
              Text(
                title ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            value == null ? "No data yet" : value.toString(),
            style: TextStyle(
              fontSize: value == null ? 15 : 45,
              fontWeight: FontWeight.w600,
              color: value == null ? Colors.black54 : Colors.black,
            ),
          ),
        ],
      ),
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     SizedBox(
    //       child: Row(
    //         children: [
    //           const Text(
    //             'Last time updated: ',
    //             style: TextStyle(
    //               fontSize: 15,
    //               fontWeight: FontWeight.w600,
    //               color: Colors.black54,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Text(
    //       value ?? "No data yet",
    //       style: TextStyle(
    //         fontSize: 15,
    //         fontWeight: FontWeight.w600,
    //         color: value == null ? Colors.black54 : Colors.black,
    //       ),
    //     ),
    //   ],
    // );
  }
}
