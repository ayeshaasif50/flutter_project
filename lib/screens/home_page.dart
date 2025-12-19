// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../main.dart'; // 🩵 Access globalFavorites and globalCart
import 'menu_detail_page.dart'; // ✅ Product Detail Page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = ['Cappuccino', 'Espresso', 'Latte', 'Flat White'];
  int selectedCategory = 0;
  int _selectedIndex = 0;

  // All coffee data
  final List<Map<String, dynamic>> allCoffees = [
    {'title': 'Cappuccino', 'subtitle': 'With Oat Milk', 'price': '\$4.20', 'img': 'assets/coffee1.png'},
    {'title': 'Cappuccino', 'subtitle': 'With Chocolate', 'price': '\$3.14', 'img': 'assets/coffee2.png'},
    {'title': 'Latte', 'subtitle': 'Caramel Syrup', 'price': '\$3.80', 'img': 'assets/coffee3.png'},
    {'title': 'Americano', 'subtitle': 'Classic Brew', 'price': '\$2.90', 'img': 'assets/coffee9.png'},
    {'title': 'Mocha', 'subtitle': 'With Cream', 'price': '\$4.50', 'img': 'assets/coffee10.png'},
    {'title': 'Espresso Shot', 'subtitle': 'Strong & Bold', 'price': '\$2.50', 'img': 'assets/coffee4.png'},
    {'title': 'Iced Latte', 'subtitle': 'Cold & Refreshing', 'price': '\$3.60', 'img': 'assets/coffee5.png'},
    {'title': 'Mocha', 'subtitle': 'Chocolate Delight', 'price': '\$4.00', 'img': 'assets/coffee6.png'},
    {'title': 'Honey Almond Latte', 'subtitle': '', 'price': '\$3.99', 'img': 'assets/coffee7.png'},
    {'title': 'Caramel Macchiato', 'subtitle': '', 'price': '\$4.10', 'img': 'assets/coffee8.png'},
    {'title': 'Vanilla Sweet Cream Cold Brew', 'subtitle': '', 'price': '\$4.25', 'img': 'assets/coffee13.png'},
    {'title': 'Pumpkin Spice Latte', 'subtitle': '', 'price': '\$4.50', 'img': 'assets/coffee14.png'},
    {'title': 'Hazelnut Latte', 'subtitle': '', 'price': '\$3.90', 'img': 'assets/coffee12.png'},
    {'title': 'Cold Brew', 'subtitle': '', 'price': '\$3.20', 'img': 'assets/coffee11.png'},
  ];

  // Coffees displayed after search
  List<Map<String, dynamic>> displayedCoffees = [];

  @override
  void initState() {
    super.initState();
    displayedCoffees = List.from(allCoffees);
  }

  @override
  Widget build(BuildContext context) {
    final bg = Color(0xFFF5EDE0);
    final lightField = Color(0xFFF1DDD0);
    final cardBrown = Color(0xFFDDB59A);
    final darkBrown = Color(0xFF8C6542);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: darkBrown,
        elevation: 0,
        title: const Text(
          "Coffee Enyong ☕",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: bg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: darkBrown),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset('assets/coffee_logo.png', fit: BoxFit.cover, width: 60, height: 60),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Coffee Enyong",
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                  Text("Freshly brewed happiness", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home_filled, "Home", context),
            _buildDrawerItem(Icons.local_cafe, "Menu", context),
            _buildDrawerItem(Icons.favorite, "Favorites", context),
            _buildDrawerItem(Icons.shopping_cart, "My Cart", context),
            _buildDrawerItem(Icons.person, "Profile", context),
            _buildDrawerItem(Icons.history, "Order History", context),
            _buildDrawerItem(Icons.settings, "Settings", context),
            _buildDrawerItem(Icons.info_outline, "About Us", context),
            Divider(),
            _buildDrawerItem(Icons.logout, "Logout", context, color: Colors.redAccent),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header + search + profile
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find the best\ncoffee for you',
                            style: TextStyle(color: darkBrown, fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(color: lightField, borderRadius: BorderRadius.circular(14)),
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: darkBrown),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Find your coffee...',
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (query) {
                                      setState(() {
                                        displayedCoffees = allCoffees.where((coffee) {
                                          final title = coffee['title'].toLowerCase();
                                          final subtitle = coffee['subtitle'].toLowerCase();
                                          final input = query.toLowerCase();
                                          return title.contains(input) || subtitle.contains(input);
                                        }).toList();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/profile'),
                      child: CircleAvatar(radius: 24, backgroundColor: cardBrown, child: Icon(Icons.person, color: Colors.white)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 14),

              // Categories
              SizedBox(
                height: 36,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 12),
                  itemBuilder: (context, idx) {
                    final isSelected = idx == selectedCategory;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = idx),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? darkBrown : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          categories[idx],
                          style: TextStyle(
                            color: isSelected ? Colors.white : darkBrown,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 18),

              // Main coffee cards
              SizedBox(
                height: 220,
                child: displayedCoffees.isEmpty
                    ? Center(child: Text("No results found", style: TextStyle(color: darkBrown)))
                    : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  itemCount: displayedCoffees.length,
                  separatorBuilder: (_, __) => SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final coffee = displayedCoffees[index];
                    return _coffeeCard(coffee['title'], coffee['subtitle'], coffee['price'], 4.5, coffee['img']);
                  },
                ),
              ),

              SizedBox(height: 24),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Special for you',
                  style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 12),
              _specialCard(),

              SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Popular Now',
                  style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 170,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  scrollDirection: Axis.horizontal,
                  children: [
                    _miniCard('Espresso Shot', '\$2.50', 'assets/coffee4.png'),
                    SizedBox(width: 16),
                    _miniCard('Iced Latte', '\$3.60', 'assets/coffee5.png'),
                    SizedBox(width: 16),
                    _miniCard('Mocha', '\$4.00', 'assets/coffee6.png'),
                    SizedBox(width: 16),
                    _miniCard('Cold Brew', '\$3.20', 'assets/coffee11.png'),
                    SizedBox(width: 16),
                    _miniCard('Hazelnut Latte', '\$3.90', 'assets/coffee12.png'),
                  ],
                ),
              ),

              SizedBox(height: 30),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'New Arrivals',
                  style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  _listCard('Honey Almond Latte', '\$3.99', 'assets/coffee7.png'),
                  _listCard('Caramel Macchiato', '\$4.10', 'assets/coffee8.png'),
                  _listCard('Vanilla Sweet Cream Cold Brew', '\$4.25', 'assets/coffee13.png'),
                  _listCard('Pumpkin Spice Latte', '\$4.50', 'assets/coffee14.png'),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown[50],
        selectedItemColor: darkBrown,
        unselectedItemColor: Colors.brown[300],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Fav'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (i) {
          setState(() => _selectedIndex = i);
          switch (i) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/menu');
              break;
            case 2:
              Navigator.pushNamed(context, '/favorites');
              break;
            case 3:
              Navigator.pushNamed(context, '/cart');
              break;
          }
        },
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? Color(0xFF8C6542)),
      title: Text(title, style: TextStyle(color: color ?? Color(0xFF8C6542), fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context);
        switch (title) {
          case "Home":
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case "Menu":
            Navigator.pushNamed(context, '/menu');
            break;
          case "Favorites":
            Navigator.pushNamed(context, '/favorites');
            break;
          case "My Cart":
            Navigator.pushNamed(context, '/cart');
            break;
          case "Profile":
            Navigator.pushNamed(context, '/profile');
            break;
          case "Order History":
            Navigator.pushNamed(context, '/orderHistory');
            break;
          case "Settings":
            Navigator.pushNamed(context, '/settings');
            break;
          case "About Us":
            Navigator.pushNamed(context, '/about');
            break;
          case "Logout":
            Navigator.pushReplacementNamed(context, '/login');
            break;
        }
      },
    );
  }

  Widget _coffeeCard(String title, String subtitle, String price, double rating, String img) {
    final darkBrown = Color(0xFF8C6542);
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MenuDetailPage(item: {'name': title, 'image': img, 'price': price, 'desc': subtitle}),
        ),
      ),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.brown[50],
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: darkBrown.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 6))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                child: Image.asset(
                  img,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: Colors.brown[200], child: Icon(Icons.local_cafe, color: Colors.white, size: 40)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: TextStyle(color: darkBrown.withOpacity(0.8), fontSize: 12)),
                  Row(
                    children: [
                      Text(price, style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() => globalFavorites.add({'title': title, 'subtitle': subtitle, 'price': price, 'img': img}));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title added to favorites ❤️'), duration: Duration(seconds: 1)));
                        },
                        child: Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(color: darkBrown, borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.favorite, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniCard(String title, String price, String img) {
    final darkBrown = Color(0xFF8C6542);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MenuDetailPage(item: {'name': title, 'image': img, 'price': price, 'desc': ''}))),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: Colors.brown[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: darkBrown.withOpacity(0.08), blurRadius: 6, offset: Offset(0, 5))],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(img, height: 90, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.brown[200], child: Icon(Icons.coffee, color: Colors.white, size: 28))),
            ),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(color: darkBrown.withOpacity(0.8))),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _listCard(String title, String price, String img) {
    final darkBrown = Color(0xFF8C6542);
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MenuDetailPage(item: {'name': title, 'image': img, 'price': price, 'desc': ''}))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
            color: Colors.brown[50],
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: darkBrown.withOpacity(0.08), blurRadius: 6, offset: Offset(0, 5))],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(14)),
                child: Image.asset(img, width: 90, height: 90, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: Colors.brown[200], child: Icon(Icons.coffee, color: Colors.white, size: 28))),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(price, style: TextStyle(color: darkBrown.withOpacity(0.8))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _specialCard() {
    final darkBrown = Color(0xFF8C6542);
    final cardBrown = Color(0xFFDDB59A);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.brown[50],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: darkBrown.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 6))],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
              child: Image.asset('assets/special.png', width: 110, height: 110, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: cardBrown, width: 110, height: 110, child: Icon(Icons.local_cafe, color: Colors.white, size: 36))),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('5 Coffee Beans You Must Try!', style: TextStyle(color: darkBrown, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text('Discover beans we recommend for rich, nutty flavor.', style: TextStyle(color: darkBrown.withOpacity(0.8), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
