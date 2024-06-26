// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:digitalproductstore/config/ps_config.dart';
import 'package:intl/intl.dart';

const String THEME__IS_DARK_THEME = 'THEME__IS_DARK_THEME';

const String LANGUAGE__LANGUAGE_CODE_KEY = 'LANGUAGE__LANGUAGE_CODE_KEY';
const String LANGUAGE__COUNTRY_CODE_KEY = 'LANGUAGE__COUNTRY_CODE_KEY';
const String LANGUAGE__LANGUAGE_NAME_KEY = 'LANGUAGE__LANGUAGE_NAME_KEY';

const String APP_INFO__END_DATE_KEY = 'END_DATE';
const String APP_INFO__START_DATE_KEY = 'START_DATE';
const String APPINFO_PREF_VERSION_NO = 'APPINFO_PREF_VERSION_NO';
const String APPINFO_PREF_FORCE_UPDATE = 'APPINFO_PREF_FORCE_UPDATE';
const String APPINFO_FORCE_UPDATE_MSG = 'APPINFO_FORCE_UPDATE_MSG';
const String APPINFO_FORCE_UPDATE_TITLE = 'APPINFO_FORCE_UPDATE_TITLE';

const String FILTERING__DESC = 'desc'; // Don't Change
const String FILTERING__ASC = 'asc'; // Don't Change
const String FILTERING__ADDED_DATE = 'added_date'; // Don't Change
const String FILTERING__TRENDING = 'touch_count'; // Don't Change
const String ONE = '1';
const String FILTERING_FEATURE = 'featured_date';
const String FILTERING_TRENDING = 'touch_count';

const String PLATFORM = 'android';

const String RATING_ONE = '1';
const String RATING_TWO = '2';
const String RATING_THREE = '3';
const String RATING_FOUR = '4';
const String RATING_FIVE = '5';

const String IS_DISCOUNT = '1';
const String IS_FEATURED = '1';
const String IS_FREE = '1';
const String ZERO = '0';

const String FILTERING_PRICE = 'unit_price';

const String VALUE_HOLDER__USER_ID = 'USERID';
const String VALUE_HOLDER__NOTI_TOKEN = 'NOTI_TOKEN';
const String VALUE_HOLDER__NOTI_SETTING = 'NOTI_SETTING';
const String VALUE_HOLDER__USER_ID_TO_VERIFY = 'USERIDTOVERIFY';
const String VALUE_HOLDER__USER_NAME_TO_VERIFY = 'USER_NAME_TO_VERIFY';
const String VALUE_HOLDER__USER_EMAIL_TO_VERIFY = 'USER_EMAIL_TO_VERIFY';
const String VALUE_HOLDER__USER_PASSWORD_TO_VERIFY = 'USER_PASSWORD_TO_VERIFY';
const String VALUE_HOLDER__START_DATE = 'START_DATE';
const String VALUE_HOLDER__END_DATE = 'END_DATE';
const String VALUE_HOLDER__PAYPAL_ENABLED = 'PAYPAL_ENABLED';
const String VALUE_HOLDER__STRIPE_ENABLED = 'STRIPE_ENABLED';
const String VALUE_HOLDER__COD_ENABLED = 'COD_ENABLED';
const String VALUE_HOLDER__BANK_TRANSFER_ENABLE = 'BANK_TRANSFER_ENABLE';
const String VALUE_HOLDER__PUBLISH_KEY = 'PUBLISH_KEY';

const String CALL_BACK_EDIT_TO_PROFILE = 'CALL_BACK_EDIT_TO_PROFILE';

const String CATEGORY_ID = 'cat_id';
const String SUB_CATEGORY_ID = 'sub_cat_id';

const String CONST_CATEGORY = 'category';
const String CONST_SUB_CATEGORY = 'subcategory';
const String CONST_PRODUCT = 'product';

const String VALUE_HOLDER__OVERALL_TAX_LABEL = 'OVERALL_TAX_LABEL';
const String VALUE_HOLDER__OVERALL_TAX_VALUE = 'OVERALL_TAX_VALUE';
const String VALUE_HOLDER__SHIPPING_TAX_LABEL = 'SHIPPING_TAX_LABEL';
const String VALUE_HOLDER__SHIPPING_TAX_VALUE = 'SHIPPING_TAX_VALUE';

