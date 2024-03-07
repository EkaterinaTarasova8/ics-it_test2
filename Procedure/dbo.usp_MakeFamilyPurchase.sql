create or alter procedure dbo.usp_MakeFamilyPurchase
    @FamilySurName varchar(255)
as
begin
    declare 
        @ErrorMessage varchar(255)
        ,@SumValue decimal(18, 2) = (
            select sum(b.Value) 
            from dbo.Basket as b 
                inner join dbo.Family as f on f.ID = b.ID_Family 
            where f.SurName like @FamilySurName
        )

    if not exists (
        select 1
        from dbo.Family as f
        where f.SurName = @FamilySurName
        )
    begin
        select @ErrorMessage = 'Такой семьи нет'
        raiserror(@ErrorMessage, 1, 1)

        return
    end

    if exists (	
        select 1
        from dbo.Family as f
        where f.SurName = @FamilySurName
        )
    begin
        update f
        set f.BudgetValue = f.BudgetValue - @SumValue
        from dbo.Family as f
        where f.SurName like @FamilySurName
    end
end
