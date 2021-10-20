import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gemography_test/domain/models/git_repo.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GitRepoTile extends StatelessWidget {
  final GitRepo repo;

  const GitRepoTile({Key key, this.repo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            repo.name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.headline1.copyWith(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(repo.description ?? "No Description",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.caption.copyWith(height: 1.3, fontSize: 16)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedNetworkImage(
                      imageUrl: repo.owner.avatarUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Text(
                        repo.owner.login,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_purple500_outlined,
                    color: Get.theme.primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(conpactCount(repo.stargazersCount))
                ],
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }


  conpactCount(int starCount) {
    var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(starCount);
    return _formattedNumber;
  }
}

