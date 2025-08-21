import 'package:dashboard/common/widgets/page_not_found/page_not_found.dart';
import 'package:dashboard/routes/app_pages.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final List<GetPage> pages = [
    // -------------------- AUTH --------------------
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(
      name: TRoutes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: TRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(name: TRoutes.logout, page: () => LogoutPage()),

    GetPage(name: TRoutes.pagenotfound, page: () => PageNotFound()),

    // -------------------- DASHBOARD --------------------
    GetPage(
      name: TRoutes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- MEDIA --------------------
    GetPage(
      name: TRoutes.media,
      page: () => const MediaScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- BANNERS --------------------
    GetPage(
      name: TRoutes.banners,
      page: () => BannersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createBanner,
      page: () => CreateBannerScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editBanner,
      page: () => EditBannerScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- SERVERS --------------------
    GetPage(
      name: TRoutes.servers,
      page: () => ServersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createServer,
      page: () => CreateServerScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editServer,
      page: () => EditServerScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- SERIES --------------------
    GetPage(
      name: TRoutes.series,
      page: () => SeriesScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- PRODUCTS --------------------
    GetPage(
      name: TRoutes.products,
      page: () => const ProductsScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createProduct,
      page: () => const CreateProductScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editProduct,
      page: () => const EditProductScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- PRODUCTS --------------------
    GetPage(
      name: TRoutes.reports,
      page: () => const ReportsScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.reportdetails,
      page: () => const ReportDetailScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- CATEGORIES --------------------
    GetPage(
      name: TRoutes.categories,
      page: () => CategoriesScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createCategory,
      page: () => CreateCategoryScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editCategory,
      page: () => EditCategoryScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- BRANDS --------------------
    GetPage(
      name: TRoutes.brands,
      page: () => BrandsScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createBrand,
      page: () => CreateBrandScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editBrand,
      page: () => EditBrandsScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- CUSTOMERS --------------------
    GetPage(
      name: TRoutes.customers,
      page: () => CustomersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createCustomer,
      page: () => CreateCustomersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.customerDetails,
      page: () => EditCustomersDesktopScreen(uid: 'uid_1'),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- ORDERS --------------------
    GetPage(
      name: TRoutes.orders,
      page: () => const OrdersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.orderDetails,
      page: () => OrderDetailScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editOrders,
      page: () => EditOrderDesktopScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- PROFILE --------------------
    GetPage(
      name: TRoutes.profile,
      page: () => Profile(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- SETTINGS --------------------
    GetPage(
      name: TRoutes.settings,
      page: () => SettingsPage(),
      middlewares: [TRouteMiddleware()],
    ),

    // -------------------- MISC --------------------
    GetPage(
      name: TRoutes.AnimationGallery,
      page: () => AnimationGallery(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.savedCredentials,
      page: () => LoggedInUserPage(),
      middlewares: [TRouteMiddleware()],
    ),
  ];
}



/*import 'package:dashboard/routes/app_pages.dart';
import 'package:get/get.dart';

class TAppRoute {
  static final List<GetPage> pages = [
    // Auth
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(
      name: TRoutes.forgetPassword,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: TRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
    ),
    GetPage(name: TRoutes.logout, page: () => LogoutPage()),

    // DashBoard
    GetPage(
      name: TRoutes.dashboard,
      page: () => const DashboardScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    // Media
    GetPage(
      name: TRoutes.media,
      page: () => const MediaScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Banners
    GetPage(
      name: TRoutes.banners,
      page: () => BannersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createBanner,
      page: () => CreateBannerScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editBanner,
      page: () => EditBannerScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Banners
    GetPage(
      name: TRoutes.servers,
      page: () => ServersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createServer,
      page: () => CreateServerScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editServer,
      page: () => EditServerScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Products
    GetPage(
      name: TRoutes.series,
      page: () => SeriesScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createProduct,
      page: () => CreateProductScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editProduct,
      page: () => EditProductScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Categories
    GetPage(
      name: TRoutes.categories,
      page: () => CategoriesScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createCategory,
      page: () => CreateCategoryScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editCategory,
      page: () => EditCategoryScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Brands
    GetPage(
      name: TRoutes.brands,
      page: () => BrandsScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createBrand,
      page: () => CreateBrandScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editBrand,
      page: () => EditBrandsScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    // Products
    GetPage(
      name: TRoutes.products,
      page: () => const ProductsScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createProduct,
      page: () => const CreateProductScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editProduct,
      page: () => const EditProductScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Customers (add more routes as needed)
    GetPage(
      name: TRoutes.customers,
      page: () => CustomersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.createCustomer,
      page: () => CreateCustomersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.customerDetails,
      page: () => EditCustomersDesktopScreen(uid: 'uid_1'),
      middlewares: [TRouteMiddleware()],
    ),

    // Orders
    GetPage(
      name: TRoutes.orders,
      page: () => const OrdersScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.orderDetails,
      page: () => OrderDetailScreen(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.editOrders,
      page: () => EditOrderDesktopScreen(),
      middlewares: [TRouteMiddleware()],
    ),

    // Profile (add more routes as needed)
    GetPage(
      name: TRoutes.profile,
      page: () => Profile(),
      middlewares: [TRouteMiddleware()],
    ),

    // Other Items
    GetPage(
      name: TRoutes.settings,
      page: () => SettingsPage(),
      middlewares: [TRouteMiddleware()],
    ),

    /// Other From My Side
    GetPage(
      name: TRoutes.AnimationGallery,
      page: () => AnimationGallery(),
      middlewares: [TRouteMiddleware()],
    ),
    GetPage(
      name: TRoutes.savedCredentials,
      page: () => LoggedInUserPage(),
      middlewares: [TRouteMiddleware()],
    ),
  ];
}
*/