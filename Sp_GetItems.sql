SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE Sp_GetItems 
	@ItemCode NVARCHAR(500)

AS
BEGIN
DECLARE
@dg nvarchar(500)
	SET NOCOUNT ON;

	DECLARE @isBarCode BIT = 0
	IF (SELECT COUNT(Code) from ITEM where Code = @ItemCode) = 0
		BEGIN
			SET @isBarCode = 1
			SET @ItemCode = (SELECT ItemCode from ITEM_BARCODE where BarCode = @ItemCode)
		END

	print @isBarCode


	DECLARE @tItemInfo TABLE(
		Code NVARCHAR(500),
		ItemId NVARCHAR(50),
		Name NVARCHAR(50),
		KeyInWeight BIT,
		Is_Vatable BIT,
		No_Discount BIT,
		DiscountGroup NVARCHAR(500)
	)

	INSERT INTO @tItemInfo SELECT @ItemCode,i.Id AS ItemId, i.Name, i.KeyInWeight, i.Is_Vatable,i.No_Discount, i.DiscountGroup from ITEM i where @ItemCode = i.Code

	print @ItemCode

	SET @dg = (select Top(1) DiscountGroup from @tItemInfo)

	print @dg

	DECLARE @tBarCode TABLE(
		ItemCode NVARCHAR(500),
		Bar_Code NVARCHAR(500),
		Unit NVARCHAR(500)
	)

	INSERT INTO @tBarCode SELECT @ItemCode, BARCode, Unit from ITEM_BARCODE where ItemCode  = @ItemCode AND IsActive = 1

	declare @today DATE = getDate()

	declare @tDiscount TABLE(
		ItemCode NVARCHAR(500),
		Discount DECIMAL(18,2),
		DiscountMinimumQuantity DECIMAL(18,2),
		DiscountStartDate DateTime,
		DiscountEndDate DateTime,
		DiscountStartTime time(7),
		DiscountEndTime time(7),
		DiscountType NVARCHAR(50),
		DiscountSalesGroupCode NVARCHAR(50),
		DiscountItemType NVARCHAR(50),
		DiscountLocation NVARCHAR(50)
	)

	INSERT INTO @tDiscount SELECT @itemCode, ISNULL(d .DiscountPercent, 0) AS Discount, d .MinimumQuantity AS				DiscountMinimumQuantity, d .StartDate AS DiscountStartDate, d .EndDate AS DiscountEndDate, d .StartTime AS DiscountStartTime, d .EndTime AS DiscountEndTime, d .SalesType AS DiscountType, d .SalesCode AS DiscountSalesGroupCode,	d .ItemType AS DiscountItemType, d .Location AS DiscountLocation FROM ITEM_DISCOUNT d 
	WHERE 
		(d.ItemCode = @ItemCode OR (d .ItemType = 'Item Disc. Group' AND d .ItemCode = @dg))		
		AND (d.StartDate IS NULL OR d.StartDate <= @today)
		AND (d.EndDate IS NULL OR d.EndDate >= @today)

	declare @tPrice TABLE(
		ItemCode NVARCHAR(500),
		Is_Discountable BIT,
		Rate DECIMAL(18,2),
		RateMinimumQuantity DECIMAL(18,2),
		RateStartDate DATETIME,
		RateEndDate DATETIME,
		SalesType NVARCHAR(50),
		SalesCode NVARCHAR(50)
	)


	INSERT INTO @tPrice SELECT @ItemCode, ISNULL(p.AllowLineDiscount, 1) AS Is_Discountable,  ISNULL(p.UnitPrice, 0) AS Rate, p.MinimumQuantity AS RateMinimumQuantity, p.StartDate AS RateStartDate, p.EndDate AS RateEndDate, p.SalesType, p.SalesCode
		FROM ITEM_PRICE p WHERE 
			p.ItemCode = @ItemCode 
			AND (p.StartDate IS NULL OR p.StartDate <= @today)
			AND (p.EndDate IS NULL OR p.EndDate >= @today)


	Select ROW_NUMBER() OVER (PARTITION BY Bar_Code
ORDER BY Rate) AS SN,* from @tItemInfo tti
	INNER JOIN @tBarCode tbc on tbc.ItemCode = tti.Code
	INNER JOIN @tDiscount td on td.ItemCode = tti.Code
	INNER JOIN @tPrice tp on tp.ItemCode = tti.Code


END
GO
