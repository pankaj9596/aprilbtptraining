namespace cappo.commons;

using {Currency} from '@sap/cds/common';


type Guid    : String(32);

type Gender  : String(1) enum {
    male        = 'M';
    female      = 'F';
    transgender = 'T'
};

type AmountT : Decimal(10, 2) @(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit                     : 'CURRENCY_CODE'
);


aspect Amount : {
    CURRENCY_CODE : Currency;
    BASE_AMOUNT   : AmountT;
    NET_AMOUNT    : AmountT;
    TAX_AMOUNT    : AmountT;
}
