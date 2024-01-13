import 'package:flutter/material.dart';
import 'package:ride_sharing_user_app/util/dimensions.dart';
import 'package:ride_sharing_user_app/util/images.dart';
import 'package:ride_sharing_user_app/util/styles.dart';
import 'package:ride_sharing_user_app/view/widgets/weather_assistant.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Function()? onBackPressed;
  final Function()? onTap;
  final bool regularAppbar;
  const CustomAppBar({super.key, required this.title, this.showBackButton = true, this.onBackPressed, this.onTap,  this.regularAppbar = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: regularAppbar? 100 : 150,
      color: Theme.of(context).primaryColor,
      child: AppBar(
        title: Text(title, style: textSemiBold.copyWith(
          fontSize: Dimensions.fontSizeExtraLarge,
          color: Colors.white,
        )),
        centerTitle: true,
        leading: showBackButton ? IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => onBackPressed != null ? onBackPressed!() : Navigator.pop(context),
        ) :
        SizedBox(
          width: Dimensions.iconSizeMedium,
          child: InkWell(
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Image.asset(Images.menuIcon, color: Colors.white,
                  width: Dimensions.iconSizeMedium),
            ),
          ),
        ),
        actions: [
          InkWell(
            highlightColor: Colors.transparent,
            onTap: (){
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                transitionDuration: const Duration(milliseconds: 500),
                barrierLabel: MaterialLocalizations.of(context).dialogLabel,
                barrierColor: Colors.black.withOpacity(0.5),
                pageBuilder: (context, _, __) {
                  return const WeatherAssistant();
                },
                transitionBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ).drive(Tween<Offset>(
                      begin: const Offset(0, -1.0),
                      end: Offset.zero,
                    )),
                    child: child,
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeExtraLarge),
              child: Image.asset(Images.weatherIcon, width: Dimensions.iconSizeMedium,),
            ),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, Dimensions.appBarHeight);
}