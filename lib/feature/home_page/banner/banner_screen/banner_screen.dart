import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redeem/feature/home_page/banner/banner_model/banner_model.dart';
import 'package:redeem/feature/home_page/banner/banner_service/banner_service.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final BannerService _bannerService = BannerService();
  List<BannerModel> _banners = [];
  bool _isLoading = true;
  int _currentIndex = 0; // To track the current page for dots

  @override
  void initState() {
    super.initState();
    _loadBanners();
  }

  Future<void> _loadBanners() async {
    try {
      final banners = await _bannerService.fetchBannerData();
      setState(() {
        _banners = banners;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading banners: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _banners.isEmpty
              ? const Center(child: Text('No banners available'))
              : Column(
                children: [
                  Expanded(
                    // Use Expanded to constrain the height
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 250.h,
                        autoPlay: true,
                        enlargeCenterPage: false,
                        viewportFraction: 1, // slight margin at edges
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items:
                          _banners.map((banner) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                12,
                                12,
                                12,
                                12,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  banner.image,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Center(
                                            child: Icon(Icons.error),
                                          ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _banners.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _currentIndex == index
                                  ? Colors.black
                                  : Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
