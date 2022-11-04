import 'package:doctor/core/avatar_image.dart';
import 'package:flutter/material.dart';
import 'package:doctor/core/constants/urls.dart';
class AssistentCard extends StatefulWidget {
  const AssistentCard({Key? key}) : super(key: key);

  @override
  _AssistentCardState createState() => _AssistentCardState();
}

class _AssistentCardState extends State<AssistentCard> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 180,
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.white),
        ),
        child: InkWell(
            onTap: () {
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: AvatarImagePD(
                          AppUrls.user,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Name:',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.pink,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '  Arjun Singh',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: const [
                                  Text(
                                    'Mobile:',
                                    style: TextStyle(
                                        color: Colors.pink,
                                        fontSize: 20,
                                        fontWeight:
                                        FontWeight.w500),
                                  ),
                                  Text(
                                    ' 9898989809,',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight:
                                        FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Status:',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '  Active',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Address:',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '  New Delhi',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.black12,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
