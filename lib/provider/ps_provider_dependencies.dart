import 'package:digitalproductstore/db/basket_dao.dart';
import 'package:digitalproductstore/db/category_map_dao.dart';
import 'package:digitalproductstore/db/comment_detail_dao.dart';
import 'package:digitalproductstore/db/comment_header_dao.dart';
import 'package:digitalproductstore/db/favourite_product_dao.dart';
import 'package:digitalproductstore/db/gallery_dao.dart';
import 'package:digitalproductstore/db/history_dao.dart';
import 'package:digitalproductstore/db/product_collection_header_dao.dart';
import 'package:digitalproductstore/db/purchased_product_dao.dart';
import 'package:digitalproductstore/db/rating_dao.dart';
import 'package:digitalproductstore/db/user_dao.dart';
import 'package:digitalproductstore/db/related_product_dao.dart';
import 'package:digitalproductstore/db/user_login_dao.dart';
import 'package:digitalproductstore/repository/Common/notification_repository.dart';
import 'package:digitalproductstore/repository/basket_repository.dart';
import 'package:digitalproductstore/repository/clear_all_data_repository.dart';
import 'package:digitalproductstore/repository/comment_detail_repository.dart';
import 'package:digitalproductstore/repository/comment_header_repository.dart';
import 'package:digitalproductstore/repository/contact_us_repository.dart';
import 'package:digitalproductstore/repository/coupon_discount_repository.dart';
import 'package:digitalproductstore/repository/gallery_repository.dart';
import 'package:digitalproductstore/repository/history_repsitory.dart';
import 'package:digitalproductstore/repository/product_collection_repository.dart';
import 'package:digitalproductstore/db/blog_dao.dart';
import 'package:digitalproductstore/db/shop_info_dao.dart';
import 'package:digitalproductstore/db/transaction_detail_dao.dart';
import 'package:digitalproductstore/db/transaction_header_dao.dart';
import 'package:digitalproductstore/repository/blog_repository.dart';
import 'package:digitalproductstore/repository/rating_repository.dart';
import 'package:digitalproductstore/repository/shop_info_repository.dart';
import 'package:digitalproductstore/repository/tansaction_detail_repository.dart';
import 'package:digitalproductstore/repository/transaction_header_repository.dart';
import 'package:digitalproductstore/repository/user_repository.dart';
import 'package:digitalproductstore/viewobject/common/ps_value_holder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:digitalproductstore/api/ps_api_service.dart';
import 'package:digitalproductstore/db/cateogry_dao.dart';
import 'package:digitalproductstore/db/common/ps_shared_preferences.dart';
import 'package:digitalproductstore/db/noti_dao.dart';
import 'package:digitalproductstore/db/sub_category_dao.dart';
import 'package:digitalproductstore/db/product_dao.dart';
import 'package:digitalproductstore/db/product_map_dao.dart';
import 'package:digitalproductstore/repository/app_info_repository.dart';
import 'package:digitalproductstore/repository/category_repository.dart';
import 'package:digitalproductstore/repository/language_repository.dart';
import 'package:digitalproductstore/repository/noti_repository.dart';
import 'package:digitalproductstore/repository/product_repository.dart';
import 'package:digitalproductstore/repository/ps_theme_repository.dart';
import 'package:digitalproductstore/repository/sub_category_repository.dart';

List<SingleChildCloneableWidget> providers = <SingleChildCloneableWidget>[
  ...independentProviders,
  ..._dependentProviders,
  ..._valueProviders,
];

List<SingleChildCloneableWidget> independentProviders =
    <SingleChildCloneableWidget>[
  Provider<PsSharedPreferences>.value(value: PsSharedPreferences.instance),
  Provider<PsApiService>.value(value: PsApiService()),
  Provider<CategoryDao>.value(value: CategoryDao()),
  Provider<CategoryMapDao>.value(value: CategoryMapDao.instance),
  Provider<SubCategoryDao>.value(
      value: SubCategoryDao()), //wrong type not contain instance
  Provider<ProductDao>.value(
      value: ProductDao.instance), //correct type with instance
  Provider<ProductMapDao>.value(value: ProductMapDao.instance),
  Provider<NotiDao>.value(value: NotiDao.instance),
  Provider<ProductCollectionDao>.value(value: ProductCollectionDao.instance),
  Provider<ShopInfoDao>.value(value: ShopInfoDao.instance),
  Provider<BlogDao>.value(value: BlogDao.instance),
  Provider<TransactionHeaderDao>.value(value: TransactionHeaderDao.instance),
  Provider<TransactionDetailDao>.value(value: TransactionDetailDao.instance),
  Provider<UserDao>.value(value: UserDao.instance),
  Provider<UserLoginDao>.value(value: UserLoginDao.instance),
  Provider<RelatedProductDao>.value(value: RelatedProductDao.instance),
  Provider<CommentHeaderDao>.value(value: CommentHeaderDao.instance),
  Provider<CommentDetailDao>.value(value: CommentDetailDao.instance),
  Provider<RatingDao>.value(value: RatingDao.instance),

  // Provider<FavouriteDao>.value(value: FavouriteDao.instance),
  Provider<HistoryDao>.value(value: HistoryDao.instance),
  Provider<GalleryDao>.value(value: GalleryDao.instance),
  Provider<BasketDao>.value(value: BasketDao.instance),
  Provider<PurchasedProductDao>.value(value: PurchasedProductDao.instance),
  Provider<FavouriteProductDao>.value(value: FavouriteProductDao.instance),

  // ChangeNotifierProvider(update: (_) => SubCategoryProvider()),
];

