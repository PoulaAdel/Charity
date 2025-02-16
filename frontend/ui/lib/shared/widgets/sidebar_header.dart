import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../constants/app_constants.dart';

class SidebarHeaderData {
  final ImageProvider projectImage;
  final String projectName;
  final DateTime releaseTime;

  const SidebarHeaderData({
    required this.projectImage,
    required this.projectName,
    required this.releaseTime,
  });
}

class SidebarHeaderCard extends StatelessWidget {
  const SidebarHeaderCard({
    required this.data,
    Key? key,
  }) : super(key: key);

  final SidebarHeaderData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ProgressIndicator(
          center: _ProfilImage(image: data.projectImage),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TitleText(data.projectName),
              const SizedBox(height: 5),
              Wrap(
                children: [
                  const _SubtitleText("Date: "),
                  _ReleaseTimeText(data.releaseTime)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

/* -----------------------------> COMPONENTS <------------------------------ */
class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({
    required this.center,
    Key? key,
  }) : super(key: key);

  final Widget center;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 55,
      lineWidth: 2.0,
      center: center,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}

class _ProfilImage extends StatelessWidget {
  const _ProfilImage({required this.image, Key? key}) : super(key: key);

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: image,
      radius: 52,
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.data, {Key? key}) : super(key: key);

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data.capitalize!,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _SubtitleText extends StatelessWidget {
  const _SubtitleText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(fontSize: 11),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ReleaseTimeText extends StatelessWidget {
  const _ReleaseTimeText(this.date, {Key? key}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kNotifColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: Text(
        DateFormat.yMMMd().format(date),
        style: const TextStyle(fontSize: 9),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
