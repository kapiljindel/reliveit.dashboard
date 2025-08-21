class TRoutes {
  static const login = '/login';
  static const logout = '/logout';
  static const forgetPassword = '/forgetPassword';
  static const resetPassword = '/resetPassword';
  static const pagenotfound = '/page-not-found';

  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const servers = '/servers';
  static const createServer = '/createServer';
  static const editServer = '/editServer';

  static const series = '/series';
  static const createProduct = '/createProducts';
  static const editProduct = '/editProduct';

  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';

  static const orders = '/orders';
  static const orderDetails = '/orderDetails';
  static const editOrders = '/editOrders';

  static const coupons = '/coupons';
  static const settings = '/settings';

  static const reports = '/reports';
  static const reportdetails = '/reportdetails';

  static const profile = '/profile';

  /// Other From My Side
  static const ServerDashboardPage = '/ServerDashboardPage';
  static const AnimationGallery = '/AnimationGallery';
  static const posts = '/posts';
  static const SuperAdminPage = '/SuperAdminPage';
  static const savedCredentials = '/saved-credentials';
  static const products = '/products';

  static List sidebarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    profile,
    series,
    categories,
    customers,
    settings,
  ];
}
