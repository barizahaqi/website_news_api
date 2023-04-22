import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_news_api/data/model/article.dart';
import 'package:website_news_api/ui/news_detail_page_mobile.dart';
import 'package:website_news_api/ui/news_detail_page_web.dart';

enum SocialMedia { facebook, twitter, email, linkedin, whatsapp }

class NewsDetailScreen extends StatelessWidget {
  final Article article;

  static const routeName = '/news_detail';

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 900) {
          return NewsDetailPageWeb(article: article);
        } else {
          return NewsDetailPageMobile(article: article);
        }
      },
    );
  }
}

Widget buildSocialButtons(String urlShare) => Card(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSocialButton(
          icon: FontAwesomeIcons.squareFacebook,
          color: const Color(0xFF0075FC),
          onClicked: () => share(urlShare, SocialMedia.facebook),
        ),
        buildSocialButton(
          icon: FontAwesomeIcons.twitter,
          color: const Color(0xFF1DA1F2),
          onClicked: () => share(urlShare, SocialMedia.twitter),
        ),
        buildSocialButton(
          icon: Icons.mail,
          color: const Color(0xFF0064C9),
          onClicked: () => share(urlShare, SocialMedia.email),
        ),
        buildSocialButton(
          icon: FontAwesomeIcons.linkedin,
          color: const Color(0xFF0064C9),
          onClicked: () => share(urlShare, SocialMedia.linkedin),
        ),
        buildSocialButton(
          icon: FontAwesomeIcons.whatsapp,
          color: const Color(0xFF00D856),
          onClicked: () => share(urlShare, SocialMedia.whatsapp),
        ),
      ],
    ));

Future share(String urlString, SocialMedia socialPlatform) async {
  const subject = "Top Headlines";
  const text = "Recommended News";
  final urlShare = Uri.encodeComponent(urlString);

  final urls = {
    SocialMedia.facebook:
        'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text',
    SocialMedia.twitter:
        'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
    SocialMedia.email: 'mailto:?subject=$subject&body=$text\n\n$urlShare',
    SocialMedia.linkedin:
        'https://www.linkedin.com/shareArticle?mini=true&url=$urlShare',
    SocialMedia.whatsapp: 'https://api.whatsapp.com/send?text=$text\n$urlShare'
  };
  final url = urls[socialPlatform]!;

  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}

Widget buildSocialButton({
  required IconData icon,
  Color? color,
  required VoidCallback onClicked,
}) =>
    InkWell(
      onTap: onClicked,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Center(child: FaIcon(icon, color: color, size: 40)),
      ),
    );
