import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../app_constants.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsPage({
    Key? key,
    required this.employee,
  }) : super(key: key);

// Employee spotlight - where we pretend to care about their personal life

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Text("Employee"),
          elevation: 0,
          backgroundColor: AppColors.backgroundCard,
          foregroundColor: AppColors.textPrimary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundDark,
              AppColors.backgroundCard,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  margin: EdgeInsets.all(AppSpacing.lg),
                  padding: EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.backgroundCard,
                        AppColors.backgroundLight,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 20,
                        spreadRadius: 5,
                        offset: Offset(0, 10),
                      ),
                      BoxShadow(
                        color: AppColors.primaryPurple.withOpacity(0.1),
                        blurRadius: 30,
                        spreadRadius: 10,
                        offset: Offset(0, 20),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryPurple.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryPurple,
                              AppColors.primaryPurpleLight,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: AppColors.primaryPurple.withOpacity(0.3),
                            width: 4,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPurple.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            employee.name.isNotEmpty
                                ? employee.name[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),

                      Text(
                        employee.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSpacing.sm),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryPurple.withOpacity(0.1),
                              AppColors.secondaryCyan.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                          border: Border.all(
                            color: AppColors.primaryPurple.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.backgroundLight.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: Offset(-2, -2),
                            ),
                            BoxShadow(
                              color: AppColors.shadowDark.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          employee.role,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.primaryPurple,
                                fontWeight: FontWeight.w600,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: AppSpacing.lg),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                              padding: EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundCard,
                                borderRadius: BorderRadius.circular(AppBorderRadius.md),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.backgroundLight.withOpacity(0.5),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: Offset(-2, -2),
                                  ),
                                  BoxShadow(
                                    color: AppColors.shadowDark.withOpacity(0.2),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.timeline,
                                    color: AppColors.secondaryCyan,
                                    size: 24,
                                  ),
                                  SizedBox(height: AppSpacing.xs),
                                  Text(
                                    '${employee.years} years',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    'Experience',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                              padding: EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundCard,
                                borderRadius: BorderRadius.circular(AppBorderRadius.md),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.backgroundLight.withOpacity(0.5),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: Offset(-2, -2),
                                  ),
                                  BoxShadow(
                                    color: AppColors.shadowDark.withOpacity(0.2),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: employee.isActive && employee.years >= 5
                                          ? AppColors.activeGreen
                                          : AppColors.inactiveGray,
                                      boxShadow: [
                                        BoxShadow(
                                          color: (employee.isActive && employee.years >= 5
                                                  ? AppColors.activeGreen
                                                  : AppColors.inactiveGray)
                                              .withOpacity(0.4),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: AppSpacing.xs),
                                  Text(
                                    employee.isActive && employee.years >= 5 ? 'Active' : 'Inactive',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    'Status',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}