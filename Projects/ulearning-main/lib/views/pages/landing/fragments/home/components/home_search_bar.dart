part of '../home.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
    required this.onFilter,
  });
  final VoidCallback onFilter;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: iconSizeBox,
          margin: const EdgeInsets.only(right: paddingSmall),
          padding: const EdgeInsets.symmetric(horizontal: paddingDefault),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusDefault * 2),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: AppColors.textHint),
              const SizedBox(width: widthDefault),
              Expanded(
                child: Text(
                  'Search your courses',
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.textHint),
                ),
              ),
            ],
          ),
        ).expand(),
        (widthSmall / 2).width,
        Container(
          padding: const EdgeInsets.all(paddingDefault),
          decoration: BoxDecoration(
            color: context.theme.primaryColor,
            borderRadius: BorderRadius.circular(borderRadiusDefault * 2),
          ),
          child: const Icon(Iconic.settings_sliders, color: Colors.white)
              .mirrorY()
              .rotate90(),
        ).onTap(onFilter)
      ],
    ).paddingSymmetric(horizontal: paddingDefault);
  }
}
