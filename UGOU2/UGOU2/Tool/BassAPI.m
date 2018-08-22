//
//  BassAPI.m
//  BAssAPI
//
//  Created by shl on 16/1/8.
//  Copyright © 2016年 shl. All rights reserved.
//

#import "BassAPI.h"

@implementation BassAPI
+(NSString *)requestUrlWithPorType:(PortType)aType{
     NSString*requstUrl=@"";
    switch (aType) {
        case PortTypeQuerydays:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_QUERY_DAYS];
            break;
        case PortTypeSign:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SIGN];
            break;
        case PortTypeQuerymall:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_QUERY_MALL];
            break;

        case PortTypeUcoin:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_U_COIN];
            break;
        case PortTypeForgoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_FOR_GOODS];
            break;
        case PortTypeoNearbystores:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEARYBYS_STORES];
            break;
        case PortTypeStoregoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_STORE_GOODS];
            break;
        case  PortTypeShoppingcart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SHOP_CART];
            break;
        case  PortTypeDeletecart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELEGE_CART];
            break;
        case PortTypeIDMakecart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ID_MAKE_CART];
            break;
        case  PortTypeOrdersave:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ORDER_SAVE];
            break;
        case  PortTypeOrderlist:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ORDER_LIST];
            break;
        case PortTypeComecart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_COME_CART];
            break;
        case PortTypeDeleteComecart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELEGE_COME_CART];
            break;
        case PortTypeIDComecart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ID_COME_CART];
            break;
        case PortTypeSaveComecart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_COME_CARY];
            break;
        case PortTypeDeletestoreorde:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELEGE_STORE_ORDE];
            break;
            
        case PortTypeDeleteComeorde:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELEGE_COME_ORDE];
            break;
            
        case PortTypeComePaySucess:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_COME_PAY_SUCESS];
            break;
            
        case PortTypetSorePaySucess:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SORE_PAY_SUCESS];
            break;
            
        case PortTypeDoororderlist:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DOOR_ORDER_LIST];
            break;
            
        case PortTypeSavefeedback:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_FEEDBACK];
            break;
        case PortTypeSearchGoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SEARCH_GODDS];
            break;
        case PortTypeSaveBrand:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_BRAND];
            break;
        case PortTypeSaveGoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_GOODS];
            break;
        case PortTypeSelectBrand:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_BRAND];
            break;
        case PortTypeSelctGoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_GOODS];
            break;
        case PortTypeSaveEvaluate:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_EVALUATE];
            break;
        case PortTypeSelectEvaluate:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_EVALUATE];
            break;
        case PortTypeSaveCustomer:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_CUSTOMER];
            break;
        case PortTypeSelectTheme:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_THEME];
            break;
        case PortTypeSelectInsider:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_INSIDER];
            break;
        case PortTypeSelectrGenera:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_GENERAL];
            break;
        case PortTypeSaveGenera:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_GENERAL];
            break;
        case PortTypeSaveCart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_CART];
            break;
        case PortTypeSelectCart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_GART];
            break;
        case PortTypeDeletpuCart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELET_PUGART];
            break;
        case PortTypeGetReg:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_REG];
            break;
        case PortTypeGetLog:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_LOG];
            break;
        case PortTypeGetSdkLog:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SDKLOG];
            break;
        case PortTypeGetGoodsId:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_GOODSID];
            break;
        case PortTypeSavePuOrder:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_PUORDER];
            break;
        case PortTypeSelectPuOrderList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_PUORDER_LIST];
            break;
        case PortTypeDelectPuOrderList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELECT_PUORDER_LIST];
            break;
        case PortTypeSaveAddress:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SAVE_ADD_ADRESS];
            break;
        case PortTypeDelegetAddress:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DELEGET_ADRESS];
            break;
        case PortTypeSelectBrandList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_BRAND_LIST];
            break;
        case PortTypeConGoodOrder:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_CON_GOOD_ORDER];
            break;
        case PortTypegetAddressList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ADRESS_LIST];
            break;
        case PortTypeReturnClient:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_RETUREN_CLIENT];
            break;
        case PortTypeGetHome:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_HOME];
            break;
        case PortTypeGetHomeReList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_HOME_RELIST];
            break;
        case PortTypeDefaultAdress:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_DEFAULT_ADRESS];
            break;
        case PortTypeGetUpPass:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_UPPASS];
            break;
        case PortTypeGetUpMobile:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_UPMOBLIE];
            break;
