import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:prachar/constants/constants.dart';

class DynamicLinkService {
  static Future<Uri> createDynamicLink(String storeId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: DYNAMIC_LINK_PREFIX,
      link: Uri.parse('$DYNAMIC_LINK_LANDING_URL/?storeId=$storeId'),
      androidParameters: AndroidParameters(
        packageName: APP_PACKAGE_NAME,
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: APP_PACKAGE_NAME,
        minimumVersion: '1',
        appStoreId: APP_PACKAGE_NAME,
      ),
    );
    return (await parameters.buildShortLink()).shortUrl;
  }
}
