import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ppob_app/features/topup/presentation/pages/topupgame_satu.dart';

class TopUpGamePage extends StatelessWidget {
  const TopUpGamePage({super.key});

  final List<Map<String, dynamic>> gameItems = const [
    {'title': 'Mobile Legend', 'icon': 'assets/images/mobilelegend.png'},
    {'title': 'Free Fire', 'icon': 'assets/images/freefire.png'},
    {'title': 'PUBG Mobile', 'icon': 'assets/images/pubgmobile.png'},
    {'title': 'Call of Duty Mobile', 'icon': 'assets/images/codm.png'},
    {'title': 'Bigo Live', 'icon': 'assets/images/bigolive.png'},
    {'title': 'Point Blank', 'icon': 'assets/images/pointblank.png'},
    {'title': 'Valorant', 'icon': 'assets/images/valorant.png'},
    {'title': 'T3 Arena', 'icon': 'assets/images/t3arena.png'},
    {'title': 'Garena', 'icon': 'assets/images/garena.png'},
    {'title': 'Gemscool', 'icon': 'assets/images/gemscool.png'},
    {'title': 'Lineage2M', 'icon': 'assets/images/lineage2m.png'},
    {'title': 'War Robots', 'icon': 'assets/images/warrobots.png'},
    {'title': 'Once Human', 'icon': 'assets/images/oncehuman.png'},
    {'title': 'Airplane Chefs', 'icon': 'assets/images/airplanechefs.png'},
    {'title': 'Arena of Valor', 'icon': 'assets/images/arenaofvalor.png'},
    {'title': 'Crystal of Atlan', 'icon': 'assets/images/crystalofatlan.png'},
    {'title': 'Culinary Tour', 'icon': 'assets/images/culinarytour.png'},
    {'title': 'King Choice', 'icon': 'assets/images/kingchoice.png'},
    {'title': 'Wuthering Waves', 'icon': 'assets/images/wutheringwaves.png'},
    {'title': 'Honor of Kings', 'icon': 'assets/images/honorofkings.png'},
    {'title': 'Haikyu Fly High', 'icon': 'assets/images/haikyu.png'},
    {'title': 'Genshin Impact', 'icon': 'assets/images/genshinimpact.png'},
    {'title': 'Mirren Star Legends', 'icon': 'assets/images/mirrenstarlegends.png'},
    {'title': 'Dragon Nest M Classic', 'icon': 'assets/images/dragonnestmclassic.png'},
    {'title': 'Clash of Clans', 'icon': 'assets/images/clashofclans.png'},
    {'title': 'Ragnarok M Classic', 'icon': 'assets/images/ragnarokmclassic.png'},
    {'title': 'PUBG N.S.M', 'icon': 'assets/images/pubgnsm.png'},
    {'title': 'Ragnarok M.E.L', 'icon': 'assets/images/ragnarok.png'},
    {'title': 'Ragnarok M.W', 'icon': 'assets/images/ragnarokmw.png'},
    {'title': 'ML Adventure', 'icon': 'assets/images/mobilelegendadventure.png'},
    {'title': 'Rules of S.M', 'icon': 'assets/images/rulesofsm.png'},
    {'title': 'Steam Sea', 'icon': 'assets/images/steamsea.png'},
    {'title': 'The Lord of the R.R.T.W', 'icon': 'assets/images/lordoftherrtw.png'},
    {'title': 'Trails of Cold Steel NW', 'icon': 'assets/images/trailsofcoldsteel.png'},
    {'title': 'Free Fire Max', 'icon': 'assets/images/freefiremax.png'},
    {'title': 'League of Legends PC', 'icon': 'assets/images/lol.png'},
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 140.h,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.h,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 28.r),
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.w,
                  left: 24.w,
                  right: 24.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6.r,
                          offset: Offset(0, 3.h),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Top Up Game',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF5938FB),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Game Kamu',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    ),
                  ),
                  SizedBox(height: 0.1.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: gameItems.length,
                    itemBuilder: (context, index) {
                      return _buildGameItem(context, gameItems[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameItem(BuildContext context, Map<String, dynamic> item) {
    final dynamic iconData = item['icon'];
    Widget iconWidget;
    const double iconContainerSize = 56;
    const double iconPadding = 6;
    final double innerIconSize = iconContainerSize - (iconPadding * 2);

    if (iconData is String) {
      iconWidget = ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.asset(
          iconData,
          fit: BoxFit.cover,
          width: iconContainerSize.w,
          height: iconContainerSize.w,
        ),
      );
    } else if (iconData is IconData) {
      iconWidget = Icon(iconData, size: innerIconSize.w, color: Colors.grey[600]);
    } else {
      iconWidget = const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopUpGameSatu(
              gameTitle: item['title']!,
              gameIcon: item['icon'],
              gameItems: gameItems,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[300]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Center(
              child: iconWidget,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item['title']!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
