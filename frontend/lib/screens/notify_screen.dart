import 'package:flutter/material.dart';
import 'package:sus_app/colors/colors.dart';

class NotifyScreen extends StatelessWidget {
  const NotifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Notification',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 2,
            ),
            const Text(
              'Mùa Hè Xanh 2022',
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                  'Bạn đã được chấp nhận tham gia vào chiến dịch Mùa Hè Xanh 2022!',
                  style: TextStyle(
                    fontSize: 15,
                    color: secondaryColor,
                  )),
            ),
            const Divider(
              thickness: 2,
            ),
            const Text(
              'Chiến dịch dọn rác sông Hồng',
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                  'Bạn đã bị từ chối tham gia chiến dịch dọn rác sông Hồng!',
                  style: TextStyle(
                    fontSize: 15,
                    color: secondaryColor,
                  )),
            ),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
