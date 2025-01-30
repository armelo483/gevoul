import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                'Notre site de carrière',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
              Expanded(
                  child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green, size: 16),
                  SizedBox(width: 5),
                  Text(
                    'Kribi, Cameroun',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ],
          ),
          Expanded(
              child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.notifications, color: Colors.black),
          )),
        ],
      ),
    );
  }
}
