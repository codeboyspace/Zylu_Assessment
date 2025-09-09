import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../app_constants.dart';
import '../screens/employee_details_page.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  EmployeeTile({required this.employee});

// Employee tiles: Because spreadsheets are boring

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: Duration(milliseconds: 600),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                gradient: LinearGradient(
                  colors: [
                    AppColors.backgroundCard,
                    AppColors.backgroundLight.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.backgroundLight.withOpacity(0.8),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(-5, -5),
                  ),
                  BoxShadow(
                    color: AppColors.shadowDark.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(5, 5),
                  ),
                ],
                border: Border.all(
                  color: (employee.years > 5 && employee.isActive)
                      ? AppColors.activeGreen
                      : AppColors.primaryPurple.withOpacity(0.1),
                  width: (employee.years > 5 && employee.isActive) ? 2 : 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            EmployeeDetailsPage(employee: employee),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOutCubic;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                  splashColor: AppColors.primaryPurple.withOpacity(0.1),
                  highlightColor: AppColors.primaryPurple.withOpacity(0.05),
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryPurple.withOpacity(0.2),
                                AppColors.primaryPurple.withOpacity(0.4),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            border: Border.all(
                              color: AppColors.primaryPurple.withOpacity(0.5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.backgroundLight.withOpacity(0.6),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: Offset(-3, -3),
                              ),
                              BoxShadow(
                                color: AppColors.shadowDark.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: Offset(3, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              employee.name.isNotEmpty
                                  ? employee.name[0].toUpperCase()
                                  : '?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.backgroundWhite,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: AppSpacing.lg),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    AppColors.textPrimary,
                                    AppColors.textPrimary,
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  employee.name,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.backgroundWhite,
                                        shadows: null,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: AppSpacing.xs),

                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                                  border: Border.all(
                                    color: AppColors.primaryPurple.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      employee.role,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: AppColors.primaryPurple,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(width: AppSpacing.xs),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: AppSpacing.xs,
                                        vertical: AppSpacing.xs,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.textLight.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(AppBorderRadius.xs),
                                      ),
                                      child: Text(
                                        '${employee.years}y',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: AppColors.textSecondary,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: AppSpacing.sm),
                              Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: employee.isActive && employee.years >= 5
                                          ? AppColors.activeGreen
                                          : AppColors.inactiveGray,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.backgroundLight.withOpacity(0.4),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                          offset: Offset(-1, -1),
                                        ),
                                        BoxShadow(
                                          color: AppColors.shadowDark.withOpacity(0.2),
                                          blurRadius: 4,
                                          spreadRadius: 1,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: AppSpacing.sm),
                                  Text(
                                    employee.isActive && employee.years >= 5 ? 'Active' : 'Inactive',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: employee.isActive && employee.years >= 5
                                              ? AppColors.activeGreen
                                              : AppColors.inactiveGray,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: AppSpacing.md),
                        Container(
                          padding: EdgeInsets.all(AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: AppColors.primaryPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                            border: Border.all(
                              color: AppColors.primaryPurple.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.chevron_right,
                            color: AppColors.primaryPurple,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