//        case PortTypeGetGoodsIds:
//            requstUrl=[BASEURL stringByAppendingString:URL_GET_GOODS_IDS];
//            break;
        case PortTypeGetUpHeadimg:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_UPHEADIMG];
            break;
        case PortTypeGetUpUser:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_UPUSER];
            break;
        case PortTypeUpAddress:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_UP_ADRESS];
            break;
        case PortTypeSelectrMDGenera:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_MDGENERA];
            break;
        case PortTypeShareGenera:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SHARE_GENERA];
            break;
        case PortTypeManJain:
            requstUrl=[BASEURL  stringByAppendingString:URL_GET_MAIN_JIAN];
            break;
        case PortTypeABatchSaveUser:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ABTCH_SAVAUSER];
            break;
        case PortTypeChargeldPing:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SELECT_PING];
            break;
        case PortTypeActivityRegular:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ACTIVITY_REGULA];
            break;
         case PortTypeSmOrderStatusList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SMORDER_STAYUS_LIST];
            break;
        case PortTypeSmOrderDelete:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SMORDER_DELETE_LIST];
            break;
        case PortTypeStartpicture:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_START_PICTURE_LIST];
            break;
        case PortTypeReturegoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_START_RETURE_GOODS];
            break;
        case PortTypeGetChinaplace:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_CHAIN_PALCE];
            break;
        case PortTypeGetUservip:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_USER_VIP];
            break;
      case PortTypeNewSelectCart:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_SHOOPING_CARD];
            break;
        case PortTypeNewMJOrderType:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_ORDER_TYPE];
            break;
        case PortTypeNewChargeOrderType:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_CHARGE_ORDER_TYPE];
            break;
        case PortTypeNewOrderSaveType:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_ORDER_SAVE];
            break;
        case PortTypeNewSmOrderSaveType:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_SMOEDER_SAVE];
            break;
        case PortTypeNewYyOrderSaveType:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_ORDER_DDSAVE];
            break;
        case PortTypeChangePassWorde:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_CHANGER_PASSWORDE];
            break;
        case PortTypeVerifyThreeLogin:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_VERIFY_THREE_LOGIN];
            break;
        case PortTypeGetForYear:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_GET_FOR_YEARS];
            break;
        case PortTypeSendToSMS:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_SEND_SMS];
            break;
        case PortTypeCommitToSMS:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_COMMIT_SMS];
            break;
        case PortTypeUpdataVerson:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_UPDATA_VERSON];
            break;
        case PortTypeActivityZone:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NENW_ACTIVITY_ZONE];
            break;
        case PortTypeActivityGoods:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_ACTIVITY_GOOODS];
            break;
        case PortTypeVideoList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_VIDEO_LIST];
            break;
        case PortTypeBrandDynamics:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_BRAND_DYNAMICS];
            break;
        case PortTypeGetShare:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_GET_SHARE];
            break;
        case portTypeSearchActivityGood:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_SEARCH_ACTIVITY_GOOD];
            break;
        case portTypeGetPushMessage:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_PUSH_MESSAGE];
            break;
        case portTypeGetTransReqUGPayYinL:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_UGPAY_UINL];
            break;
        case portTypeGetUGPayWChatPay:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_UGPAY_WCHATPAY];
            break;
        case portTypeGetUGPayALiPay:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_UGPAY_ALIPAY];
            break;
        case portTypeGetSecondsKillGoodList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_SECK_KILL_ALL];
            break;
        case portTypeGetSeckillGood:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_SECK_KILL_GOOD];
            break;
        case portTypeGiveUPSeckillGood:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_GIVE_UP_SECK_KILL];
            break;
        case portTypeGiveGetAppAuction:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_GET_APP_AUCTION];
            break;
        case portTypeGiveGetAuctionaGood:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_GET_AUCTION_GOOD];
            break;
        case portTypeGiveInsertPrice:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_INSERT_PRICE];
            break;
        case portTypeGiveInsertList:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_INSERT_LIST];
            break;
        case portTypeGiveTimingMessage:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_TIMING_MESESSAGE];
            break;
        case portTypeGiveCancelAuction:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_CANCEL_AUTION];
            break;
        case portTypeGiveSubmitSeckill:
            requstUrl=[BASEURL stringByAppendingString:URL_GET_NEW_TRANSREQ_SUBMIT_SECKILL];
            break;
            
     default:
            break;
    }
    return requstUrl;
}

@end
