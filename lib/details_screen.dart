import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/main.dart';

class DetailsScreen extends StatefulWidget {
  final Food product;

  DetailsScreen(this.product);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 420,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
                child: Column(
                  children: <Widget>[
                     Container(
                        margin: EdgeInsets.only(bottom: 30),
                        padding: EdgeInsets.only(right: 6, left: 6, bottom: 6),
                        height: 305,
                        width: 305,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: kSecondaryColor,
                        ),
                        child: Container(
                          child: Hero(
                            tag: widget.product.image,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage(widget.product.image),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${widget.product.title}\n",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                TextSpan(
                                  text: "With red tomato",
                                  style: TextStyle(
                                    color: kTextColor.withOpacity(.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "\$20",
                            style: Theme.of(context)
                                .textTheme
                                .headline
                                .copyWith(color: kPrimaryColor),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                ),
              ),
              SizedBox(height: 400,),
              Padding(
                padding: EdgeInsets.only(bottom: 30, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                      decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(.19),
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Add to bag",
                            style: Theme.of(context).textTheme.button,
                          ),
                          SizedBox(width: 30),
                          SvgPicture.asset(
                            "assets/icons/forward.svg",
                            height: 11,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor.withOpacity(.26),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(15),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: SvgPicture.asset("assets/icons/bag.svg"),
                          ),
                          Positioned(
                            right: 15,
                            bottom: 10,
                            child: Container(
                              alignment: Alignment.center,
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kWhiteColor,
                              ),
                              child: Text(
                                "0",
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .copyWith(color: kPrimaryColor, fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ])
          )
          // SliverToBoxAdapter(
          //   child: ListView(
          //     children: <Widget>[
          //       Text('data1'),
          //       SizedBox(height: 40,),
          //       Text('data2'),
          //     ],
          //   )
          // ),
        ],
      )

        // Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 10),
        //   child: Column(
        //     children: <Widget>[
        // _appbar(),
        //       Expanded(
        //         child: SingleChildScrollView(
        //           child: Column(
        //             children: <Widget>[
                      // Container(
                      //   margin: EdgeInsets.only(bottom: 30),
                      //   padding: EdgeInsets.only(right: 6, left: 6, bottom: 6),
                      //   height: 305,
                      //   width: 305,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: kSecondaryColor,
                      //   ),
                      //   child: Container(
                      //     child: Hero(
                      //       tag: widget.product.image,
                      //       child: Image(
                      //         fit: BoxFit.cover,
                      //         image: AssetImage(widget.product.image),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: <Widget>[
                      //     RichText(
                      //       text: TextSpan(
                      //         children: [
                      //           TextSpan(
                      //             text: "${widget.product.title}\n",
                      //             style: Theme.of(context).textTheme.title,
                      //           ),
                      //           TextSpan(
                      //             text: "With red tomato",
                      //             style: TextStyle(
                      //               color: kTextColor.withOpacity(.5),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     Text(
                      //       "\$20",
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .headline
                      //           .copyWith(color: kPrimaryColor),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(height: 20),
                      // Text(
                      //   "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.",
                      // ),
                      // Spacer(),
                      // Padding(
                      //   padding: EdgeInsets.only(bottom: 30),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: <Widget>[
                      //       Container(
                      //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 27),
                      //         decoration: BoxDecoration(
                      //           color: kPrimaryColor.withOpacity(.19),
                      //           borderRadius: BorderRadius.circular(27),
                      //         ),
                      //         child: Row(
                      //           children: <Widget>[
                      //             Text(
                      //               "Add to bag",
                      //               style: Theme.of(context).textTheme.button,
                      //             ),
                      //             SizedBox(width: 30),
                      //             SvgPicture.asset(
                      //               "assets/icons/forward.svg",
                      //               height: 11,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         height: 80,
                      //         width: 80,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           color: kPrimaryColor.withOpacity(.26),
                      //         ),
                      //         child: Stack(
                      //           alignment: Alignment.center,
                      //           children: <Widget>[
                      //             Container(
                      //               padding: EdgeInsets.all(15),
                      //               height: 60,
                      //               width: 60,
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 color: kPrimaryColor,
                      //               ),
                      //               child: SvgPicture.asset("assets/icons/bag.svg"),
                      //             ),
                      //             Positioned(
                      //               right: 15,
                      //               bottom: 10,
                      //               child: Container(
                      //                 alignment: Alignment.center,
                      //                 height: 28,
                      //                 width: 28,
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: kWhiteColor,
                      //                 ),
                      //                 child: Text(
                      //                   "0",
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .button
                      //                       .copyWith(color: kPrimaryColor, fontSize: 16),
                      //                 ),
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}

class _appbar extends StatelessWidget {
  const _appbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/backward.svg",
              height: 11,
            ),
          ),
          SvgPicture.asset(
            "assets/icons/menu.svg",
            height: 8,
          ),
        ],
      ),
    );
  }
}
