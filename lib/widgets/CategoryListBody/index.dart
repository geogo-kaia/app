import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryListBody extends StatelessWidget {
  const CategoryListBody({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var images = [
      "https://t4.ftcdn.net/jpg/02/31/10/59/240_F_231105912_dvx5EJiKqkeK5x9GYGOZ46t8sWS5uidO.jpg",
      "https://media.gettyimages.com/photos/carpenter-working-in-the-workshop-picture-id1137620536?s=612x612",
      "https://image.freepik.com/free-photo/concept-leisure-travel-summer-tropical-beach-seaside-retro-camera-sandbar-with-starfish-shells-coral-sandbar-blur-sea-background-vintage-color-tone-styles_1484-945.jpg",
      "https://images-na.ssl-images-amazon.com/images/I/612V65x2twL._AC_SL1134_.jpg",
      "https://t4.ftcdn.net/jpg/02/31/10/59/240_F_231105912_dvx5EJiKqkeK5x9GYGOZ46t8sWS5uidO.jpg",
      "https://media.gettyimages.com/photos/carpenter-working-in-the-workshop-picture-id1137620536?s=612x612",
      "https://t4.ftcdn.net/jpg/02/31/10/59/240_F_231105912_dvx5EJiKqkeK5x9GYGOZ46t8sWS5uidO.jpg",
      "https://media.gettyimages.com/photos/carpenter-working-in-the-workshop-picture-id1137620536?s=612x612",
      "https://media.gettyimages.com/photos/carpenter-working-in-the-workshop-picture-id1137620536?s=612x612",
      "https://media.gettyimages.com/photos/carpenter-working-in-the-workshop-picture-id1137620536?s=612x612",
    ];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  CachedNetworkImage(
                    color: Colors.black45.withAlpha(50),
                    colorBlendMode: BlendMode.darken,
                    height: double.infinity,
                    imageUrl: images[index],
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[200]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 8),
                    child: Text(
                      "工作坊",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              ))),
    );
  }
}
