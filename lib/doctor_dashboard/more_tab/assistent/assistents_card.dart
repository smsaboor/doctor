import 'package:doctor/dashboard_patient/widgets/avatar_image.dart';
import 'package:flutter/material.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.white),
        ),
        child: InkWell(
            onTap: () {
              // Scaffold.of(context).showSnackBar(SnackBar(
              //     content: Text(
              //       "Selected Ite",
              //       style: TextStyle(
              //         fontSize: 16.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     )));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: AvatarImagePD(
                          "https://images.unsplash.com/photo-1537368910025-700350fe46c7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80",
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
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
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
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
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
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
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
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
                  Divider(
                    color: Colors.black12,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
