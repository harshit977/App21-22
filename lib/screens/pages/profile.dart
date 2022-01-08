import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:techapp/providers/fetch_data_provider.dart';
import 'package:techapp/screens/components/style.dart';
import 'package:techapp/screens/layouts/page_layout.dart';
import 'package:techapp/widgets/sign_in_modal.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                if (FetchDataProvider.user != null)
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.amber, width: 5),
                                shape: BoxShape.circle),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(FetchDataProvider.user!.picture),
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Text(FetchDataProvider.user!.name,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                        Divider(
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DetailTile(
                            icon: Icons.email,
                            text: FetchDataProvider.user!.email),
                        if (FetchDataProvider.user!.onBoard)
                          DetailTile(
                              icon: Icons.school,
                              text: FetchDataProvider.user!.college!),
                        if (FetchDataProvider.user!.onBoard)
                          DetailTile(
                              icon: Icons.calendar_today,
                              text: FetchDataProvider.user!.year!),
                        if (FetchDataProvider.user!.onBoard)
                          DetailTile(
                              icon: Icons.phone,
                              text: FetchDataProvider.user!.phone!),
                      ],
                    ),
                  ),
                if (FetchDataProvider.user!.onBoard == false)
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'You cannot register for our events yet.\nClick on the button given below to signup for altius & start registering for our events.',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (FetchDataProvider.user!.onBoard == false)
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigoAccent,
                          onPrimary: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 25,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SignInModalWidget();
                            });
                      },
                      child: Text(
                        "SignUp For Altius",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ))
              ],
            )));
  }
}

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const DetailTile({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      elevation: 20,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        iconColor: Colors.amber[700],
        leading: Icon(this.icon),
        title: AutoSizeText(
          text,
          style: TextStyle(fontSize: 15, color: white),
          maxLines: 1,
        ),
      ),
    );
  }
}
