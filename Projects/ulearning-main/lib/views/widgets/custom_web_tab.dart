import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import '/utils/extentions/index.dart';

Future<void> launchURLInBottomSheet(BuildContext context, String url,
    {double h = 0.9}) async {
  final theme = Theme.of(context);
  final mediaQuery = MediaQuery.of(context);
  await launchUrl(
    Uri.parse(url),
    customTabsOptions: CustomTabsOptions.partial(
      configuration: PartialCustomTabsConfiguration(
        initialHeight: mediaQuery.size.height * h,
        // activityHeightResizeBehavior:
        //     CustomTabsActivityHeightResizeBehavior.adjustable,
      ),
      colorSchemes: CustomTabsColorSchemes.defaults(
        toolbarColor: theme.scaffoldBackgroundColor,
        navigationBarColor: context.theme.primaryColor,
      ),
      showTitle: true,
      shareState: CustomTabsShareState.off,
    ),
    safariVCOptions: SafariViewControllerOptions.pageSheet(
      configuration: const SheetPresentationControllerConfiguration(
        detents: {
          SheetPresentationControllerDetent.large,
          SheetPresentationControllerDetent.medium,
        },
        prefersScrollingExpandsWhenScrolledToEdge: true,
        prefersGrabberVisible: true,
        prefersEdgeAttachedInCompactHeight: true,
      ),
      preferredBarTintColor: theme.colorScheme.surface,
      preferredControlTintColor: theme.colorScheme.onSurface,
      dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
    ),
  );
}
