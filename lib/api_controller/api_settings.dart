class ApiSettings {
  static const _baseUrl='https://arzaq.main-dev.com/api/v1/';
  static const login=_baseUrl+'accountApi/login';
  static const register=_baseUrl+'accountApi/registerUser';
  static const logout=_baseUrl+'logout';
  static const checkOtp=_baseUrl+'accountApi/check-code';
  static const reGenerateOtp=_baseUrl+'accountApi/resend-code';
  static const getConditions=_baseUrl+'general/conditions';
  static const sendForgetCode=_baseUrl+'accountApi/send-code';
  static const checkCodeForget=_baseUrl+'accountApi/checkCodeForget';
  static const resetPassword=_baseUrl+'accountApi/reset';
  static const getMyAuction=_baseUrl+'general/auctions';
  static const getProductType=_baseUrl+'general/products';
  static const contactUs=_baseUrl+'general/contact_us/create';
  static const addNewAuction=_baseUrl+'general/auctions/create';
  static const getCities=_baseUrl+'general/cities';
  static const getNotifications=_baseUrl+'general/getNotifications';
  static const getSupplyHomeData=_baseUrl+'general/home-screen';
  static const getSupplyMySales=_baseUrl+'general/my-sales';
  static const getSupplyInvoices=_baseUrl+'general/invoices/{id}';
  static const getSupplyAuctionDetail=_baseUrl+'general/auction-details/{id}';
  static const getSupplyWalletDetail=_baseUrl+'general/my-wallet';
  static const deleteAuction=_baseUrl+'general/{id}';
  //**************
  static const getMerchantHomeData=_baseUrl+'general/tajir/home-screen/{id}';
  static const getMyPurchases=_baseUrl+'general/tajir/my-purchases';
  static const getMerchantInvoices=_baseUrl+'general/tajir/invoices/{id}';
  static const getMerchantAuctionDetail=_baseUrl+'general/tajir/auction-details/{id}';
  static const merchantAddOffer=_baseUrl+'general/offers/{id}';
  static const getMarchantWalletDetail=_baseUrl+'general/tajir/my-wallet';
  static const AddMarchntWallet=_baseUrl+'general/tajir/myWallet/create';
  static const closedAuction=_baseUrl+'general/tajir/closeAuctions/{id}';

}