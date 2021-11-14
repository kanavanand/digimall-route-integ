class HomeAnalytics {
  int products;
  int views, sales, orders;

  HomeAnalytics(this.orders, this.products, this.sales, this.views);

  HomeAnalytics.fromJson(Map<String, dynamic> map) {
    products = map['products'] as int;
    views = map['views'] as int;
    sales = map['sales'] as int;
    orders = map['orders'] as int;
  }

  HomeAnalytics.empty() {
    products = 0;
    views = 0;
    sales = 0;
    orders = 0;
  }
}
