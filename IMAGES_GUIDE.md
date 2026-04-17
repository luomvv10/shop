# Hướng dẫn thêm ảnh sản phẩm

## 📁 Cấu trúc thư mục

Các ảnh sản phẩm được lưu trong thư mục: `assets/images/`

## 📸 Cách thêm ảnh

### 1. Chuẩn bị ảnh
- Lưu các file ảnh (.jpg, .png) vào thư mục `assets/images/`
- Tên file gợi ý: `product_1.jpg`, `product_2.jpg`, ... hoặc tên sản phẩm

### 2. Cập nhật dummy_data.dart

Mở file `lib/data/dummy_data.dart` và thêm `imageAsset` vào từng sản phẩm:

```dart
Product(
  id: 1,
  name: "Áo Thun Premium",
  image: "https://images.unsplash.com/...", // URL fallback
  imageAsset: 'assets/images/product_1.jpg', // ← Thêm dòng này
  price: 149000,
  ...
),
```

### 3. Ví dụ cấu trúc file

```
shop/
├── assets/
│   └── images/
│       ├── product_1.jpg   (Áo Thun Premium)
│       ├── product_2.jpg   (Giày Thể Thao)
│       ├── product_3.jpg   (Quần Jean)
│       ├── product_4.jpg   (Áo Khoác Denim)
│       ├── product_5.jpg   (Mũ Baseball)
│       └── product_6.jpg   (Túi Xách Da)
└── lib/
    └── data/
        └── dummy_data.dart
```

## 🎯 Cách hoạt động

- Nếu `imageAsset` được khai báo, app sẽ **ưu tiên tải ảnh cục bộ**
- Nếu ảnh cục bộ tải lỗi, app sẽ **tự động fallback sang URL Unsplash**
- Nếu không khai báo `imageAsset`, app sẽ dùng URL từ trường `image`

## 💡 Lợi ích

✅ Tải ảnh nhanh hơn (không cần internet)
✅ Không phụ thuộc vào Unsplash
✅ Có thể customized ảnh của riêng bạn
✅ Vẫn có fallback URL nếu cần

## 📝 Chú ý

- Độ phân giải ảnh khuyến nghị: 500x500px hoặc cao hơn
- Định dạng hỗ trợ: `.jpg`, `.jpeg`, `.png`, `.webp`
- Kích thước file nên < 500KB để tránh làm app quá lớn
