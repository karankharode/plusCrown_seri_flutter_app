import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

CachedNetworkImage coverPageimageBuilder(url) {
    return CachedNetworkImage(
                imageUrl: url,
                placeholder: (BuildContext context, s) {
                  return Lottie.asset(
                    'assets/animations/imageLoader.json',
                    // width: 180,
                    height: 90,
                    fit: BoxFit.scaleDown,
                  );
                },
                errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.error),
                ),
              );
  }