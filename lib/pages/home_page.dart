import 'package:flutter/material.dart';
import 'package:pa3/pages/authentication/login.dart';
import 'package:pa3/pages/budidaya/pilihtanaman_budidaya_page.dart';
import 'package:pa3/pages/catatan/catatan_page.dart';
import 'package:pa3/pages/hama/pilihhamatanaman.dart';
import 'package:pa3/pages/post_screen.dart';
import 'package:pa3/service/user_service.dart';

class HomePage extends StatelessWidget {
  // Creating static data in lists
  List<String> menu = [
    "Budidaya Tanaman",
    "Hama dan Penyakit",
    "Catatan",
    "Komunitas",
  ];

  List<Color> menuColors = [
    Color(0xFFFFCF2F),
    Color.fromARGB(255, 84, 243, 132),
    Color.fromARGB(255, 85, 174, 246),
    Color.fromARGB(255, 222, 112, 242),
  ];

  List<Icon> menuIcons = [
    Icon(Icons.agriculture, color: Colors.white, size: 30),
    Icon(Icons.bug_report, color: Colors.white, size: 30),
    Icon(Icons.create, color: Colors.white, size: 30),
    Icon(Icons.group, color: Colors.white, size: 30),
  ];

  List<String> imgList = [
    'Jagung',
    'Bawang Merah',
    'Tomat',
    'Kacang Tanah',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              logout().then((value) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) =>
                          Login()), // Replace LoginPage with your actual login page widget
                  (Route<dynamic> route) => false,
                );
              });
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 40, 179, 112),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3, bottom: 15),
                  child: Text(
                    "Hi",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      wordSpacing: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here...",
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 25,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              children: [
                GridView.builder(
                  itemCount: menu.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Handle navigation here based on the tapped item
                        if (menu[index] == "Budidaya Tanaman") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PilihtanamanBudidayaPage()),
                          );
                        } else if (menu[index] == "Hama dan Penyakit") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Pilihhamatanaman()),
                          );
                        } else if (menu[index] == "Catatan") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CatatanPage()),
                          );
                        } else if (menu[index] == "Komunitas") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostScreen()),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              color: menuColors[index],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: menuIcons[index],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            menu[index],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tanaman",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF674AEF),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GridView.builder(
                  itemCount: imgList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        (MediaQuery.of(context).size.height - 50 - 25) /
                            (4 * 240),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/${imgList[index]}.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              imgList[index],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
