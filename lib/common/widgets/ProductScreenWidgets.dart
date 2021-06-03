import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String imgUrl;
  final List imgList;
  final int currentIndex;
  PageController controller = PageController();
  CarouselController buttonCarouselController = CarouselController();

  var currentPageValue = 0.0;

  FullScreenImage({Key key, this.imgUrl, this.imgList, this.currentIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Center(
              child: PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              buttonCarouselController.animateToPage(index);
            },

            itemBuilder: (context, position) {
              return InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: imgList[position],
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
            itemCount: imgList.length, // Can be null
          )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              child: CarouselSlider(
                  carouselController: buttonCarouselController,
                  items: imgList.map((e) {
                    return CachedNetworkImage(
                      imageUrl: e,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: 80,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.2,
                    initialPage: currentIndex,
                    enableInfiniteScroll: false,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (index, _) {
                      controller.animateToPage(index,
                          duration: Duration(milliseconds: 800), curve: Curves.ease);
                    },
                    scrollDirection: Axis.horizontal,
                  ))
              // child: Carousel(
              //   autoplay: false,
              //   dotSize: 3.0,

              //   boxFit: BoxFit.scaleDown,
              //   images: imgList.map((e) {
              //     return CachedNetworkImage(
              //       imageUrl: e,
              //       errorWidget: (context, url, error) => Icon(Icons.error),
              //     );
              //   }).toList(),
              // ),
              ),
        )
      ],
    ));
  }
}
