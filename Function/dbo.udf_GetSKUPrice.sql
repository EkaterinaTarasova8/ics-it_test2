create or alter function dbo.udf_GetSKUPrice(
    @ID_SKU int
)
returns decimal(18, 2)
as
begin
    declare @ProductPrice decimal(18, 2)
    select @ProductPrice = sum(b.Value) / sum(b.Quantity)
    from dbo.Basket as b
    where b.ID_SKU = @ID_SKU

    return @ProductPrice
end
