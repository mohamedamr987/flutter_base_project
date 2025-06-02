part of '../view.dart';

class _NavBar extends StatelessWidget {
  const _NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = getIt.get<NavBarCubit>();

    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return ClipPath(
          clipper: HalfCircleClipper(),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            clipBehavior: Clip.hardEdge,
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: CachingUtils.user.model?.role == "seller"
                  ? [
                      _BuildItem(
                        icon: "store",
                        label: "products".tr(),
                        index: 0,
                      ),
                      _BuildItem(
                        icon: "orders",
                        label: "orders".tr(),
                        index: 1,
                        indicator: true,
                        count: cubit.orders,
                      ),
                      _BuildItem(
                        icon: "chat",
                        label: "conversations".tr(),
                        index: 2,
                        indicator: true,
                        count: cubit.numberOfUnReadMessages,
                      ),
                      _BuildItem(
                        icon: "person",
                        label: "clients".tr(),
                        index: 3,
                      ),
                      _BuildItem(
                        icon: "person",
                        label: "account".tr(),
                        index: 4,
                      ),
                    ]
                  : [
                      _BuildItem(
                        icon: "store",
                        label: "products".tr(),
                        index: 0,
                      ),
                      _BuildItem(
                          icon: "cart",
                          label: "cart".tr(),
                          index: 1,
                          indicator: true,
                          count: 0),
                      _BuildItem(
                        icon: "orders",
                        label: "my_orders".tr(),
                        index: 2,
                        indicator: true,
                        count: cubit.numberOfUnReadMessages,
                      ),
                      _BuildItem(
                        icon: "person",
                        label: "account".tr(),
                        index: 3,
                      ),
                    ],
            ),
          ),
        );
      },
    );
  }
}

class _BuildItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final bool indicator;
  final int count;
  const _BuildItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.index,
    this.indicator = false,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = getIt.get<NavBarCubit>();
    return InkWell(
      onTap: () {
        cubit.changeView(index);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.13,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Utils.getAssetPNGPath(icon),
                  width: 24,
                  height: 24,
                  color: cubit.currentViewIndex == index
                      ? AppColors.primary
                      : Color(0xFF969E9D),
                ),
                AppText(
                  title: label,
                  fontSize: 10,
                  color: cubit.currentViewIndex == index
                      ? AppColors.primary
                      : Color(0xFF969E9D),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (indicator && ((count > 0)))
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  alignment: Alignment.center,
                  width: (count > 0) ? 14 : 8,
                  height: (count > 0) ? 14 : 8,
                  decoration: BoxDecoration(
                    color: Color(0xFFEA3333),
                    shape: BoxShape.circle,
                  ),
                  child: count > 0
                      ? Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AppText(
                              title: count.toString(),
                              fontSize: 8,
                              color: AppColors.white,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final halfWidth = size.width / 2;
    final cutoutRadius = 30.0; // Adjust the radius of the cutout

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    // Move to the start of the cutout
    path.lineTo(halfWidth - cutoutRadius, 0);

    // Create a half-circle cutout
    path.arcToPoint(
      Offset(halfWidth + cutoutRadius, 0),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
