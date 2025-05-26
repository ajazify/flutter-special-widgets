import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Windows 8 Menu',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Segoe UI'),
      home: Windows8Menu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Windows8Menu extends StatefulWidget {
  const Windows8Menu({super.key});

  @override
  _Windows8MenuState createState() => _Windows8MenuState();
}

class _Windows8MenuState extends State<Windows8Menu> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<List<TileData>> _pages = [
    [
      TileData('Mail', Icons.mail, Colors.blue, TileSize.medium),
      TileData('Calendar', Icons.calendar_today, Colors.orange, TileSize.small),
      TileData('Weather', Icons.wb_sunny, Colors.amber, TileSize.small),
      TileData('Photos', Icons.photo_library, Colors.green, TileSize.extraLarge),
      TileData('Music', Icons.music_note, Colors.purple, TileSize.wide),
      TileData('Videos', Icons.video_library, Colors.red, TileSize.small),
      TileData('Maps', Icons.map, Colors.teal, TileSize.small),
      TileData('Store', Icons.shopping_bag, Colors.indigo, TileSize.large),
      TileData('News', Icons.article, Colors.blueGrey, TileSize.medium),
      TileData('Games', Icons.games, Colors.pink, TileSize.small),
      TileData('Office', Icons.work, Colors.deepOrange, TileSize.wide),
      TileData('Browser', Icons.web, Colors.cyan, TileSize.small),
    ],
    [
      TileData('Settings', Icons.settings, Colors.grey, TileSize.large),
      TileData('Phone', Icons.phone, Colors.green, TileSize.small),
      TileData('Messages', Icons.message, Colors.blue, TileSize.medium),
      TileData('Camera', Icons.camera_alt, Colors.black87, TileSize.extraLarge),
      TileData('Files', Icons.folder, Colors.orange, TileSize.medium),
      TileData('Calculator', Icons.calculate, Colors.deepPurple, TileSize.small),
      TileData('Clock', Icons.access_time, Colors.red, TileSize.small),
      TileData('Contacts', Icons.contacts, Colors.teal, TileSize.wide),
      TileData('Notes', Icons.note, Colors.yellow, TileSize.small),
      TileData('Drive', Icons.cloud, Colors.lightBlue, TileSize.medium),
    ],
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e1e1e),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  physics: ClampingScrollPhysics(),
                  pageSnapping: true,
                  itemBuilder: (context, pageIndex) {
                    return _buildTileGrid(_pages[pageIndex]);
                  },
                ),
              ),
            ),
            _buildPageIndicator(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Start',
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w300),
          ),
          Row(
            children: [
              Icon(Icons.search, color: Colors.white70, size: 24),
              SizedBox(width: 20),
              Icon(Icons.person, color: Colors.white70, size: 24),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTileGrid(List<TileData> tiles) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: StaggeredTileGrid(tiles: tiles),
      ),
    );
  }

  Widget buildTile(TileData tile, int index) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _fadeAnimation.value,
          child: GestureDetector(
            onTap: () => _onTileTap(tile),
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                  color: tile.color,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(tile.icon, color: Colors.white, size: _getIconSize(tile.size)),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        tile.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _getFontSize(tile.size),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: tile.size == TileSize.large ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  double _getIconSize(TileSize size) {
    switch (size) {
      case TileSize.small:
        return 24;
      case TileSize.medium:
        return 32;
      case TileSize.large:
        return 48;
      case TileSize.wide:
        return 36;
      case TileSize.extraLarge:
        return 56;
    }
  }

  double _getFontSize(TileSize size) {
    switch (size) {
      case TileSize.small:
        return 10;
      case TileSize.medium:
        return 12;
      case TileSize.large:
        return 16;
      case TileSize.wide:
        return 14;
      case TileSize.extraLarge:
        return 18;
    }
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.white : Colors.white30,
          ),
        );
      }),
    );
  }

  void _onTileTap(TileData tile) {
    // Add haptic feedback
    // HapticFeedback.lightImpact();

    // Show a snackbar or navigate to app
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening ${tile.title}...'),
        duration: Duration(seconds: 1),
        backgroundColor: tile.color,
      ),
    );
  }
}

class TileData {
  final String title;
  final IconData icon;
  final Color color;
  final TileSize size;

  TileData(this.title, this.icon, this.color, this.size);
}

enum TileSize { small, medium, large, wide, extraLarge }

class StaggeredTileGrid extends StatelessWidget {
  final List<TileData> tiles;

  const StaggeredTileGrid({super.key, required this.tiles});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double tileSize = (constraints.maxWidth - 32) / 4; // 4 columns with spacing

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tiles.map((tile) => _buildTileWithSize(tile, tileSize)).toList(),
        );
      },
    );
  }

  Widget _buildTileWithSize(TileData tile, double baseSize) {
    double width, height;

    switch (tile.size) {
      case TileSize.small:
        width = baseSize;
        height = baseSize;
        break;
      case TileSize.medium:
        width = baseSize;
        height = baseSize;
        break;
      case TileSize.large:
        width = baseSize * 2 + 8; // 2 tiles + 1 spacing
        height = baseSize * 2 + 8;
        break;
      case TileSize.wide:
        width = baseSize * 2 + 8; // 2 tiles wide
        height = baseSize;
        break;
      case TileSize.extraLarge:
        width = baseSize * 2 + 8;
        height = baseSize * 2 + 8;
        break;
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: tile.color, borderRadius: BorderRadius.circular(0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTileTap(tile),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tile.icon, color: Colors.white, size: _getIconSize(tile.size)),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  tile.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _getFontSize(tile.size),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _getIconSize(TileSize size) {
    switch (size) {
      case TileSize.small:
        return 24;
      case TileSize.medium:
        return 32;
      case TileSize.large:
        return 48;
      case TileSize.wide:
        return 36;
      case TileSize.extraLarge:
        return 56;
    }
  }

  double _getFontSize(TileSize size) {
    switch (size) {
      case TileSize.small:
        return 10;
      case TileSize.medium:
        return 12;
      case TileSize.large:
        return 16;
      case TileSize.wide:
        return 14;
      case TileSize.extraLarge:
        return 18;
    }
  }

  void _onTileTap(TileData tile) {
    // This would need to be passed from parent or use a callback
    if (kDebugMode) {
      print('Tapped ${tile.title}');
    }
  }
}
