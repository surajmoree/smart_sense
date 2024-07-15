import 'package:flutter/material.dart';
import 'package:smart_sense/config.dart';


class SiteIdNotifier extends ChangeNotifier {
  
  int? _siteId;

  int? get siteId => _siteId;

  Future<void> loadSiteId() async {
    String? siteIdString = await storage.read(key: 'site_id');
    _siteId = siteIdString != null ? int.tryParse(siteIdString) : null;
    notifyListeners();
  }

  Future<void> saveSiteId(int siteId) async {
    _siteId = siteId;
    await storage.write(key: 'site_id', value: siteId.toString());
    notifyListeners();
  }
}

final siteIdNotifier = SiteIdNotifier();
