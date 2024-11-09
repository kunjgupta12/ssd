import 'package:flutter/material.dart';
import 'package:upskill/blogs.dart';
import 'package:upskill/profile.dart';
import 'package:upskill/public_forum.dart';
import 'package:upskill/reffer.dart';

Future<void> customShowDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Stack(children: [
          Positioned(
            top: 510,
            left: 100,
            child: Dialog(
              alignment: Alignment.bottomRight,
              clipBehavior: Clip.hardEdge,
              elevation: 2,
              backgroundColor: Color.fromARGB(255, 43, 26, 93),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'My Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Image.asset('assets/arrow.png'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => blog()));
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Blogs',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Image.asset('assets/arrow.png'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => refer()));
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Refer and Earn',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset('assets/arrow.png'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => publicforum()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Public Forum',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Image.asset('assets/arrow.png'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]);
      });
}