const String FILTERING_TYPE_NAME_PRODUCT = 'product';
const String FILTERING_TYPE_NAME_CATEGORY = 'category';

const int REQUEST_CODE__MENU_USER_PROFILE_FRAGMENT = 1001;
const int REQUEST_CODE__MENU_FORGOT_PASSWORD_FRAGMENT = 1002;
const int REQUEST_CODE__MENU_REGISTER_FRAGMENT = 1003;
const int REQUEST_CODE__MENU_VERIFY_EMAIL_FRAGMENT = 1004;
const int REQUEST_CODE__MENU_HOME_FRAGMENT = 1005;
const int REQUEST_CODE__MENU_LATEST_PRODUCT_FRAGMENT = 1006;
const int REQUEST_CODE__MENU_DISCOUNT_PRODUCT_FRAGMENT = 1007;
const int REQUEST_CODE__MENU_FEATURED_PRODUCT_FRAGMENT = 1008;
const int REQUEST_CODE__MENU_TRENDING_PRODUCT_FRAGMENT = 1009;
const int REQUEST_CODE__MENU_COLLECTION_FRAGMENT = 1010;
const int REQUEST_CODE__MENU_SELECT_WHICH_USER_FRAGMENT = 1011;
const int REQUEST_CODE__MENU_LANGUAGE_FRAGMENT = 1012;
const int REQUEST_CODE__MENU_SETTING_FRAGMENT = 1013;
const int REQUEST_CODE__MENU_LOGIN_FRAGMENT = 1014;
const int REQUEST_CODE__MENU_BLOG_FRAGMENT = 1015;
const int REQUEST_CODE__MENU_FAVOURITE_FRAGMENT = 1016;
const int REQUEST_CODE__MENU_TRANSACTION_FRAGMENT = 1017;
const int REQUEST_CODE__MENU_USER_HISTORY_FRAGMENT = 1018;
const int REQUEST_CODE__MENU_PURCHASED_PRODUCT_FRAGMENT = 1019;
const int REQUEST_CODE__MENU_CATEGORY_FRAGMENT = 1020;
const int REQUEST_CODE__MENU_CONTACT_US_FRAGMENT = 1021;
const int REQUEST_CODE__MENU_PHONE_SIGNIN_FRAGMENT = 1022;
const int REQUEST_CODE__MENU_PHONE_VERIFY_FRAGMENT = 1023;
const int REQUEST_CODE__MENU_FB_SIGNIN_FRAGMENT = 1024;
const int REQUEST_CODE__MENU_GOOGLE_VERIFY_FRAGMENT = 1025;

const int REQUEST_CODE__DASHBOARD_USER_PROFILE_FRAGMENT = 2001;
const int REQUEST_CODE__DASHBOARD_FORGOT_PASSWORD_FRAGMENT = 2002;
const int REQUEST_CODE__DASHBOARD_REGISTER_FRAGMENT = 2003;
const int REQUEST_CODE__DASHBOARD_VERIFY_EMAIL_FRAGMENT = 2004;
const int REQUEST_CODE__DASHBOARD_SHOP_INFO_FRAGMENT = 2005;
const int REQUEST_CODE__DASHBOARD_SELECT_WHICH_USER_FRAGMENT = 2006;
const int REQUEST_CODE__DASHBOARD_SEARCH_FRAGMENT = 2007;
const int REQUEST_CODE__DASHBOARD_BASKET_FRAGMENT = 2008;
const int REQUEST_CODE__DASHBOARD_LOGIN_FRAGMENT = 2009;
const int REQUEST_CODE__DASHBOARD_PHONE_SIGNIN_FRAGMENT = 2010;
const int REQUEST_CODE__DASHBOARD_PHONE_VERIFY_FRAGMENT = 2011;
const int REQUEST_CODE__DASHBOARD_FB_SIGNIN_FRAGMENT = 2012;
const int REQUEST_CODE__DASHBOARD_GOOGLE_VERIFY_FRAGMENT = 2013;

final NumberFormat psFormat = NumberFormat(priceFormat);
