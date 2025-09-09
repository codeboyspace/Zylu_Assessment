import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../models/employee.dart';
import '../app_constants.dart';

class AddEmployeePage extends StatefulWidget {
  final ApiService apiService;
  AddEmployeePage({required this.apiService});

// The magical form that turns coffee into employees

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  bool isActive = true;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    yearsController.dispose();
    super.dispose();
  }

  Future<void> _saveEmployee() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final newEmployee = Employee(
        id: "",
        name: nameController.text.trim(),
        role: roleController.text.trim(),
        years: int.tryParse(yearsController.text) ?? 0,
        isActive: isActive,
      );

      await widget.apiService.createEmployee(newEmployee);

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add employee: ${e.toString()}'),
            backgroundColor: AppColors.inactiveRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.md),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                // Header
                Container(
                  padding: EdgeInsets.all(AppSpacing.lg),
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
                    boxShadow: [
                      // Neumorphic light shadow
                      BoxShadow(
                        color: AppColors.backgroundLight.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(-3, -3),
                      ),
                      // Neumorphic dark shadow
                      BoxShadow(
                        color: AppColors.shadowDark.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(3, 3),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.primaryPurple.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: AppColors.primaryPurple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppBorderRadius.md),
                        ),
                        child: Icon(
                          Icons.person_add,
                          color: AppColors.primaryPurple,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Employee Information',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(height: AppSpacing.xs),
                            Text(
                              'Add a new team member to your organization',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.lg),

                // Name Field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                    boxShadow: [
                      // Neumorphic light shadow
                      BoxShadow(
                        color: AppColors.backgroundLight.withOpacity(0.6),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(-3, -3),
                      ),
                      // Neumorphic dark shadow
                      BoxShadow(
                        color: AppColors.shadowDark.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: nameController,
                    style: TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      hintText: "Enter employee's full name",
                      labelStyle: TextStyle(color: AppColors.textSecondary),
                      hintStyle: TextStyle(color: AppColors.textLight),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(AppSpacing.sm),
                        child: Icon(
                          Icons.person,
                          color: AppColors.primaryPurple,
                          size: 20,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundCard,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                        borderSide: BorderSide(
                          color: AppColors.primaryPurple,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter the employee's name";
                      }
                      if (value.trim().length < 2) {
                        return "Name must be at least 2 characters";
                      }
                      return null;
                    },
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
                SizedBox(height: AppSpacing.md),

                // Role Field
                TextFormField(
                  controller: roleController,
                  decoration: InputDecoration(
                    labelText: "Job Role",
                    hintText: "Enter employee's position",
                    prefixIcon: Icon(
                      Icons.work,
                      color: AppColors.primaryPurple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      borderSide: BorderSide(
                        color: AppColors.primaryPurple,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter the employee's role";
                    }
                    return null;
                  },
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(height: AppSpacing.md),

                // Years Field
                TextFormField(
                  controller: yearsController,
                  decoration: InputDecoration(
                    labelText: "Years of Experience",
                    hintText: "Enter years of experience",
                    prefixIcon: Icon(
                      Icons.timeline,
                      color: AppColors.primaryPurple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      borderSide: BorderSide(
                        color: AppColors.primaryPurple,
                        width: 2,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter years of experience";
                    }
                    final years = int.tryParse(value);
                    if (years == null) {
                      return "Please enter a valid number";
                    }
                    if (years < 0) {
                      return "Years cannot be negative";
                    }
                    if (years > 50) {
                      return "Please enter a realistic number of years";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSpacing.lg),

                // Active Status
                Container(
                  padding: EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    border: Border.all(
                      color: AppColors.textLight.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employment Status',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                      ),
                      SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          Checkbox(
                            value: isActive,
                            onChanged: (val) {
                              setState(() {
                                isActive = val ?? false;
                              });
                            },
                            activeColor: AppColors.primaryPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Currently Active',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textPrimary,
                                      ),
                                ),
                                Text(
                                  'Employee is currently employed and active',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.activeGreen.withOpacity(0.1)
                                  : AppColors.inactiveGray.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                            ),
                            child: Text(
                              isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: isActive
                                    ? AppColors.activeGreen
                                    : AppColors.inactiveGray,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.xxl),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveEmployee,
                    icon: _isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.backgroundWhite,
                              ),
                            ),
                          )
                        : Icon(Icons.save),
                    label: Text(
                      _isLoading ? 'Saving...' : 'Save Employee',
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.md),

                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _isLoading ? null : () => Navigator.pop(context),
                    child: Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                      side: BorderSide(color: AppColors.textSecondary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.md),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
