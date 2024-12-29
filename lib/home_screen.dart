import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart'; // Import login_screen untuk navigasi

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userEmail;
  TextEditingController searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<Map<String, dynamic>> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email');
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _addToCart(Map<String, dynamic> item) {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _cartItems.add({
          ...item,
          'startDate': _startDate,
          'endDate': _endDate,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item['name']} ditambahkan ke keranjang!'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue.shade700,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Pilih tanggal mulai dan akhir penyewaan terlebih dahulu!'),
          backgroundColor: Colors.red.shade700,
        ),
      );
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _endDate = pickedDate;
      });
    }
  }

  void _goToCart() {
    // Implementasi halaman keranjang harus dilakukan
    // Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartItems: _cartItems)));
  }

  final List<Map<String, dynamic>> campingItems = [
    {
      'name': 'Tenda',
      'description': 'Tenda camping untuk 4 orang',
      'image': 'image/tenda.png',
      'price': 200000,
      'stock': 10,
    },
    {
      'name': 'Sleeping Bag',
      'description': 'Sleeping bag hangat untuk malam dingin',
      'image': 'image/sb.png',
      'price': 150000,
      'stock': 15,
    },
    {
      'name': 'Kursi Lipat',
      'description': 'Kursi lipat praktis untuk camping',
      'image': 'image/kursi_lipat.png',
      'price': 75000,
      'stock': 20,
    },
    {
      'name': 'Matras',
      'description': 'Matras untuk kenyamanan tidur di alam',
      'image': 'image/matras.jpg',
      'price': 100000,
      'stock': 12,
    },
    {
      'name': 'Sepatu Gunung',
      'description': 'Sepatu gunung yang nyaman dan tahan lama',
      'image': 'image/sepatu.png',
      'price': 300000,
      'stock': 8,
    },
    {
      'name': 'Tas Gunung',
      'description': 'Tas gunung multifungsi untuk perjalanan jauh',
      'image': 'image/tas.png',
      'price': 250000,
      'stock': 5,
    },
    {
      'name': 'Lampu Kepala',
      'description': 'Lampu kepala untuk penerangan malam hari',
      'image': 'image/lampu.png',
      'price': 90000,
      'stock': 25,
    },
    // Tambahkan item lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda Sewa Alat Camping'),
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(
            icon: Image.asset(
              'image/keranjang.png',
              width: 30,
              height: 30,
            ),
            onPressed: _goToCart,
          ),
          IconButton(
            icon: Image.asset(
              'image/exit.png',
              width: 30,
              height: 30,
            ),
            onPressed: _logout,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.lightBlue.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang, ${userEmail ?? 'Pengguna'}!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _selectStartDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    _startDate == null
                        ? 'Pilih Tanggal Mulai'
                        : 'Tanggal Mulai: ${_startDate!.toLocal()}'
                            .split(' ')[0],
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectEndDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    _endDate == null
                        ? 'Pilih Tanggal Akhir'
                        : 'Tanggal Akhir: ${_endDate!.toLocal()}'.split(' ')[0],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Daftar Alat Camping Tersedia:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: campingItems.length,
                itemBuilder: (context, index) {
                  final item = campingItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(item['name']),
                      subtitle: Text(
                        '${item['description']}\nHarga: Rp ${item['price']}\nStok: ${item['stock']}',
                      ),
                      leading: Image.asset(
                        item['image'],
                        width: 40,
                        height: 40,
                      ),
                      trailing: ElevatedButton(
                        onPressed: item['stock'] > 0
                            ? () {
                                _addToCart(item);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Tambah'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
