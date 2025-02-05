import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactButtons extends StatelessWidget {
  const ContactButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildContactButton(
          image: Images.phoneOrderDetails,
          color: Colors.teal,
          title: "call_enquiry".tr,
          label: "click_here_to_call".tr,
          isPhone: true,
          onTap: () => _makePhoneCall('tel:+917809687533'),
        ),
        _buildContactButton(
          image: Images.whatsappIcon,
          color: Colors.green,
          title: "WhatsApp_Us".tr,
          label: "click_here_to_chat".tr,
          isPhone: false,
          onTap: () => _openWhatsApp('+917809687533'),
        ),
      ],
    );
  }

  Widget _buildContactButton({
    required String image,
    required Color color,
    required String label,
    required VoidCallback onTap,
    required String title,
    required bool isPhone
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: isPhone ?  25 : 30, width: isPhone ? 25 : 30,fit: BoxFit.fill),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri url = Uri.parse(phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not launch $phoneNumber');
    }
  }

  void _openWhatsApp(String phoneNumber) async {
    final Uri url = Uri.parse('https://wa.me/$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint('Could not open WhatsApp for $phoneNumber');
    }
  }
}
