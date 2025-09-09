import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/api_services.dart';
import '../models/employee.dart';
import '../widgets/employee_tile.dart';
import '../app_constants.dart';
import 'add_employee_page.dart';

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

// The main stage where all the employee drama unfolds

class _EmployeeListPageState extends State<EmployeeListPage>
    with TickerProviderStateMixin {
  final ApiService apiService = ApiService();
  late Future<List<Employee>> employees;
  late AnimationController _fabAnimationController;
  late Animation<double> _fabAnimation;
  List<Employee> _allEmployees = [];
  List<Employee> _filteredEmployees = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    employees = apiService.getEmployees();

    _fabAnimationController = AnimationController(
      duration: AppAnimations.normal,
      vsync: this,
    );
    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.elasticOut,
    ));
    _fabAnimationController.forward();

    _searchController.addListener(_filterEmployees);
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _refreshEmployees() {
    setState(() {
      employees = apiService.getEmployees();
    });
  }

  void _filterEmployees() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredEmployees = _allEmployees;
      } else {
        _filteredEmployees = _allEmployees.where((employee) {
          return employee.name.toLowerCase().contains(query) ||
                 employee.role.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _onEmployeesLoaded(List<Employee> loadedEmployees) {
    _allEmployees = loadedEmployees;
    _filteredEmployees = loadedEmployees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // Increased height
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppAssets.backgroundImage),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6),
                        BlendMode.multiply,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.2),
                        AppColors.primaryPurple.withOpacity(0.3),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 48),

                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Employee Directory",
                                  style: GoogleFonts.dancingScript(
                                    fontSize: 31,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                    letterSpacing: 1.5,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                      Shadow(
                                        color: AppColors.secondaryCyan.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: AppSpacing.xs),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.xs,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryCyan.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                                    border: Border.all(
                                      color: AppColors.secondaryCyan.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    "Manage your team with Zylu",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.secondaryCyan,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondaryCyan.withOpacity(0.8),
                                AppColors.secondaryCyanLight.withOpacity(0.6),
                                AppColors.secondaryCyan.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(AppBorderRadius.md),
                            border: Border.all(
                              color: AppColors.secondaryCyan.withOpacity(0.5),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondaryCyan.withOpacity(0.4),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.refresh,
                              color: AppColors.textPrimary,
                              size: 24,
                            ),
                            onPressed: () {
                              _searchFocusNode.unfocus();
                              _refreshEmployees();
                            },
                            tooltip: 'Refresh',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          _searchFocusNode.unfocus();
        },
        child: Container(
          color: AppColors.backgroundDark,
          child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.backgroundCard,
                    AppColors.backgroundLight.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.1),
                    blurRadius: 12,
                    spreadRadius: 2,
                    offset: Offset(0, 4),
                  ),
                ],
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.primaryPurple.withOpacity(0.1),
                    width: 1,
                  ),
                ),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
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
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.primaryPurple.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        focusNode: _searchFocusNode,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search employees by name or role...',
                          hintStyle: TextStyle(
                            color: AppColors.textSecondary.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Container(
                            padding: EdgeInsets.all(AppSpacing.sm),
                            child: Icon(
                              Icons.search,
                              color: AppColors.primaryPurple,
                              size: 20,
                            ),
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.all(AppSpacing.xs),
                                  child: IconButton(
                                    icon: Container(
                                      padding: EdgeInsets.all(AppSpacing.xs),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryPurple.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        color: AppColors.primaryPurple,
                                        size: 16,
                                      ),
                                    ),
                                    onPressed: () {
                                      _searchFocusNode.unfocus();
                                      _searchController.clear();
                                      _searchFocusNode.requestFocus();
                                    },
                                  ),
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.transparent,
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
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: FutureBuilder<List<Employee>>(
                future: employees,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryPurple,
                            ),
                          ),
                          SizedBox(height: AppSpacing.md),
                          Text(
                            'Loading employees...',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: AppColors.inactiveRed,
                          ),
                          SizedBox(height: AppSpacing.md),
                          Text(
                            'Error loading employees',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            '${snapshot.error}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: AppSpacing.lg),
                          ElevatedButton.icon(
                            onPressed: _refreshEmployees,
                            icon: Icon(Icons.refresh),
                            label: Text('Try Again'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryPurple,
                              foregroundColor: AppColors.backgroundWhite,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: AppColors.textLight,
                          ),
                          SizedBox(height: AppSpacing.md),
                          Text(
                            'No employees found',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          SizedBox(height: AppSpacing.sm),
                          Text(
                            'Add your first employee to get started',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  final data = snapshot.data!;
                  if (_allEmployees.isEmpty) {
                    _onEmployeesLoaded(data);
                  }

                  final displayList = _searchController.text.isEmpty ? data : _filteredEmployees;

                  return RefreshIndicator(
                    onRefresh: () async {
                      _refreshEmployees();
                      await Future.delayed(AppAnimations.normal);
                    },
                    color: AppColors.primaryPurple,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: AppSpacing.sm,
                        bottom: AppSpacing.xxl + 80, // Extra space for FAB
                      ),
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        return AnimatedOpacity(
                          opacity: 1.0,
                          duration: AppAnimations.normal,
                          child: EmployeeTile(employee: displayList[index]),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryCyan,
                AppColors.secondaryCyanLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppBorderRadius.xl),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryCyan.withOpacity(0.4),
                blurRadius: 12,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.secondaryCyan.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 4,
                offset: Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: AppColors.textPrimary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: FloatingActionButton.extended(
            onPressed: () async {
              _searchFocusNode.unfocus();

              final result = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppBorderRadius.xl),
                  ),
                ),
                builder: (BuildContext context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.9,
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (BuildContext context, ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.backgroundDark,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(AppBorderRadius.xl),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: AppSpacing.sm),
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.textLight.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            Expanded(
                              child: AddEmployeePage(apiService: apiService),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );

              if (result == true) {
                _refreshEmployees();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(AppSpacing.xs),
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(AppBorderRadius.sm),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              color: AppColors.textPrimary,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Text(
                            'Employee added successfully!',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    backgroundColor: AppColors.accentGreen,
                    duration: Duration(milliseconds: 3000),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppBorderRadius.lg),
                    ),
                    margin: EdgeInsets.all(AppSpacing.md),
                  ),
                );
              }
            },
            icon: Container(
              padding: EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppBorderRadius.sm),
              ),
              child: Icon(
                Icons.add,
                size: 20,
                color: AppColors.textPrimary,
              ),
            ),
            label: Text(
              'Add Employee',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.textPrimary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppBorderRadius.xl),
            ),
          ),
        ),
      ),
    );
  }
}
