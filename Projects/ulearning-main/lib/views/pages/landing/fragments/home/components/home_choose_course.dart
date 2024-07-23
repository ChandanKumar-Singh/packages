part of '../home.dart';

class _HomeChooseCourseSection extends StatelessWidget {
  const _HomeChooseCourseSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Choose your course',
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text('View All',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.textTertiary,
                )).onTap(() {}),
          ],
        ),
        const SizedBox(height: heightSmall),
        _tabs(context),
      ],
    );
  }

  DefaultTabController _tabs(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.textTertiary,
            indicatorColor: context.theme.primaryColor,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadiusDefault),
              color: context.theme.primaryColor,
            ),
            labelStyle: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            labelPadding: const EdgeInsetsDirectional.symmetric(
                horizontal: paddingDefault * 2),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Design'),
              Tab(text: 'Development'),
              Tab(text: 'Business'),
              Tab(text: 'Marketing'),
            ],
          ).size(height: 40).padding(bottom: paddingSmall),
          TabBarView(
            children: [
              _GridItem(),
              _GridItem(),
              _GridItem(),
              _GridItem(),
              _GridItem(),
            ],
          ).size(height: 700),
        ],
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsetsDirectional.symmetric(vertical: paddingSmall),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        mainAxisSpacing: paddingSmall,
        crossAxisSpacing: paddingSmall,
        childAspectRatio: 1.6,
      ),
      itemCount: 5,
      itemBuilder: (c, i) => Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://www.purchasing-procurement-center.com/images/online-course.jpg',
              fit: BoxFit.cover,
            ).clipRoundRect((borderRadiusDefault * 1.5).w),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container( 
                padding: const EdgeInsets.all(paddingSmall),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadiusDefault),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Title',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                            color: Colors.blueGrey.withOpacity(0.9),
                            blurRadius: 15,
                            spreadRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            blurRadius: 5,
                            spreadRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Course Description',
                      style: context.textTheme.bodySmall?.copyWith(
                          color: context.textTheme.bodyMedium?.color,
                          shadows: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
