# TT VPN App - Case Study

#### Flutter ile geliştirilmiş modern VPN uygulaması. Kullanıcıların farklı ülkelere güvenli bağlantı kurmalarını sağlayan, bağlantı istatistiklerini takip edebilecekleri kapsamlı bir mobil uygulama.Uygulama gerçek VPN bağlantısı kurmaz. Demonstrasyon amaçlı mock data kullanır.


### 📱 Özellikler

- Ülke Seçimi: 8 farklı ülke lokasyonu
- Gerçek Zamanlı İstatistikler: İndirme/yükleme hızı takibi
- Bağlantı Yönetimi: Kolay bağlanma/kesme işlemleri
- Tema Desteği: Açık/koyu tema seçenekleri
- Arama Özelliği: Ülke ve şehir bazında arama
- Animasyonlu UI: Akıcı geçişler ve durum animasyonları


### 🏗️ Mimari

#### Proje MVVM (Model-View-ViewModel) mimarisi ile GetX state management kullanılarak geliştirilmiştir.

- Model: Veri yapıları (Country, ConnectionStats)
- View: Flutter widget'ları (UI katmanı)
- ViewModel: GetX Controller'ları (iş mantığı ve state)
- GetX State Management: Reaktif state yönetimi ve dependency injection
- Observer Pattern: Reactive variables ile UI güncellemeleri


### 📦 Kullanılan Paketler

| Paket           | Versiyon |
|:----------------|:---------|
| get             | 4.6.6    |
| get_storage     | 2.1.1    |
| flutter_svg     | 2.0.9    |
| intl            | 0.19.0   |
| cupertino_icons | 1.0.6    |


### Paket Seçim Nedenleri

- GetX: Hafif, performanslı ve kolay kullanımlı state management
- GetStorage: SharedPreferences'a göre daha hızlı ve basit
- Flutter SVG: Vektörel ikonlar için retina kalitesi
- Intl: Çoklu dil desteği için gelecekteki genişleme


### 🚀 Kurulum

#### Gereksinimler

- Flutter SDK 3.10.0+
- Dart 3.0.0+

#### Adımlar

1. Projeyi klonlayın

- git clone https://github.com/kullaniciadi/tt_vpn_app.git
- cd tt_vpn_app

2. Bağımlılıkları yükleyin

- flutter pub get

3. Uygulamayı çalıştırın

- flutter run


### 🎮 Kullanım

#### Ana Özellikler

1. Ülke Bağlantısı

- Ana ekranda ülke listesinden seçim yapın
- Power butonuna tıklayarak bağlanın
- Bağlantı durumunu gerçek zamanlı takip edin


2. Ülke Arama

- Arama çubuğuna tıklayın
- Ülke veya şehir adı yazarak filtreleyin
- Listeden istediğiniz lokasyonu seçin


3. Ayarlar

- Alt menüden "Settings" sekmesine gidin
- Tema değiştirme (Açık/Koyu)
- VPN protokol seçimi
- Bildirim ayarları

<br><br>
***Bu proje case study amaçlı geliştirilmiştir.***



