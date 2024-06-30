import 'package:Busnow/views/components/bottom_nav.dart';
import 'package:Busnow/views/notification_page/detail_notif.dart';
import 'package:Busnow/views/notification_page/item_notif.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNotificationPage extends StatefulWidget {
  const ListNotificationPage({Key? key}) : super(key: key);

  @override
  State<ListNotificationPage> createState() => _ListNotificationPageState();
}

class _ListNotificationPageState extends State<ListNotificationPage> {
  String formattedDate =
      DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEEE7E7),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xFF75F6F6),
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notification',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10, // Replace with actual item count
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        NotificationItem(
                          kota: 'Tiket Kota ke Kota',
                          time: '${formattedDate} \n00:00 - 00:00',
                          agen: 'Agen bus',
                          payment: 200000,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(currentPage: 'notification'),
      ),
    );
  }
}
