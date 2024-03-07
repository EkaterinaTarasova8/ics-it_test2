create or alter trigger dbo.tr_Basket_insert on dbo.Basket
after insert
as
begin
    with cte_QuantityPurchase as (
        select b.ID_SKU		
        from dbo.Basket as b
        group by b.ID_SKU, b.PurchaseDate
        having count(*) >= 2
    )
    update b
    set DiscountValue = iif(b.ID_SKU in (select * from cte_QuantityPurchase as qp), b.Value * 0.05, b.Value * 0)
    from dbo.Basket as b
end
