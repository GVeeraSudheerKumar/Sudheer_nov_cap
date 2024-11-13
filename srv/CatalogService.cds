using { anubhav.db.master, anubhav.db.transaction } from '../db/datamodel';
using { cappo.cds } from '../db/CDSViews';
 
 
service CatalogService @(path:'CatalogService') {
 
    //@readonly
    entity EmployeeSet as projection on master.employees;

    //@cds.redirection.target
    entity ProductSet as projection on master.product;

    @Capabilities : { Insertable, Deletable: false }
    entity BusinessPartnerSet as projection on master.businesspartner;

    entity AddressSet as projection on master.address;

    entity PurchaseOrderItems as projection on transaction.poitems;

    entity POs@(odata.draft.enabled: true) as projection on transaction.purchaseorder{
        *,
        case OVERALL_STATUS
            when 'P' then 'Paid'
            when 'A' then 'Approved'
            when 'N' then 'New'
            when 'X' then 'Rejected'
                end as OverllStatus: String(10),
        case OVERALL_STATUS
            when 'P' then 3
            when 'A' then 3
            when 'N' then 2
            when 'X' then 1
                end as IconColor: Integer,
        //round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
        Items: redirected to PurchaseOrderItems
    } actions{
        action boost() returns POs;
    };
    function largestOrder() returns POs;
    //entity CProductValuesView as projection on cds.CDSViews.CProductValuesView;
 
}