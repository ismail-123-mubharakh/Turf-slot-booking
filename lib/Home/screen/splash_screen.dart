import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:slot_booking_app/Home/view_model/venue_list_view_model.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<VenueListViewModel>().navigateToLoginScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child: Container(
            height: 162,
            width: 174,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(
                "assets/images/soccer-field.png"
            ),
          ),
        )
    );
  }
}