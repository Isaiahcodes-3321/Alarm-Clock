import 'nav_export.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
//

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      refProvider = ref;
      return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
            child: AnimatedBorderContainer(
          pageName: navViews.elementAt(selectedIndexView),
        )),
        bottomNavigationBar: Container(
          color: AppColors.lightGreyColor,
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.all(13.sp),
            child: GNav(
              rippleColor: AppColors.blueColor,
              hoverColor: AppColors.blueColor,
              gap: 8,
              activeColor: AppColors.backgroundColor,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: AppColors.whiteColor,
              color: AppColors.backgroundColor,
              tabs: [
                GButton(
                  icon: Icons.alarm_outlined,
                  iconColor: AppColors.whiteColor,
                  text: 'Alarm',
                ),
                GButton(
                  icon: Icons.stop_circle_outlined,
                  iconColor: AppColors.whiteColor,
                  text: 'Stopwatch',
                ),
                GButton(
                  icon: Icons.timer_off_outlined,
                  iconColor: AppColors.whiteColor,
                  text: 'Timer',
                ),
              ],
              selectedIndex: selectedIndexView,
              onTabChange: (index) {
                setState(() {
                  selectedIndexView = index;
                  timerSettings();
                  if (selectedIndexView == 0 || selectedIndexView == 2) {
                    ref.read(isStartButtonClick.notifier).state = true;
                    ref.read(isLapButtonClick.notifier).state = false;
                  }
                  // print('num of nave $selectedIndexView');
                });
              },
            ),
          )),
        ),
      );
    });
  }
}

class AnimatedBorderContainer extends StatefulWidget {
  final Widget pageName;

  const AnimatedBorderContainer({super.key, required this.pageName});

  @override
  _AnimatedBorderContainerState createState() =>
      _AnimatedBorderContainerState();
}

class _AnimatedBorderContainerState extends State<AnimatedBorderContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return CustomPaint(
      painter: BorderPainter(_controller),
      child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: widget.pageName,
      ),
    );
  }
}

class BorderPainter extends CustomPainter {
  final Animation<double> animation;

  BorderPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final double progress = animation.value;

    paint.shader = SweepGradient(
      startAngle: 0.0,
      endAngle: 3.14 * 2,
      colors: [AppColors.whiteColor, AppColors.blueColor, AppColors.whiteColor],
      stops: [0.0, progress, 1.0],
    ).createShader(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(0.0));

    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
