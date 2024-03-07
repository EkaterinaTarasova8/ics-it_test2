create or alter view dbo.vw_SKUPrice 
as
    select
        ID
        ,Code
        ,Name
        ,dbo.udf_GetSKUPrice(s.ID) as Price
    from dbo.SKU as s
