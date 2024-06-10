import '../alarm_export.dart';
import 'package:alarm_clock/widgets/navigation.dart';
import 'package:alarm_clock/view/nav_bar/nav_view.dart';

class BadTimeView extends StatelessWidget {
  const BadTimeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      bottomNavigationBar: SafeArea(
        child: Container(
          color: AppColors.backgroundColor,
          height: 9.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  navigateTo(const HomeView());
                },
                child: bottomVavText('Cancel'),
              ),
              GestureDetector(
                child: bottomVavText('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
