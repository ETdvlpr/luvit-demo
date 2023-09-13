import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:luvit/core/models/profile.dart';
import 'package:luvit/shared/theme/app_theme.dart';
import 'package:luvit/shared/theme/custom_icons.dart';
import 'package:luvit/ui/widgets/gradient_icon.dart';
import 'package:luvit/ui/widgets/like_button.dart';
import 'package:luvit/ui/widgets/selected_image_indicator.dart';
import 'package:luvit/ui/widgets/profile/tags.dart';

class ProfileCard extends StatefulWidget {
  final double width;
  final double height;
  final Profile profile;

  ProfileCard({
    Key? key,
    double? width,
    double? height,
    required this.profile,
  })  : width = width ?? 340.w,
        height = height ?? 600.h,
        super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Stack(
            children: [
              _buildBackgroundImage(),
              _buildBlackGradientOverlay(),
              _buildProfileInformation(),
              Positioned(
                left: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (imageIndex > 0) {
                        imageIndex--;
                      }
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 160.w,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (imageIndex < widget.profile.images.length - 1) {
                        imageIndex++;
                      }
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 160.w,
                    height: 100,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: widget.width,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.white245,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 24,
                bottom: 60,
                child: LikeButton(),
              ),
              _buildNavigationIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    final String imageSource = widget.profile.images[imageIndex];
    print("imageSource: $imageSource");
    Widget imageWidget;

    if (imageSource.startsWith("data:")) {
      final bytes =
          Uint8List.fromList(base64.decode(imageSource.split(',')[1]));
      imageWidget = Image.memory(bytes, fit: BoxFit.fill);
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: imageSource,
        fit: BoxFit.fill,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }

    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: imageWidget,
        ),
      ),
    );
  }

  Widget _buildBlackGradientOverlay() {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, 1.00),
            end: Alignment(0, -1),
            colors: [Colors.black, Colors.black.withOpacity(0)],
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.50, color: Color(0xFF3A3A3A)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInformation() {
    return Positioned(
      left: 24,
      bottom: 60,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLikeCount(),
          const SizedBox(height: 4),
          // Name and age
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: 230.w),
                child: Text(
                  widget.profile.name,
                  style: AppTheme.headline3BoldStyle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${widget.profile.age}',
                style: AppTheme.headline4ThinStyle,
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Profile description or tags
          Container(
            width: 240,
            child: DefaultTextStyle(
              child: (imageIndex == 0)
                  ? Text(widget.profile.location ?? '')
                  : (imageIndex == 1)
                      ? Text(widget.profile.description ?? '')
                      : ProfileTags(profile: widget.profile),
              style: AppTheme.thinTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLikeCount() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientIcon(
            CustomIcons.star,
            LinearGradient(
              begin: Alignment(0.44, -0.90),
              end: Alignment(-0.44, 0.9),
              colors: [Color(0xFF0F0F0F), Color(0xFF2E2E2E)],
            ),
            size: 15,
          ),
          const SizedBox(width: 2),
          Text(
            NumberFormat('###,###,###,###').format(widget.profile.likeCount),
            style: AppTheme.regularTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationIndicator() {
    return Positioned(
      left: 20,
      top: 16,
      child: SelectedImageIndicator(
        selectedIndex: imageIndex,
        itemCount: widget.profile.images.length,
        // onItemSelected: (index) {
        //   setState(() {
        //     imageIndex = index;
        //   });
        // },
      ),
    );
  }
}
