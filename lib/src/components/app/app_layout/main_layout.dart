import 'package:flutter/material.dart';
import 'package:smart_sense/src/config/constant/app_colors.dart';

import '../../../modules/profile/profile.dart';

class MainLayout extends StatelessWidget {
  final Widget? drawer;
  final Widget? bootomNavigationBar;
  final List<Widget>? actions;
  final Widget body;
  

  const MainLayout(
      {Key? key, required this.body, this.bootomNavigationBar, this.drawer, this.actions,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(''),
            // IconButton(onPressed: (){
            //   //  Navigator.of(context).pushNamed('/filterForm');
                
            // }, icon: Icon(Icons.search,color: Colors.black,)),
         Text('SmartSense',style: TextStyle(color: Colors.black),),
        //  IconButton(onPressed: (){
            
        //  }, icon: Icon(Icons.filter_alt,color: Colors.black,)),
        HumbergerIconButton(),
          ],
        ),
      //  leading: drawer != null ? const LeadingIcon() : Container(),
    //  leading: Icon(Icons.search),
        actions: actions,
      ),

      body: body,
      bottomNavigationBar: bootomNavigationBar,
    );
  }
}

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    );
  }
}


class HumbergerIconButton extends StatelessWidget {
  const HumbergerIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(right: 18),
        child:
         
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child:  GestureDetector(
                onTap: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const Profile())));
                },
                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: whiteColor,
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(13),
                                      child: Image.asset(
                                        'assets/images/person.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
              )
            ),
        
      );
    });
  }
}
