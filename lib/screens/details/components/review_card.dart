import 'package:booking_lecture/components/rating.dart';
import 'package:booking_lecture/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewCard extends StatelessWidget {
  final String image, name, date, title, comment;
  final int rating;
  //final Function onTap, onPressed;
  //final bool isLess;
  const ReviewCard({
    Key? key,
    required this.image,
    required this.name,
    required this.date,
    required this.title,
    required this.comment,
    required this.rating,
    //this.onTap,
    //this.isLess,
    //this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.defaultDialog(
        title: "",
        content: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(44.0),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Rating(score: rating.round()),
                  // SmoothStarRating(
                  //   starCount: 5,
                  //   rating: rating,
                  //   size: 28.0,
                  //   color: Colors.orange,
                  //   borderColor: Colors.orange,
                  // ),
                  SizedBox(width: 16.0),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                comment,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              ),
              // GestureDetector(
              //   onTap: onTap,
              //   child: isLess
              //       ? Text(
              //           comment,
              //           style: TextStyle(
              //             fontSize: 18.0,
              //             color: kLightColor,
              //           ),
              //         )
              //       : Text(
              //           comment,
              //           maxLines: 3,
              //           overflow: TextOverflow.ellipsis,
              //           style: TextStyle(
              //             fontSize: 18.0,
              //             color: kLightColor,
              //           ),
              //         ),
              // ),
            ],
          ),
        ),
        barrierDismissible: true,
      ),
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color:
              Get.isDarkMode ? Color.fromARGB(255, 34, 32, 32) : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 45.0,
                  width: 45.0,
                  margin: EdgeInsets.only(right: 16.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(44.0),
                  ),
                ),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Rating(score: rating.round()),
                // SmoothStarRating(
                //   starCount: 5,
                //   rating: rating,
                //   size: 28.0,
                //   color: Colors.orange,
                //   borderColor: Colors.orange,
                // ),
                SizedBox(width: 16.0),
                Text(
                  date,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              comment,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
            // GestureDetector(
            //   onTap: onTap,
            //   child: isLess
            //       ? Text(
            //           comment,
            //           style: TextStyle(
            //             fontSize: 18.0,
            //             color: kLightColor,
            //           ),
            //         )
            //       : Text(
            //           comment,
            //           maxLines: 3,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //             fontSize: 18.0,
            //             color: kLightColor,
            //           ),
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