List<SingleChildCloneableWidget> _dependentProviders =
    <SingleChildCloneableWidget>[
  ProxyProvider<PsSharedPreferences, PsThemeRepository>(
    update: (_, PsSharedPreferences ssSharedPreferences,
            PsThemeRepository psThemeRepository) =>
        PsThemeRepository(psSharedPreferences: ssSharedPreferences),
  ),
  // ProxyProvider<PsSharedPreferences, AppDataRepository>(
  //   update: (_, ssSharedPreferences, appDataRepository) =>
  //       AppDataRepository(psSharedPreferences: ssSharedPreferences),
  // ),
  ProxyProvider<PsApiService, AppInfoRepository>(
    update:
        (_, PsApiService psApiService, AppInfoRepository appInfoRepository) =>
            AppInfoRepository(psApiService: psApiService),
  ),
  ProxyProvider<PsSharedPreferences, LanguageRepository>(
    update: (_, PsSharedPreferences ssSharedPreferences,
            LanguageRepository languageRepository) =>
        LanguageRepository(psSharedPreferences: ssSharedPreferences),
  ),
  ProxyProvider2<PsApiService, CategoryDao, CategoryRepository>(
    update: (_, PsApiService psApiService, CategoryDao categoryDao,
            CategoryRepository categoryRepository2) =>
        CategoryRepository(
            psApiService: psApiService, categoryDao: categoryDao),
  ),
  ProxyProvider2<PsApiService, SubCategoryDao, SubCategoryRepository>(
    update: (_, PsApiService psApiService, SubCategoryDao subCategoryDao,
            SubCategoryRepository subCategoryRepository) =>
        SubCategoryRepository(
            psApiService: psApiService, subCategoryDao: subCategoryDao),
  ),
  ProxyProvider2<PsApiService, ProductCollectionDao,
      ProductCollectionRepository>(
    update: (_,
            PsApiService psApiService,
            ProductCollectionDao productCollectionDao,
            ProductCollectionRepository productCollectionRepository) =>
        ProductCollectionRepository(
            psApiService: psApiService,
            productCollectionDao: productCollectionDao),
  ),
  ProxyProvider2<PsApiService, ProductDao, ProductRepository>(
    update: (_, PsApiService psApiService, ProductDao productDao,
            ProductRepository categoryRepository2) =>
        ProductRepository(psApiService: psApiService, productDao: productDao),
  ),
  ProxyProvider2<PsApiService, NotiDao, NotiRepository>(
    update: (_, PsApiService psApiService, NotiDao notiDao,
            NotiRepository notiRepository) =>
        NotiRepository(psApiService: psApiService, notiDao: notiDao),
  ),
  ProxyProvider2<PsApiService, ShopInfoDao, ShopInfoRepository>(
    update: (_, PsApiService psApiService, ShopInfoDao shopInfoDao,
            ShopInfoRepository shopInfoRepository) =>
        ShopInfoRepository(
            psApiService: psApiService, shopInfoDao: shopInfoDao),
  ),
  ProxyProvider<PsApiService, NotificationRepository>(
    update:
        (_, PsApiService psApiService, NotificationRepository userRepository) =>
            NotificationRepository(
      psApiService: psApiService,
    ),
  ),
  ProxyProvider3<PsApiService, UserDao, UserLoginDao, UserRepository>(
    update: (_, PsApiService psApiService, UserDao userDao,
            UserLoginDao userLoginDao, UserRepository userRepository) =>
        UserRepository(
            psApiService: psApiService,
            userDao: userDao,
            userLoginDao: userLoginDao),
  ),

  ProxyProvider2<PsApiService, BlogDao, ClearAllDataRepository>(
    update: (_, PsApiService psApiService, BlogDao blogDao,
            ClearAllDataRepository blogRepository) =>
        ClearAllDataRepository(blogDao: blogDao),
  ),

  ProxyProvider2<PsApiService, BlogDao, BlogRepository>(
    update: (_, PsApiService psApiService, BlogDao blogDao,
            BlogRepository blogRepository) =>
        BlogRepository(psApiService: psApiService, blogDao: blogDao),
  ),
  ProxyProvider2<PsApiService, TransactionHeaderDao,
      TransactionHeaderRepository>(
    update: (_,
            PsApiService psApiService,
            TransactionHeaderDao transactionHeaderDao,
            TransactionHeaderRepository transactionRepository) =>
        TransactionHeaderRepository(
            psApiService: psApiService,
            transactionHeaderDao: transactionHeaderDao),
  ),
  ProxyProvider2<PsApiService, TransactionDetailDao,
      TransactionDetailRepository>(
    update: (_,
            PsApiService psApiService,
            TransactionDetailDao transactionDetailDao,
            TransactionDetailRepository transactionDetailRepository) =>
        TransactionDetailRepository(
            psApiService: psApiService,
            transactionDetailDao: transactionDetailDao),
  ),

  // ProxyProvider2<PsApiService, RelatedProductDao, RelatedProductRepository>(
  //   update: (_, PsApiService psApiService, RelatedProductDao relatedProductDao,
  //           RelatedProductRepository relatedProductRepository) =>
  //       RelatedProductRepository(
  //           psApiService: psApiService, relatedProductDao: relatedProductDao),
  // ),
  ProxyProvider2<PsApiService, CommentHeaderDao, CommentHeaderRepository>(
    update: (_, PsApiService psApiService, CommentHeaderDao commentHeaderDao,
            CommentHeaderRepository commentHeaderRepository) =>
        CommentHeaderRepository(
            psApiService: psApiService, commentHeaderDao: commentHeaderDao),
  ),
  ProxyProvider2<PsApiService, CommentDetailDao, CommentDetailRepository>(
    update: (_, PsApiService psApiService, CommentDetailDao commentDetailDao,
            CommentDetailRepository commentHeaderRepository) =>
        CommentDetailRepository(
            psApiService: psApiService, commentDetailDao: commentDetailDao),
  ),

  ProxyProvider2<PsApiService, RatingDao, RatingRepository>(
    update: (_, PsApiService psApiService, RatingDao ratingDao,
            RatingRepository ratingRepository) =>
        RatingRepository(psApiService: psApiService, ratingDao: ratingDao),
  ),

  ProxyProvider2<PsApiService, HistoryDao, HistoryRepository>(
    update: (_, PsApiService psApiService, HistoryDao historyDao,
            HistoryRepository historyRepository) =>
        HistoryRepository(historyDao: historyDao),
  ),

  ProxyProvider2<PsApiService, GalleryDao, GalleryRepository>(
    update: (_, PsApiService psApiService, GalleryDao galleryDao,
            GalleryRepository galleryRepository) =>
        GalleryRepository(galleryDao: galleryDao, psApiService: psApiService),
  ),

  ProxyProvider<PsApiService, ContactUsRepository>(
    update: (_, PsApiService psApiService,
            ContactUsRepository apiStatusRepository) =>
        ContactUsRepository(psApiService: psApiService),
  ),

  ProxyProvider2<PsApiService, BasketDao, BasketRepository>(
    update: (_, PsApiService psApiService, BasketDao basketDao,
            BasketRepository historyRepository) =>
        BasketRepository(basketDao: basketDao),
  ),

  // ProxyProvider2<PsApiService, PurchasedProductDao, PurchasedProductRepository>(
  //   update: (_,
  //           PsApiService psApiService,
  //           PurchasedProductDao purchasedProductDao,
  //           PurchasedProductRepository purchasedProductRepository) =>
  //       PurchasedProductRepository(
  //           purchasedProductDao: purchasedProductDao,
  //           psApiService: psApiService),
  // ),

  ProxyProvider<PsApiService, CouponDiscountRepository>(
    update: (_, PsApiService psApiService,
            CouponDiscountRepository couponDiscountRepository) =>
        CouponDiscountRepository(psApiService: psApiService),
  ),
];

// List<SingleChildCloneableWidget> _valueProviders =
//     <SingleChildCloneableWidget>[];

// List<SingleChildCloneableWidget> _uiConsumableProviders =
//     <SingleChildCloneableWidget>[
//   StreamProvider<String>(
//     update: (BuildContext context) =>
//         Provider.of<PsSharedPreferences>(context, listen: false).userId,
//   )
// ];

List<SingleChildCloneableWidget> _valueProviders = <SingleChildCloneableWidget>[
  StreamProvider<PsValueHolder>(
    create: (BuildContext context) =>
        Provider.of<PsSharedPreferences>(context, listen: false).psValueHolder,
  )
];
