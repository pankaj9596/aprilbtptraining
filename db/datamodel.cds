namespace cappo.db;
using {cappo.commons} from './commons';
using {
    cuid,
    temporal,
    managed,
    Currency
} from '@sap/cds/common';

context master {
    entity businesspartner {
        key NODE_KEY      : commons.Guid;
            BP_ROLE       : String(2);
            EMAIL_ADDRESS : String(100);
            PHONE_NUMBER  : String(32);
            FAX_NUMBER    : String(32);
            WEB_ADDRESS   : String(64);
            BP_ID         : String(32);
            COMPANY_NAME  : String(128);
            ADDRESS_GUID  : Association to master.address;
    }

    entity address {
        key NODE_KEY        : commons.Guid;
            CITY            : String(32);
            POSTAL_CODE     : String(8);
            STREET          : String(32);
            BUILDING        : String(128);
            COUNTRY         : String(64);
            ADDRESS_TYPE    : String(32);
            VAL_START_DATE  : Date;
            VAL_END_DATE    : Date;
            LATITUDE        : Decimal;
            LONGITUDE       : Decimal;
            businesspartner : Association to one master.businesspartner
                                  on businesspartner.ADDRESS_GUID = $self;
    }
    
    entity product {
        key NODE_KEY       : commons.Guid;
            PRODUCT_ID     : String(32);
            TYPE_CODE      : String(4);
            CATEGORY       : String(32);
            DESCRIPTION    : localized String(255);
            SUPPLIER_GUID  : Association to master.businesspartner;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal(5, 2);
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal(10, 2);
            WIDTH          : Decimal(5, 2);
            HEIGHT         : Decimal(5, 2);
            DEPTH          : Decimal(5, 2);
            DIM_UNIT       : String(2);
    }

    entity employees : cuid {
        nameFirst : String(40);
        nameLast : String(40);
        nameMiddle : String(40);
        nameInitials : String(40);
        sex : commons.Gender;
        language : String(3);
        phoneNumber : String(18);
        email : String(128);
        loginName : String(128);
        Currency : Currency;
        salaryAmount : commons.AmountT;
        accountNumber : String(32);
        bankId : String(12);
        bankName : String(64);
    }
}

context transaction {
    entity purchaseorder:commons.Amount {
          key NODE_KEY : commons.Guid;
          PO_ID : String(64);
          PARTNER_GUID : Association to master.businesspartner;
          OVERALL_STATUS : String(1);
          LIFECYCLE_STATUS : String(1);
          Items : Association to many poitems on Items.PARENT_KEY = $self; 
    }

    entity poitems : commons.Amount{
        key NODE_KEY : commons.Guid;
        PARENT_KEY : Association to transaction.purchaseorder;
        PO_ITEM_POS : Integer;
        PRODUCT_GUID : Association to master.product;
    }
}
