import 'package:flutter/material.dart';

class IconPickerApp extends StatelessWidget {
  const IconPickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '图标选择',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const IconPickerPage(),
    );
  }
}

class IconPickerPage extends StatefulWidget {
  const IconPickerPage({super.key});

  @override
  State<IconPickerPage> createState() => _IconPickerPageState();
}

class _IconPickerPageState extends State<IconPickerPage> {
  final List<IconData> _icons = [];
  String _searchQuery = '';
  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _icons.addAll(_getAllMaterialIcons());
  }

  List<IconData> _getAllMaterialIcons() {
    return [
      Icons.abc,
      Icons.ac_unit,
      Icons.access_alarm,
      Icons.access_time,
      Icons.accessibility,
      Icons.zoom_in,
      Icons.zoom_out,
      Icons.add,
      Icons.remove,
      Icons.close,
      Icons.check,
      Icons.menu,
      Icons.arrow_back,
      Icons.arrow_forward,
      Icons.home,
      Icons.settings,
      Icons.search,
      Icons.favorite,
      Icons.star,
      Icons.person,
      Icons.email,
      Icons.phone,
      Icons.notifications,
    ];
  }

  List<IconData> get _filteredIcons {
    if (_searchQuery.isEmpty) {
      return _icons;
    }
    return _icons.where((icon) {
      final iconName = icon.toString().toLowerCase();
      return iconName.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('选择图标'),
        actions: [
          if (_selectedIcon != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, _selectedIcon);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: '搜索图标',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _filteredIcons.length,
              itemBuilder: (context, index) {
                final icon = _filteredIcons[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIcon = icon;
                    });
                  },

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 30),
                      const SizedBox(height: 8),
                      Text(
                        icon.toString().split('.')[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
