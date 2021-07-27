import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 3, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(18, 15, 18, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SkeletonAnimation(
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.2),
                                shimmerDuration: 3550,
                                borderRadius: BorderRadius.circular(5),
                                child: const Text('   ',
                                    style: TextStyle(
                                      fontSize: 16,
                                    )),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Visibility(
                                visible: index.isEven,
                                child: SkeletonAnimation(
                                  gradientColor: Colors.white38,
                                  shimmerColor: Colors.grey.withOpacity(0.4),
                                  shimmerDuration: 3980,
                                  borderRadius: BorderRadius.circular(5),
                                  child: const Text('   ',
                                      style: TextStyle(
                                        fontSize: 16,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SkeletonAnimation(
                                gradientColor: Colors.white38,
                                shimmerColor: Colors.grey.withOpacity(0.5),
                                shimmerDuration: 4360,
                                borderRadius: BorderRadius.circular(5),
                                child: Text('   ',
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).hintColor)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.article_outlined,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.6),
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.6),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.access_time_outlined,
                                        color: Theme.of(context)
                                            .hintColor
                                            .withOpacity(0.6),
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 40,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.comment_outlined,
                                        size: 21,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.color
                                            ?.withOpacity(0.7),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary:
                                            Theme.of(context).cardTheme.color,
                                        onPrimary:
                                            Theme.of(context).accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Container(
                                    width: 50,
                                    height: 40,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Icon(
                                        Icons.share_outlined,
                                        size: 21,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.color
                                            ?.withOpacity(0.7),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary:
                                            Theme.of(context).cardTheme.color,
                                        onPrimary:
                                            Theme.of(context).accentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
