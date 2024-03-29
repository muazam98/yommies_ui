import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/models/rewardDetail.dart';
import 'package:yommie/models/rewardModels.dart';
import 'package:yommie/pages/detail_reward.dart';

class RewardPage extends StatefulWidget {
  final String userId;
  RewardPage({this.userId});

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<Reward> listRewards = [];
  List<Widget> itemList = [];
  List<Widget> itemListFreegift = [];
  List<ProductReward> listProductReward = [];
  List<FreegiftReward> listFreegift = [];

  bool loading = false;
  bool showLoading = false;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    callApi();
    super.initState();
  }

  callApi() {
    var jsons = {};
    RewardModels().rewardUserPhp(jsons, context).then((value) {
      setState(() {
        listRewards = value == null ? [] : value;
        loading = false;
      });
    });
  }

  getMyProduct(response) {
    List product = response["product"] == null ? [] : response["product"];
    List freegift = response["freegift"] == null ? [] : response["freegift"];
    for (var u in product) {
      ProductReward item = ProductReward(
          u["id"],
          u["reward_id"],
          u["product_id"],
          u["quantity"],
          u["product_code"],
          u["product_name"],
          u["photo"]);
      listProductReward.add(item);
    }

    for (var u in freegift) {
      FreegiftReward item = FreegiftReward(
          u["id"],
          u["reward_id"],
          u["freegift"],
          u["quantity"],
          u["freegift_code"],
          u["freegift_name"],
          u["photo"]);
      listFreegift.add(item);
    }
    addListProductReward();
  }

  addListProductReward() {
    addlistProduct();
    addlistFreegift();
  }

  addlistProduct() {
    listProductReward.forEach((ProductReward item) {
      itemList.add(
        Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: false,
                    imageUrl:
                        "https://yomies.com.my/pages/product/photo/${item.photo}",
                    errorWidget: (context, url, error) {
                      return Image(
                        image: AssetImage("assets/images/news1.jpg"),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Quantity : " + item.quantity,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  addlistFreegift() {
    listFreegift.forEach((FreegiftReward item) {
      itemListFreegift.add(
        Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    useOldImageOnUrlChange: false,
                    imageUrl:
                        "https://yomies.com.my/pages/freegift/photo/${item.photo}",
                    errorWidget: (context, url, error) {
                      return Image(
                        image: AssetImage("assets/images/news1.jpg"),
                      );
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.freegiftName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Quantity : " + item.quantity,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
    setState(() {
      showLoading = false;
    });
  }

  @override
  void dispose() {
    listRewards.clear();
    itemList.clear();
    listProductReward.clear();
    itemListFreegift.clear();
    listFreegift.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            color: Theme.of(context).primaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.3,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/yomiesKL.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: listRewards.length != 0
              ? ListView.builder(
                  itemCount: listRewards == null ? 0 : listRewards.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = listRewards[index];
                    return GestureDetector(
                      onTap: () {
                        if (!showLoading) {
                          setState(() {
                            showLoading = true;
                          });
                          itemListFreegift.clear();
                          listFreegift.clear();
                          itemList.clear();
                          listProductReward.clear();
                          var jsons = {};
                          jsons["id"] = item.id;
                          RewardDetailModel()
                              .rewardDetailPhp(jsons, context)
                              .then((value) {
                            getMyProduct(value);
                            _detailsReward(value, context, item.endDate);
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 200,
                        width: double.infinity,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 20),
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                item.status != "LOCK"
                                    ? Container(
                                        width: double.infinity,
                                        height: 25,
                                        child: Text(
                                          "Unlock at ${item.point} Points",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    : Container(
                                        width: double.infinity,
                                        height: 25,
                                        child: Text(
                                          "Unlock at ${item.point} Points",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          useOldImageOnUrlChange: false,
                                          imageUrl:
                                              "https://yomies.com.my/pages/reward/photo/${item.photo}",
                                          errorWidget: (context, url, error) {
                                            return Image(
                                              image: AssetImage(
                                                  "assets/images/news1.jpg"),
                                            );
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.reward,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.tnc,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Expired date : " + item.endDate,
                                              style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                      SizedBox(width: 10)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                item.status != "LOCK" &&
                                        item.status != "FULLY REDEEM"
                                    ? Container(
                                        height: 30,
                                        width: 220,
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              var userId =
                                                  prefs.getString('userId');
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  type: PageTransitionType
                                                      .bottomToTop,
                                                  child: DetailReward(
                                                    userId: userId,
                                                    rewardId: item.id,
                                                  ),
                                                ),
                                              ).then((value) {
                                                callApi();
                                              });
                                            },
                                            child: Text(
                                              "REDEEM AT COUNTER",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      )
                                    : item.status != "FULLY REDEEM"
                                        ? SizedBox(
                                            height: 30,
                                            width: 120,
                                            child: RaisedButton(
                                              color: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () {
                                                DialogAction()
                                                    .alertDialogOneButton(
                                                        context,
                                                        item.message,
                                                        CoolAlertType.info,
                                                        item.reason,
                                                        'Ok', () {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text(
                                                "Redeem",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 30,
                                            width: 160,
                                            child: RaisedButton(
                                              color: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              onPressed: () {
                                                DialogAction()
                                                    .alertDialogOneButton(
                                                        context,
                                                        item.message,
                                                        CoolAlertType.info,
                                                        item.reason,
                                                        'Ok', () {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: Text(
                                                "Fully Redeem",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    "Stay tunes upcoming rewards...",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, letterSpacing: 3),
                  ),
                ),
        ),
      );
    }
  }

  void _detailsReward(response, context, endDate) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.50,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height: ResponsiveFlutter.of(context).verticalScale(120),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Reward ".toUpperCase() +
                          response["point"] +
                          " points",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              useOldImageOnUrlChange: false,
                              imageUrl:
                                  "https://yomies.com.my/pages/reward/photo/${response["photo"]}",
                              errorWidget: (context, url, error) {
                                return Image(
                                  image: AssetImage("assets/images/news1.jpg"),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  response["reward"],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  response["sub_title"],
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Expired date : " + endDate,
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 30),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              SizedBox(height: 10),
              response["product"] != null
                  ? Text(
                      "Your rewards drinks",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey),
                    )
                  : SizedBox(),
              response["product"] != null
                  ? Column(
                      children: itemList,
                    )
                  : SizedBox(),
              response["product"] != null
                  ? SizedBox(height: 20)
                  : SizedBox(height: 0),
              response["freegift"] != null
                  ? Text(
                      "Freegift",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.grey),
                    )
                  : SizedBox(),
              response["freegift"] != null
                  ? Column(
                      children: itemListFreegift,
                    )
                  : SizedBox(),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
