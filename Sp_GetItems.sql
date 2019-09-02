USE [ASRetail_LIVE]
GO
/****** Object:  StoredProcedure [dbo].[Sp_GetItems3]    Script Date: 9/2/2019 7:29:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Sp_GetItems] 
	@ItemCode NVARCHAR(500),
	@CustomerMembershipNo NVARCHAR(500),
	@StoreId NVARCHAR(500)
AS
BEGIN
--SET STATISTICS TIME ON

	DECLARE	@itemDiscountGroup nvarchar(500)
	, @CustPriceGroup NVARCHAR(50)
	, @CustDiscountGroup NVARCHAR(50)
	, @CustMembershipDiscountGroup NVARCHAR(50)
	, @isBarCode BIT = 0
	, @StoreLoc NVARCHAR(50)
	, @today DATE = getDate()
	, @nodiscount VARCHAR(50)
	, @discCount INT
	DECLARE @tItemInfo TABLE(
		Code NVARCHAR(500),
		ItemId NVARCHAR(50),
		Name NVARCHAR(50),
		KeyInWeight BIT,
		Is_Vatable BIT,
		No_Discount BIT,
		DiscountGroup NVARCHAR(500)
	)
	DECLARE @tBarCode TABLE(
		ItemCode NVARCHAR(500),
		Bar_Code NVARCHAR(500),
		Unit NVARCHAR(500)
	)
	DECLARE @tDiscount TABLE(
		ItemCode NVARCHAR(500),
		Discount DECIMAL(18,2),
		DiscountItemCode NVARCHAR(500),
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
	
	DECLARE @tPrice TABLE(
		ItemCode NVARCHAR(500),
		Is_Discountable BIT,
		Rate DECIMAL(18,2),
		RateMinimumQuantity DECIMAL(18,2),
		RateStartDate DATETIME,
		RateEndDate DATETIME,
		SalesType NVARCHAR(50),
		SalesCode NVARCHAR(50)
	)
	DECLARE @tFinalItemPriceList TABLE(
			SN BIGINT,
			ItemId NVARCHAR(50),
			Code NVARCHAR(500),
			Name NVARCHAR(50),
			KeyInWeight BIT,
			Is_Vatable BIT,
			No_Discount BIT,
			DiscountGroup NVARCHAR(500),
			Bar_Code NVARCHAR(500),
			Unit NVARCHAR(500),
			Discount DECIMAL(18,2),
			DiscountMinimumQuantity DECIMAL(18,2),
			DiscountStartDate DateTime,
			DiscountEndDate DateTime,
			DiscountStartTime time(7),
			DiscountEndTime time(7),
			DiscountType NVARCHAR(50),
			DiscountSalesGroupCode NVARCHAR(50),
			DiscountItemType NVARCHAR(50),
			DiscountLocation NVARCHAR(50),		
			Is_Discountable BIT,
			Rate DECIMAL(18,2),
			RateMinimumQuantity DECIMAL(18,2),
			RateStartDate DATETIME,
			RateEndDate DATETIME,
			SalesType NVARCHAR(50),
			SalesCode NVARCHAR(50)
		)


	SET NOCOUNT ON;
	--SET @StoreId = '001'
	SET @StoreLoc = (Select TOP 1 INITIAL from STORE where ID = @StoreId)
	--print'@StoreLoc = ' + @StoreLoc

	SET @CustPriceGroup = (SELECT TOP 1 CustomerPriceGroup FROM STORE WHERE ID = @StoreId)
	
	IF @CustPriceGroup IS NULL OR @CustPriceGroup = ''
		BEGIN
			SELECT TOP 1 @CustPriceGroup = ISNULL( CustomerPriceGroup,'') FROM CUSTOMER WHERE Membership_Number = @CustomerMembershipNo
		END
	SELECT TOP 1  @CustDiscountGroup = ISNULL( CustomerDiscGroup,''), @CustMembershipDiscountGroup = ISNULL( MembershipDiscGroup,'') FROM CUSTOMER WHERE Membership_Number = @CustomerMembershipNo
	--print'@CustPriceGroup = ' + @CustPriceGroup
	--print'@CustDiscountGroup = ' + @CustDiscountGroup
	--print'@CustMembershipDiscountGroup = ' + @CustMembershipDiscountGroup
	
	IF EXISTS (SELECT Code FROM ITEM WHERE Code = @ItemCode)
		BEGIN
			SET @isBarCode = 1
			SET @ItemCode = (SELECT ItemCode FROM ITEM_BARCODE WHERE BarCode = @ItemCode)
		END
	--print'@isBarCode = ' + CONVERT(NVARCHAR(5), @isBarCode)
	--print'CNo. = ' + @CustomerMembershipNo



	INSERT INTO @tItemInfo SELECT @ItemCode,i.Id AS ItemId, i.Name, i.KeyInWeight, i.Is_Vatable,i.No_Discount, i.DiscountGroup FROM ITEM i WHERE @ItemCode = i.Code
	--print'@ItemCode =' + CONVERT(NVARCHAR(50), @ItemCode)
	SET @itemDiscountGroup = (SELECT TOP(1) DiscountGroup FROM @tItemInfo)
	--print'@itemDiscountGroup = ' + @itemDiscountGroup
	
	INSERT INTO @tBarCode SELECT @ItemCode, BARCode, Unit FROM ITEM_BARCODE WHERE ItemCode  = @ItemCode AND IsActive = 1
	
	IF @CustPriceGroup = 'MRP' OR @CustPriceGroup = 'RSP'
		BEGIN
				
			INSERT INTO @tDiscount SELECT @itemCode, ISNULL(d.DiscountPercent, 0) AS Discount, d.ItemCode as DiscountItemCode,  d.MinimumQuantity AS DiscountMinimumQuantity, d.StartDate AS DiscountStartDate, d.EndDate AS DiscountEndDate, d.StartTime AS DiscountStartTime, d.EndTime AS DiscountEndTime, d.SalesType AS DiscountType, d.SalesCode AS DiscountSalesGroupCode, d.ItemType AS DiscountItemType, d.Location AS DiscountLocation FROM ITEM_DISCOUNT d 
			WHERE 
				(d.ItemCode = @ItemCode OR (d .ItemType = 'Item Disc. Group' AND d .ItemCode = @itemDiscountGroup))		
				AND (d.StartDate IS NULL OR (d.StartDate <= @today AND (d.StartTime IS NULL OR d.StartTime <= CONVERT(TIME(0), GETDATE()))))
				AND (d.EndDate IS NULL OR d.EndDate >= @today AND (d.EndTime IS NULL OR d.EndTime >= CONVERT(TIME(0), GETDATE())))
				AND (d.Location IS NULL OR d.Location = '' OR d.Location = @StoreLoc)	
		END
		
		 SET @discCount = (SELECT COUNT(*) FROM @tDiscount)
		--print'COUNT OF DISCOUNT = ' + CONVERT(NVARCHAR(50), @disccount)

	
	SELECT @nodiscount=(select top 1 No_Discount from @tItemInfo)
	IF(@nodiscount=0 AND EXISTS(SELECT TOP 1 * FROM @tDiscount))
		BEGIN

			IF EXISTS (SELECT * from @tDiscount WHERE DiscountItemType = 'Item' AND ItemCode = @ItemCode)
				-- DISCOUNT ROW FOR THIS SPECIFIC ITEM EXISTS
				BEGIN
					-- DELETE FROM @tDiscount WHERE DiscountItemType != 'Item'
					--print'keeping only ItemType = ITEM ...'
					IF EXISTS (SELECT ItemCode from @tDiscount WHERE DiscountType='Customer Disc. Group' AND DiscountSalesGroupCode = @CustDiscountGroup)
						BEGIN
							DELETE FROM @tDiscount WHERE DiscountItemType = 'Item' AND NOT (DiscountType = 'Customer Disc. Group' AND DiscountSalesGroupCode = @CustDiscountGroup)

							-- if location is applicable, prefer that row for discount
							IF ((SELECT COUNT(ItemCode) FROM @tDiscount WHERE DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc ) > 0)
								BEGIN
									DELETE FROM @tDiscount WHERE NOT (DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc)
								END
						END
					ELSE
						BEGIN
							-- check against memberDiscountGroup
							IF EXISTS (SELECT ItemCode from @tDiscount WHERE DiscountType='Member Disc. Group' AND DiscountSalesGroupCode = @CustMembershipDiscountGroup)
								BEGIN
									DELETE FROM @tDiscount WHERE DiscountItemType = 'Item' AND NOT (DiscountType = 'Member Disc. Group' AND DiscountSalesGroupCode = @CustMembershipDiscountGroup)
									
								-- if location is applicable, prefer that row for discount
								IF EXISTS (SELECT ItemCode FROM @tDiscount WHERE DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc ) 
									BEGIN
										DELETE FROM @tDiscount WHERE NOT (DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc)
									END
								END
						END
				END


				SET @discCount = (SELECT COUNT(*) from @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND ItemCode = @ItemCode)
				--print 'Discount COUNT AFTER PROCESSING ItemType => ITEM = ' + CONVERT(NVARCHAR(50), @discCount)
				--print '@ItemCode = ' + @ItemCode

			IF EXISTS (SELECT * from @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND ItemCode = @ItemCode)
				BEGIN
					-- looking into ItemGroup of discount table
					--DELETE FROM @tDiscount WHERE DiscountItemType != 'Item Disc. Group'
					--print'keeping only ItemType = Item Disc. Group ...'
					IF EXISTS (SELECT ItemCode from @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND DiscountType='Customer Disc. Group' AND DiscountSalesGroupCode = @CustDiscountGroup)
						BEGIN
							--print'keeping Customer Disc. Group only'
							DELETE FROM @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND NOT (DiscountType = 'Customer Disc. Group' AND DiscountSalesGroupCode = @CustDiscountGroup)
									
							-- if location is applicable, prefer that row for discount
							IF EXISTS (SELECT ItemCode FROM @tDiscount WHERE DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc ) 
								BEGIN
									DELETE FROM @tDiscount WHERE NOT (DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc)
								END
						END
					ELSE
						BEGIN
								DELETE FROM @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND DiscountType='Customer Disc. Group'  	

								--print'keeping Member Disc. Group only...'
								-- check against memberDiscountGroup
								IF EXISTS(SELECT ItemCode from @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND DiscountType='Member Disc. Group'  AND DiscountSalesGroupCode = @CustMembershipDiscountGroup)
									BEGIN
										DELETE FROM @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND NOT (DiscountType = 'Member Disc. Group' AND DiscountSalesGroupCode = @CustMembershipDiscountGroup)
									
										-- if location is applicable, prefer that row for discount
										IF EXISTS (SELECT ItemCode FROM @tDiscount WHERE DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc )
											BEGIN
												DELETE FROM @tDiscount WHERE NOT (DiscountLocation IS NOT NULL AND DiscountLocation != '' AND DiscountLocation = @StoreLoc)
											END
									END
								ELSE
									BEGIN
										DELETE FROM @tDiscount WHERE DiscountItemType = 'Item Disc. Group' AND DiscountType='Member Disc. Group'   
									END						
						END
				END
		END
	-- check if tDiscount table has any rows or not. If not, insert one with default values
	IF NOT EXISTS (SELECT ItemCode from @tDiscount)
		BEGIN
			--print'inserting default row...'
			 INSERT INTO @tDiscount VALUES (@itemCode, 0 , @ItemCode , 0 , GETDATE(), GETDATE() , '00:00:00','00:00:00', 'Customer Disc. Group', @CustDiscountGroup , 'Item' ,'')
		END
	--print'showing selected discounts...'
	--select * from @tDiscount

	INSERT INTO @tPrice SELECT DISTINCT @ItemCode, ISNULL(p.AllowLineDiscount, 1) AS Is_Discountable,  ISNULL(p.UnitPrice, 0) AS Rate, p.MinimumQuantity AS RateMinimumQuantity, p.StartDate AS RateStartDate, p.EndDate AS RateEndDate, p.SalesType, p.SalesCode
		FROM ITEM_PRICE p WHERE 
			p.ItemCode = @ItemCode 
			AND (p.StartDate IS NULL OR p.StartDate <= @today)
			AND (p.EndDate IS NULL OR p.EndDate >= @today)
			AND p.SalesCode = @CustPriceGroup
	--print'showing selected prices...'
	--Select * from @tPrice
	INSERT INTO @tFinalItemPriceList 
		(SN, ItemId,Code, Name, KeyInWeight, Is_Vatable,No_Discount, DiscountGroup, Bar_Code, Unit, Discount, DiscountMinimumQuantity, DiscountStartDate, DiscountEndDate, DiscountStartTime, DiscountEndTime, DiscountType, DiscountSalesGroupCode, DiscountItemType, DiscountLocation, Is_Discountable, Rate, RateMinimumQuantity, RateStartDate, RateEndDate, SalesType, SalesCode)
		SELECT 
		ROW_NUMBER() OVER (PARTITION BY itemid ORDER BY Rate) AS SN,
		tti.ItemId,tti.Code, tti.Name, KeyInWeight, Is_Vatable,tti.No_Discount, DiscountGroup, Bar_Code, Unit, Discount, DiscountMinimumQuantity, DiscountStartDate, DiscountEndDate, DiscountStartTime, DiscountEndTime, DiscountType, DiscountSalesGroupCode, DiscountItemType, DiscountLocation, Is_Discountable, Rate, RateMinimumQuantity, RateStartDate, RateEndDate, SalesType, SalesCode			
		from @tItemInfo tti
			INNER JOIN @tBarCode tbc on tbc.ItemCode = tti.Code
			INNER JOIN @tDiscount td on td.ItemCode = tti.Code
			INNER JOIN @tPrice tp on tp.ItemCode = tti.Code
	
	
	Select * from @tFinalItemPriceList

--SET STATISTICS TIME OFF

END