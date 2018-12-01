// Channel
const String kChannelIdentifier = 'shopify';

//Generic Filter Args
const String kArgPerPage = "perPage";
const String kArgPaginationValue = "paginationValue";
const String kArgSortBy = "sortBy";
const String kArgReverse = "reverse";

//Initialise Method Call
const String kMethodInitialize = "initialize";
const String kArgBaseDomain = "baseDomain";
const String kArgStorefrontAccessToken = "storeFrontAccessToken";
const String kArgApiKey = "apiKey";
const String kArgApiPassword = "apiPassword";

// Get Product List Method Call
const String kMethodGetProductList = "getProductList";

const String kArgKeyword = "keyword";
const String kArgExcludeKeyword = "excludeKeyword";

// Get Product Variant List Method Call
const String kMethodGetProductVariantList = "getProductVariantList";
const String kArgProductVariantIds = "productVariantIds";

// Search Product List Method Call
const String kMethodSearchProductList = "searchProductList";
const String kArgQuery = "query";

// Get Product Method Call
const String kMethodGetProduct = "getProduct";
const String kArgProductId = "productId";

//Get Category List Method Call
const String kMethodGetCategoryList = "getCategoryList";

//Get Category Details Method Call
const String kMethodGetCategoryDetails = "getCategoryDetails";
const String kArgCategoryId = "categoryId";

//Get Shop Info Method Call
const String kMethodGetShopInfo = "getShopInfo";

//Get Article List Method Call
const String kMethodGetArticleList = "getArticleList";

//Get Article Method Call
const String kMethodGetArticle = "getArticle"; // unused
const String kArgArticleId = "articleId";

//User Specific Arguments
const String kArgFirstName = "firstName";
const String kArgLastName = "lastName";
const String kArgEmail = "email";
const String kArgPassword = "password";
const String kArgPhone = "phone";

//SignUp Method Call
const String kMethodSignUp = "signUp";

//SignIn Method Call
const String kMethodSignIn = "signIn";

//SignOut Method Call
const String kMethodSignOut = "signOut";

//isLoggedIn Method Call
const String kMethodIsLoggedIn = "isLoggedIn";

//Forgot Password Method Call
const String kMethodForgotPassword = "forgotPassword";

//Change Password Method Call
const String kMethodChangePassword = "changePassword";

//Get Countries Method Call
const String kMethodGetCountries = "getCountries";

//Address related arguments
const String kArgAddress = "address";
const String kArgAddressJson = "addressJson";
const String kArgAddressId = "addressId";
const String kArgPrimaryAddress = "primaryAddress";
const String kArgSecondAddress = "secondAddress";
const String kArgCity = "city";
const String kArgState = "state";
const String kArgCountry = "country";
const String kArgZip = "zip";

//Get Customer Method Call
const String kMethodGetCustomer = "getCustomer";

//Get Customer Shipping Method Call
const String kMethodSetDefaultShippingAddress = "setDefaultShippingAddress";

//Get Customer Address Method Call
const String kMethodCreateCustomerAddress = "createCustomerAddress";

//Edit Customer Address Method Call
const String kMethodEditCustomerAddress = "editCustomerAddress";

//Get Customer Address Method Call
const String kMethodDeleteCustomerAddress = "deleteCustomerAddress";

//Edit Customer Info Method Call
const String kMethodEditCustomerInfo = "editCustomerInfo";

//Update Customer Settings Method Call
const String kMethodUpdateCustomerSettings = "updateCustomerSettings";

//Orders

// Get Orders Method Call

// Order Arguments
const String kArgOrderId = "orderId";
const String kMethodGetOrders = "getOrders";

// Checkout Arguments
const String kArgCheckout = "checkout";
const String kArgCheckoutId = "checkoutId";
const String kCartProductJson = "cartProductJson";

// Create Checkout Method Call
const String kMethodCreateCheckout = "createCheckout";

// Get Checkout  Method Call
const String kMethodGetCheckout = "getCheckout";

// Shipping
const String kArgTitle = "title";
const String kArgCurrency = "currency";
const String kArgQuantity = "quantity";
const String kArgPrice = "price";
const String kArgHandle = "handle";
const String kArgShippingRate = "shippingRate";

// Set Shipping Address Method Call
const String kMethodSetShippingAddress = "setShippingAddress";

// Get Shipping Rates Method Call
const String kMethodGetShippingRates = "getShippingRates";

// Select Shipping Rates Method Call
const String kMethodSelectShippingRate = "selectShippingRate";


// Payments - Card

// Card Arguments
const String kArgCardFirstName = "firstName";
const String kArgCardLastName = "lastName";
const String kArgCardNumber = "cardNumber";
const String kArgCardExpireMonth = "expireMonth";
const String kArgCardExpireYear = "expireYear";
const String kArgCardVerificationCode = "verificationCode";

const String kArgCreditCardValueToken = "creditCardValueToken";

// Get Accepted Card Types Method Call
const String kMethodGetAcceptedCardTypes = "getAcceptedCardTypes";

// Get Card Token Method Call
const String kMethodGetCardToken = "getCardToken";


// Checkout
const String kArgCheckoutJson = "checkoutJson";

// Checkout Arguments
const String kArgWebUrl = "webUrl";
const String kArgRequiresShipping = "requiresShipping";
const String kArgSubtotalPrice = "subtotalPrice";
const String kArgTotalPrice = "totalPrice";
const String kArgTaxPrice = "taxPrice";
const String kArgCheckoutCurrency = "currency";

// Complete Checkout By Card Method Call
const String kMethodCompleteCheckoutByCard = "completeCheckoutByCard";

//Unused
const String kArgCartProductList = "cartProductList";
const String kArgIsAcceptMarketing = "isAcceptMarketing";


