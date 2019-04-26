USE [POS]
GO
/****** Object:  Schema [HangFire]    Script Date: 04/26/19 5:24:23 PM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](128) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CREDIT_NOTE]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CREDIT_NOTE](
	[Id] [uniqueidentifier] NOT NULL,
	[Credit_Note_Id] [int] NOT NULL,
	[Credit_Note_Number] [nvarchar](50) NOT NULL,
	[Reference_Number] [nvarchar](50) NOT NULL,
	[Trans_Date_AD] [datetime] NULL,
	[Trans_Date_BS] [nvarchar](50) NULL,
	[Trans_Time] [time](7) NULL,
	[Trans_Type] [nvarchar](50) NULL,
	[Division] [nvarchar](50) NULL,
	[Terminal] [nvarchar](50) NULL,
	[Customer_Id] [nvarchar](50) NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[Customer_Vat] [nvarchar](50) NULL,
	[Customer_Mobile] [nvarchar](50) NULL,
	[Customer_Address] [nvarchar](50) NULL,
	[Flat_Discount_Amount] [decimal](18, 2) NULL,
	[Flat_Discount_Percent] [decimal](18, 2) NULL,
	[Total_Quantity] [int] NULL,
	[Total_Gross_Amount] [decimal](18, 2) NULL,
	[Total_Discount] [decimal](18, 2) NULL,
	[Total_Vat] [decimal](18, 2) NULL,
	[Total_Net_Amount] [decimal](18, 2) NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_Date] [datetime] NULL,
	[Credit_Note] [nvarchar](800) NOT NULL,
	[Remarks] [nvarchar](150) NULL,
	[TaxableAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[NonTaxableAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_CREDIT_NOTE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CREDIT_NOTE_ITEMS]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CREDIT_NOTE_ITEMS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Credit_Note_Id] [uniqueidentifier] NULL,
	[Credit_Note_Number] [nvarchar](50) NULL,
	[Bar_Code] [varchar](50) NULL,
	[Name] [nvarchar](150) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Quantity] [decimal](18, 0) NULL,
	[Gross_Amount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Is_Discountable] [bit] NOT NULL DEFAULT ((0)),
	[Tax] [decimal](18, 2) NULL,
	[Net_Amount] [decimal](18, 2) NULL,
	[Is_Vatable] [bit] NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_CREDIT_NOTE_ITEMS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[Code] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Address] [nvarchar](150) NULL,
	[Image] [nvarchar](50) NULL,
	[Tel1] [varchar](15) NULL,
	[Tel2] [varchar](15) NULL,
	[Mobile1] [varchar](15) NULL,
	[Mobile2] [varchar](15) NULL,
	[Email] [nvarchar](50) NULL,
	[Vat] [varchar](50) NULL,
	[Fax] [varchar](50) NULL,
	[PO_Box] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Credit_Limit] [decimal](18, 2) NULL,
	[Credit_day] [int] NULL,
	[Is_Sale_Refused] [bit] NULL,
	[Is_Member] [bit] NULL,
	[Member_Id] [int] NULL,
	[Barcode] [nvarchar](50) NULL,
	[DOB] [datetime] NULL,
	[DOB_BS] [nvarchar](50) NULL,
	[Wedding_Date] [datetime] NULL,
	[Family_Member_Int] [int] NULL,
	[Occupation] [nvarchar](50) NULL,
	[Office_Name] [nvarchar](50) NULL,
	[Office_Address] [nvarchar](150) NULL,
	[Designation] [nvarchar](50) NULL,
	[Registration_Date] [datetime] NULL,
	[Validity_Period] [nvarchar](50) NULL,
	[Validity_Date] [datetime] NULL,
	[Membership_Scheme] [int] NULL,
	[Reference_By] [nvarchar](50) NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_Date] [datetime] NULL,
	[Remarks] [nvarchar](50) NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DENOMINATION]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DENOMINATION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[User_Id] [nvarchar](50) NOT NULL,
	[Terminal_Id] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Date_BS] [varchar](50) NULL,
	[Debit_Card] [decimal](18, 2) NULL,
	[Cheque] [decimal](18, 2) NULL,
	[R1000] [decimal](18, 0) NULL,
	[R500] [decimal](18, 0) NULL,
	[R250] [decimal](18, 0) NULL,
	[R100] [decimal](18, 0) NULL,
	[R50] [decimal](18, 0) NULL,
	[R25] [decimal](18, 0) NULL,
	[R20] [decimal](18, 0) NULL,
	[R10] [decimal](18, 0) NULL,
	[R5] [decimal](18, 0) NULL,
	[R2] [decimal](18, 0) NULL,
	[R1] [decimal](18, 0) NULL,
	[R05] [decimal](18, 0) NULL,
	[RIC] [decimal](18, 0) NULL,
	[Other] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_Denomination] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InvoiceMaterializedView]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceMaterializedView](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BillNo] [nvarchar](20) NOT NULL,
	[DocumentType] [nvarchar](50) NOT NULL,
	[FiscalYear] [nvarchar](30) NOT NULL,
	[LocationCode] [nvarchar](50) NOT NULL,
	[BillDate] [datetime] NOT NULL,
	[PostingTime] [time](7) NOT NULL,
	[CustomerCode] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](50) NOT NULL,
	[VATNo] [nvarchar](20) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Discount] [decimal](18, 2) NOT NULL,
	[TaxableAmount] [decimal](18, 2) NOT NULL,
	[NonTaxableAmount] [decimal](18, 2) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[TotalAmount] [decimal](18, 2) NOT NULL,
	[IsBillActive] [bit] NOT NULL,
	[IsBillPrinted] [bit] NOT NULL,
	[PrintedTime] [datetime] NOT NULL,
	[PrintedBy] [nvarchar](50) NOT NULL,
	[EnteredBy] [nvarchar](50) NOT NULL,
	[SyncStatus] [nvarchar](50) NOT NULL,
	[SyncedDate] [datetime] NOT NULL,
	[SyncedTime] [time](7) NOT NULL,
	[SyncWithIRD] [bit] NOT NULL,
	[IsRealTime] [bit] NOT NULL,
 CONSTRAINT [PK_InvoiceMaterializedView] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ITEM]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ITEM](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[Bar_Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Parent_Code] [nvarchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[Is_Discountable] [bit] NOT NULL DEFAULT ((0)),
	[Is_Vatable] [bit] NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_ITEM] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ITEM_CATEGORY]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM_CATEGORY](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](150) NULL,
	[Parent_Code] [nvarchar](150) NULL,
	[Description] [nvarchar](500) NULL,
	[Indentation] [int] NULL,
	[Order] [int] NULL,
	[Has_Child] [bit] NULL,
	[Modified_Date] [datetime] NULL,
 CONSTRAINT [PK_ITEM_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ITEM_GROUP]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM_GROUP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Description] [nvarchar](500) NULL,
	[Item_Category_Code] [nvarchar](150) NULL,
 CONSTRAINT [PK_ITEM_GROUP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ITEM_TYPE]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEM_TYPE](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](150) NULL,
	[Description] [nvarchar](500) NULL,
 CONSTRAINT [PK_ITEM_TYPE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MENU]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ParentId] [int] NULL,
	[SN] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Controller] [nvarchar](50) NULL,
	[Action] [nvarchar](50) NULL,
	[Route] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_MENU] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ROLEWISE_MENU_PERMISSION]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLEWISE_MENU_PERMISSION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[MenuId] [int] NOT NULL,
 CONSTRAINT [PK_ROLEWISE_MENU_PERMISSION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ROLEWISE_PERMISSION]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLEWISE_PERMISSION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[Sales_Discount_Line_Item] [bit] NOT NULL,
	[Sales_Discount_Line_Item_Limit] [decimal](18, 2) NOT NULL,
	[Sales_Discount_Flat_Item] [bit] NOT NULL,
	[Sales_Discount_Flat_Item_Limit] [decimal](18, 2) NOT NULL,
	[Sales_Rate_Edit] [bit] NOT NULL,
	[Credit_Note_Bill_Pay] [bit] NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_ROLEWISE_PERMISSION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_INVOICE]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_INVOICE](
	[Id] [uniqueidentifier] NOT NULL,
	[Invoice_Id] [int] NOT NULL,
	[Invoice_Number] [nvarchar](50) NOT NULL,
	[Trans_Date_AD] [datetime] NULL,
	[Trans_Date_BS] [nvarchar](50) NULL,
	[Trans_Time] [time](7) NULL,
	[Trans_Type] [nvarchar](50) NULL,
	[Chalan_Number] [nvarchar](50) NULL,
	[Division] [nvarchar](50) NULL,
	[Terminal] [nvarchar](50) NULL,
	[Customer_Id] [nvarchar](50) NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[Customer_Vat] [nvarchar](50) NULL,
	[Customer_Mobile] [nvarchar](50) NULL,
	[Customer_Address] [nvarchar](50) NULL,
	[Flat_Discount_Amount] [decimal](18, 2) NULL,
	[Flat_Discount_Percent] [decimal](18, 2) NULL,
	[Total_Quantity] [int] NULL,
	[Total_Gross_Amount] [decimal](18, 2) NULL,
	[Total_Discount] [decimal](18, 2) NULL,
	[Total_Vat] [decimal](18, 2) NULL,
	[Total_Net_Amount] [decimal](18, 2) NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_Date] [datetime] NULL,
	[Remarks] [nvarchar](150) NULL,
	[TaxableAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[NonTaxableAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_SALES_INVOICE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_INVOICE_BILL]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_INVOICE_BILL](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Invoice_Id] [uniqueidentifier] NULL,
	[Invoice_Type] [nvarchar](50) NULL,
	[Invoice_Number] [nvarchar](50) NOT NULL,
	[Division] [nvarchar](50) NULL,
	[Terminal] [nvarchar](50) NULL,
	[Trans_Mode] [nvarchar](50) NULL,
	[Account] [nvarchar](150) NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_SALES_INVOICE_BILL] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_INVOICE_ITEMS]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SALES_INVOICE_ITEMS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Invoice_Id] [uniqueidentifier] NULL,
	[Invoice_Number] [nvarchar](50) NULL,
	[Bar_Code] [varchar](50) NULL,
	[Name] [nvarchar](150) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Quantity] [decimal](18, 0) NULL,
	[Gross_Amount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Is_Discountable] [bit] NOT NULL DEFAULT ((0)),
	[Tax] [decimal](18, 2) NULL,
	[Net_Amount] [decimal](18, 2) NULL,
	[Is_Vatable] [bit] NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_SALES_INVOICE_ITEMS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SALES_INVOICE_ITEMS_TMP]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SALES_INVOICE_ITEMS_TMP](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Invoice_Id] [uniqueidentifier] NULL,
	[Invoice_Number] [nvarchar](50) NULL,
	[Bar_Code] [varchar](50) NULL,
	[Name] [nvarchar](150) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Quantity] [decimal](18, 0) NULL,
	[Gross_Amount] [decimal](18, 2) NULL,
	[Discount] [decimal](18, 2) NULL,
	[Is_Discountable] [bit] NOT NULL DEFAULT ((0)),
	[Tax] [decimal](18, 2) NULL,
	[Net_Amount] [decimal](18, 2) NULL,
	[Is_Vatable] [bit] NULL,
	[Remarks] [nvarchar](150) NULL,
 CONSTRAINT [PK_SALES_INVOICE_ITEMS_TMP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SALES_INVOICE_TMP]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SALES_INVOICE_TMP](
	[Id] [uniqueidentifier] NOT NULL,
	[Invoice_Id] [int] NOT NULL,
	[Invoice_Number] [nvarchar](50) NOT NULL,
	[Trans_Date_AD] [datetime] NULL,
	[Trans_Date_BS] [nvarchar](50) NULL,
	[Trans_Time] [time](7) NULL,
	[Trans_Type] [nvarchar](50) NULL,
	[Chalan_Number] [nvarchar](50) NULL,
	[Division] [nvarchar](50) NULL,
	[Terminal] [nvarchar](50) NULL,
	[Customer_Id] [nvarchar](50) NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[Customer_Vat] [nvarchar](50) NULL,
	[Customer_Mobile] [nvarchar](50) NULL,
	[Customer_Address] [nvarchar](50) NULL,
	[Flat_Discount_Amount] [decimal](18, 2) NULL,
	[Flat_Discount_Percent] [decimal](18, 2) NULL,
	[Total_Quantity] [int] NULL,
	[Total_Gross_Amount] [decimal](18, 2) NULL,
	[Total_Discount] [decimal](18, 2) NULL,
	[Total_Vat] [decimal](18, 2) NULL,
	[Total_Net_Amount] [decimal](18, 2) NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_Date] [datetime] NULL,
	[Remarks] [nvarchar](150) NULL,
	[NonTaxableAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
	[TaxableAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_SALES_INVOICE_TMP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Settlement]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Settlement](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SessionId] [nvarchar](50) NOT NULL,
	[TerminalId] [int] NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[TransactionNumber] [nvarchar](50) NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[PaymentMode] [nvarchar](50) NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[VerifiedBy] [nvarchar](450) NOT NULL,
	[VerifiedDate] [datetime] NOT NULL,
	[Remarks] [nvarchar](500) NOT NULL,
	[DenominationId] [int] NOT NULL DEFAULT ((0)),
	[DenominationAmount] [decimal](18, 2) NOT NULL DEFAULT ((0)),
 CONSTRAINT [PK_Settlement] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STORE]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STORE](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[INITIAL] [nchar](3) NOT NULL,
	[NAME] [nvarchar](150) NULL,
	[COMPANY_NAME] [nvarchar](150) NULL,
	[ADDRESS] [nvarchar](250) NULL,
	[PHONE] [varchar](15) NULL,
	[PHONE_ALT] [varchar](15) NULL,
	[FAX] [varchar](15) NULL,
	[VAT] [varchar](30) NULL,
	[EMAIL] [nvarchar](50) NULL,
	[WEBSITE] [nvarchar](50) NULL,
	[FISCAL_YEAR] [varchar](20) NULL,
 CONSTRAINT [PK_STORE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TERMINAL]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TERMINAL](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Initial] [nvarchar](15) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Is_Active] [bit] NULL,
	[Remarks] [nvarchar](150) NULL,
	[Cash_Drop_Limit] [decimal](18, 2) NULL,
 CONSTRAINT [PK_TERMINAL] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[AggregatedCounter]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[AggregatedCounter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [bigint] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_CounterAggregated] PRIMARY KEY CLUSTERED 
(
	[Key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[Counter]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Counter](
	[Key] [nvarchar](100) NOT NULL,
	[Value] [int] NOT NULL,
	[ExpireAt] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[Hash]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Hash](
	[Key] [nvarchar](100) NOT NULL,
	[Field] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime2](7) NULL,
 CONSTRAINT [PK_HangFire_Hash] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Field] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[Job]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Job](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[StateId] [bigint] NULL,
	[StateName] [nvarchar](20) NULL,
	[InvocationData] [nvarchar](max) NOT NULL,
	[Arguments] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Job] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[JobParameter]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobParameter](
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](40) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_JobParameter] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[JobQueue]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[JobQueue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Queue] [nvarchar](50) NOT NULL,
	[FetchedAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_JobQueue] PRIMARY KEY CLUSTERED 
(
	[Queue] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[List]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[List](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Key] [nvarchar](100) NOT NULL,
	[Value] [nvarchar](max) NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_List] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[Schema]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Schema](
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_HangFire_Schema] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[Server]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Server](
	[Id] [nvarchar](100) NOT NULL,
	[Data] [nvarchar](max) NULL,
	[LastHeartbeat] [datetime] NOT NULL,
 CONSTRAINT [PK_HangFire_Server] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[Set]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[Set](
	[Key] [nvarchar](100) NOT NULL,
	[Score] [float] NOT NULL,
	[Value] [nvarchar](256) NOT NULL,
	[ExpireAt] [datetime] NULL,
 CONSTRAINT [PK_HangFire_Set] PRIMARY KEY CLUSTERED 
(
	[Key] ASC,
	[Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [HangFire].[State]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HangFire].[State](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[JobId] [bigint] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[Reason] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NOT NULL,
	[Data] [nvarchar](max) NULL,
 CONSTRAINT [PK_HangFire_State] PRIMARY KEY CLUSTERED 
(
	[JobId] ASC,
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[SettlementView]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE View  [dbo].[SettlementView] as
Select row_number() OVER (order by getdate()) as Id, s.SessionId,s.TerminalId,s.UserId,s.denominationId,s.PaymentMode,s.Status,s.Remarks, t.Name as TerminalName, MIN(s.TransactionDate) as StartTransaction, MAX(s.TransactionDate) as EndTransaction, u.UserName, SUM(s.Amount) as TotalAmount, s.DenominationAmount, CAST(0.00 as decimal) as SettlementCash  from Settlement s
left join TERMINAL t on t.Id = s.TerminalId
left join AspNetUsers u on s.UserId = u.Id
group by s.SessionId,s.TerminalId,s.UserId,s.denominationId,s.DenominationAmount,s.PaymentMode,s.Status,s.Remarks, t.Name, u.UserName


GO
/****** Object:  View [dbo].[User_View_Model]    Script Date: 04/26/19 5:24:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[User_View_Model] as
select users.Id, users.UserName,users.Email,roles.Name as Role from AspNetUsers users 
left join AspNetUserRoles userroles on users.Id = userroles.UserId
left join AspNetRoles roles on roles.Id = userroles.RoleId

GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20190325072900_initial', N'2.1.4-rtm-31024')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'228056f2-0983-4ff8-8463-b160bce97793', N'Overall Manager', N'OVERALL MANAGER', N'0a2c0b6d-82fd-4fba-91f8-a6d97d31a634')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', N'Administrator', N'ADMINISTRATOR', N'9047e979-c74d-4a8e-8caf-94286a0f4061')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'ac490c4d-4068-4c52-ae59-d72f470986a5', N'Report Agent', N'REPORT AGENT', N'ebfa7481-2f66-4558-89ae-9d05c0a31c00')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'bbbf71a3-0a6f-48fd-8120-c1eb1afa0f70', N'Sales Manager', N'SALES MANAGER', N'1ba4f8d4-1006-454f-8fbb-94fcdacf729d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d9198e8-04c9-4a99-b372-a55a7c7f6675', N'ac490c4d-4068-4c52-ae59-d72f470986a5')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8642a0a8-fc10-4001-bf1f-6f847b189f53', N'bbbf71a3-0a6f-48fd-8120-c1eb1afa0f70')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'2d9198e8-04c9-4a99-b372-a55a7c7f6675', N'A1', N'A1', N'A1@gmail.com', N'A1@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEEQJIFDtKqcAWzImiWdvurEFbS9fEw8GN2HyJdV15Ux5qk/5sunYQ8ETsUJe4pGIoQ==', N'YXZHR3RGUZGPTWEEH65GBUW3Y6RNAPG7', N'be63d8d4-8550-4e19-9b73-bcfaed97f7db', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Admin', N'ADMIN', N'Admin@gmail.com', N'ADMIN@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEGauUyNygHE7RyRUYg/vOewDL2kndOe3nqiSoaqUaINX5ECVg3EBjV/50iaStsw+NQ==', N'4Y7RDBU7TWBT4REZEI3L2UKDJSAJWGLZ', N'0e9cb261-ef12-40d8-a6a4-dc9411c8f893', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8642a0a8-fc10-4001-bf1f-6f847b189f53', N'TestUser', N'TESTUSER', N'Testuser@gmail.com', N'TESTUSER@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEMztSPSU6Sf+B4WFiojgluhD9M1sIIQohXn+He8tyrrA0HXm1AvQwT8cHXZfvMts7g==', N'YY3JBNV3TJTNS6H66YLICITTAN5TACWB', N'35697566-986c-4586-9dd0-4c27088cfc35', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'a5f3da1c-6a97-4dc5-9916-3c33e9e2be98', 5, N'CN-0005-075/75', N'TI-0021-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'09:44:40.0730835' AS Time), N'Sales', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(15966.85 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), NULL, CAST(17044.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 09:44:40.073' AS DateTime), N'ttt', N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'7eaad0c2-5a18-4cca-9c90-3ea494ddc9a2', 1, N'CN-0001-075/75', N'TI-0002-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:18:01.7403918' AS Time), N'Sales', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 4, CAST(21761.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(24590.85 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:18:01.740' AS DateTime), N'Defective piece', N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'c4190bc5-36ec-4a14-9a67-757e8a375153', 3, N'CN-0003-075/75', N'SI-0002-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'17:02:42.4874427' AS Time), N'Sales', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, CAST(4545.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 17:03:14.567' AS DateTime), N'test credit', N'Claimed', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'ff1845b6-483f-466e-8252-b712a37e9a2c', 4, N'CN-0004-075/75', N'TI-0006-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'17:12:11.4706044' AS Time), N'Sales', N'Divisioin', N'Terminal', N'40', N'', N'', N'', N'', NULL, NULL, 3, CAST(26610.38 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(28806.66 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 23:08:54.217' AS DateTime), N'test 101', N'Claimed', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'6d3107fc-cedf-43c7-ad06-db641746a909', 6, N'CN-0006-075/75', N'TI-0045-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:50:27.5692769' AS Time), N'Sales', N'Divisioin', N'Terminal', N'1', N'', N'', N'', N'', NULL, NULL, 1, CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), NULL, CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:56:10.430' AS DateTime), N'test', N'Claimed', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'841c01e0-a6a6-442b-8475-f6d659f9e60b', 2, N'CN-0002-075/75', N'TI-0002-CHK-075/76', CAST(N'2019-04-17 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'13:06:44.1069297' AS Time), N'Sales', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 30, CAST(127516.57 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(142274.74 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:33:34.177' AS DateTime), N'Test Credit', N'Claimed', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[CREDIT_NOTE_ITEMS] ON 

INSERT [dbo].[CREDIT_NOTE_ITEMS] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1, N'a5f3da1c-6a97-4dc5-9916-3c33e9e2be98', N'CN-0005-075/75', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[CREDIT_NOTE_ITEMS] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (2, N'a5f3da1c-6a97-4dc5-9916-3c33e9e2be98', N'CN-0005-075/75', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 0, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[CREDIT_NOTE_ITEMS] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (3, N'6d3107fc-cedf-43c7-ad06-db641746a909', N'CN-0006-075/75', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 0, NULL)
SET IDENTITY_INSERT [dbo].[CREDIT_NOTE_ITEMS] OFF
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'1', N'Ilysa Shellibeer', N'93593 Hagan Junction', NULL, N'169-173-7808', NULL, N'237-817-0990', NULL, N'ishellibeer0@bloglines.com', N'59779-860', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1001, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'10', N'Alvina Lassen', N'2431 Dakota Plaza', NULL, N'153-839-4807', NULL, N'356-101-5293', NULL, N'alassen9@eepurl.com', N'43063-094', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'11', N'Pattin Morch', N'22148 Burrows Point', NULL, N'526-997-5445', NULL, N'392-964-7743', NULL, N'pmorcha@oakley.com', N'59667-0058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'12', N'Babbette Garth', N'9 Ohio Plaza', NULL, N'397-868-6666', NULL, N'700-318-2067', NULL, N'bgarthb@webmd.com', N'54569-5840', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'13', N'Seymour Alp', N'67 Carpenter Center', NULL, N'729-218-5336', NULL, N'728-684-8357', NULL, N'salpc@sogou.com', N'24236-943', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'14', N'Enrique Rissom', N'97 Eggendart Alley', NULL, N'447-715-6032', NULL, N'294-608-0364', NULL, N'erissomd@indiegogo.com', N'50268-691', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'2', N'Windham Beiderbeck', N'2370 Park Meadow Court', NULL, N'170-170-4789', NULL, N'783-794-3813', NULL, N'wbeiderbeck1@europa.eu', N'0378-2180', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1002, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'3', N'Jacynth Pickavance', N'6 Scofield Avenue', NULL, N'231-635-3343', NULL, N'733-611-6671', NULL, N'jpickavance2@github.io', N'0186-0324', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'4', N'Lorinda Infante', N'17958 Bayside Place', NULL, N'134-273-2022', NULL, N'418-868-4621', NULL, N'linfante3@reuters.com', N'64720-125', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'5', N'Moyna Alenov', N'8097 Crescent Oaks Street', NULL, N'881-224-0421', NULL, N'663-282-4678', NULL, N'malenov4@jiathis.com', N'68788-0999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'6', N'Jobie Shankland', N'97853 Ridge Oak Center', NULL, N'433-697-0679', NULL, N'892-612-2338', NULL, N'jshankland5@google.com.br', N'62670-4826', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'7', N'Sapphire Stansby', N'544 Vidon Court', NULL, N'266-559-5045', NULL, N'816-414-5762', NULL, N'sstansby6@typepad.com', N'21695-777', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'8', N'Goldia Tourne', N'66 Stephen Junction', NULL, N'405-263-8106', NULL, N'682-930-0430', NULL, N'gtourne7@rediff.com', N'37000-153', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (N'9', N'Brewster Beckey', N'7325 4th Drive', NULL, N'810-771-6678', NULL, N'542-141-5104', NULL, N'bbeckey8@phoca.cz', N'68151-0185', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[DENOMINATION] ON 

INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (16, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(6 AS Decimal(18, 0)), NULL, CAST(9.60 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (17, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', NULL, NULL, NULL, CAST(5 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(55 AS Decimal(18, 0)), NULL, CAST(2588.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (18, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', NULL, NULL, CAST(55 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(55 AS Decimal(18, 0)), NULL, CAST(55088.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (19, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', NULL, NULL, NULL, CAST(7 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, CAST(4 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, CAST(4 AS Decimal(18, 0)), NULL, CAST(3586.40 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (20, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', NULL, NULL, CAST(5 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(5000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (21, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', NULL, NULL, CAST(4 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(4000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (22, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', NULL, NULL, CAST(6 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(6000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (23, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', NULL, NULL, CAST(6 AS Decimal(18, 0)), CAST(8 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(10000.00 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[DENOMINATION] OFF
SET IDENTITY_INSERT [dbo].[InvoiceMaterializedView] ON 

INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (6, N'TI-0040-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'14:51:32.5731384' AS Time), N'1', N'Ilysa Shellibeer', N'59779-860', CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 14:51:38.040' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Not Started', CAST(N'2019-04-26 14:51:38.040' AS DateTime), CAST(N'14:51:38.0416423' AS Time), 0, 0)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (7, N'TI-0041-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'14:53:25.1725344' AS Time), N'1', N'Ilysa Shellibeer', N'59779-860', CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 14:53:52.160' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Not Started', CAST(N'2019-04-26 14:53:52.160' AS DateTime), CAST(N'14:53:52.1596223' AS Time), 0, 0)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (8, N'TI-0042-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'14:59:05.4820088' AS Time), N'', N'', N'', CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 14:59:11.193' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 14:59:32.910' AS DateTime), CAST(N'14:59:32.9108908' AS Time), 1, 1)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (9, N'TI-0043-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'15:00:25.2634163' AS Time), N'', N'', N'', CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 15:00:30.293' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 15:00:34.580' AS DateTime), CAST(N'15:00:34.5792762' AS Time), 1, 1)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (10, N'TI-0044-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'15:01:45.4714085' AS Time), N'', N'', N'', CAST(25989.78 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(25969.78 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 15:01:49.840' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 15:01:50.053' AS DateTime), CAST(N'15:01:50.0540084' AS Time), 1, 1)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (11, N'TI-0045-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'15:09:21.1077632' AS Time), N'1', N'Ilysa Shellibeer', N'59779-860', CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 15:09:26.347' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 15:09:27.517' AS DateTime), CAST(N'15:09:27.5184705' AS Time), 1, 1)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (12, N'TI-0046-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'15:36:31.8241006' AS Time), N'', N'', N'', CAST(39623.79 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(39603.79 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 15:37:00.920' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 15:37:01.660' AS DateTime), CAST(N'15:37:01.6606807' AS Time), 1, 1)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (13, N'TI-0047-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'15:39:47.2767665' AS Time), N'1', N'Ilysa Shellibeer', N'59779-860', CAST(94113.20 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(94093.20 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 15:40:08.667' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 15:40:08.837' AS DateTime), CAST(N'15:40:08.8360454' AS Time), 1, 1)
INSERT [dbo].[InvoiceMaterializedView] ([Id], [BillNo], [DocumentType], [FiscalYear], [LocationCode], [BillDate], [PostingTime], [CustomerCode], [CustomerName], [VATNo], [Amount], [Discount], [TaxableAmount], [NonTaxableAmount], [TaxAmount], [TotalAmount], [IsBillActive], [IsBillPrinted], [PrintedTime], [PrintedBy], [EnteredBy], [SyncStatus], [SyncedDate], [SyncedTime], [SyncWithIRD], [IsRealTime]) VALUES (14, N'TI-0048-CHK-075/76', N'Tax Invoice', N'075/76', N'CHK', CAST(N'2019-04-26 00:00:00.000' AS DateTime), CAST(N'15:50:52.6235857' AS Time), N'', N'', N'', CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, 0, CAST(N'2019-04-26 15:56:10.527' AS DateTime), N'', N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Sync Completed', CAST(N'2019-04-26 15:56:11.707' AS DateTime), CAST(N'15:56:11.7065092' AS Time), 1, 1)
SET IDENTITY_INSERT [dbo].[InvoiceMaterializedView] OFF
SET IDENTITY_INSERT [dbo].[ITEM] ON 

INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (61, N'1', N'01', N'Tea - Lemon Green Tea', NULL, N'E', N'Litre', CAST(776.71 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (62, N'2', N'02', N'Artichoke - Bottom, Canned', NULL, N'A', N'Litre', CAST(384.63 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (63, N'3', N'03', N'Goldschalger', NULL, N'C', N'PC', CAST(4556.59 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Morbi vel lectus in quam fringilla rhoncus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (64, N'4', N'04', N'Olives - Black, Pitted', NULL, N'E', N'PC', CAST(4653.94 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'In hac habitasse platea dictumst.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (65, N'5', N'05', N'Lamb - Ground', NULL, N'B', N'Litre', CAST(6403.43 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Duis bibendum.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (66, N'6', N'06', N'Red Currant Jelly', NULL, N'D', N'KG', CAST(9244.75 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Mauris lacinia sapien quis libero.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (67, N'7', N'07', N'Mix - Cocktail Strawberry Daiquiri', NULL, N'B', N'PC', CAST(996.02 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Donec quis orci eget orci vehicula condimentum.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (68, N'8', N'08', N'Flour Pastry Super Fine', NULL, N'E', N'KG', CAST(5519.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Nulla nisl.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (69, N'9', N'09', N'Asparagus - Frozen', NULL, N'B', N'PC', CAST(7859.01 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Vestibulum rutrum rutrum neque.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (70, N'10', N'010', N'Wiberg Cure', NULL, N'A', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, 1, N'Etiam faucibus cursus urna.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (71, N'11', N'011', N'Mushroom - Porcini, Dry', NULL, N'C', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (72, N'12', N'012', N'Sauce - Salsa', NULL, N'E', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Quisque porta volutpat erat.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (73, N'13', N'013', N'Wine - Two Oceans Cabernet', NULL, N'A', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Nam dui.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (74, N'14', N'014', N'Dc - Sakura Fu', NULL, N'A', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Vivamus vel nulla eget eros elementum pellentesque.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (75, N'15', N'015', N'Lamb Tenderloin Nz Fr', NULL, N'E', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Mauris sit amet eros.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (76, N'16', N'016', N'Bread - Raisin', NULL, N'D', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Morbi non quam nec dui luctus rutrum.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (77, N'17', N'017', N'Tart - Butter Plain Squares', NULL, N'C', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Etiam faucibus cursus urna.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (78, N'18', N'018', N'Chef Hat 25cm', NULL, N'D', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Duis aliquam convallis nunc.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (79, N'19', N'019', N'Nut - Walnut, Pieces', NULL, N'A', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Sed accumsan felis.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (80, N'20', N'020', N'Radish - Black, Winter, Organic', NULL, N'C', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Ut tellus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (81, N'21', N'021', N'Gatorade - Xfactor Berry', NULL, N'C', N'Litre', CAST(9278.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (82, N'22', N'022', N'Temperature Recording Station', NULL, N'B', N'PC', CAST(5172.31 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Quisque id justo sit amet sapien dignissim vestibulum.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (83, N'23', N'023', N'Wine - Prem Select Charddonany', NULL, N'A', N'PC', CAST(9974.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'In hac habitasse platea dictumst.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (84, N'24', N'024', N'Coconut - Creamed, Pure', NULL, N'D', N'Litre', CAST(7153.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Vestibulum rutrum rutrum neque.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (85, N'25', N'025', N'Mushrooms - Honey', NULL, N'A', N'PC', CAST(3014.30 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Sed ante.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (86, N'26', N'026', N'Beer - Steamwhistle', NULL, N'C', N'PC', CAST(6709.98 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (87, N'27', N'027', N'Creme De Cacao Mcguines', NULL, N'D', N'PC', CAST(4021.06 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Nunc rhoncus dui vel sem.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (88, N'28', N'028', N'Gatorade - Orange', NULL, N'D', N'Litre', CAST(6331.71 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Nam dui.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (89, N'29', N'029', N'Pepper - Pablano', NULL, N'C', N'PC', CAST(5106.56 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Duis aliquam convallis nunc.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (90, N'30', N'030', N'Meldea Green Tea Liquor', NULL, N'E', N'PC', CAST(5381.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (91, N'31', N'031', N'Mushroom - Chanterelle, Dry', NULL, N'D', N'KG', CAST(9827.54 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (92, N'32', N'032', N'Sweet Pea Sprouts', NULL, N'D', N'PC', CAST(3926.21 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Integer non velit.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (93, N'33', N'033', N'Allspice - Jamaican', NULL, N'A', N'Litre', CAST(8045.22 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Etiam pretium iaculis justo.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (94, N'34', N'034', N'Cake - Night And Day Choclate', NULL, N'B', N'PC', CAST(5268.72 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Phasellus sit amet erat.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (95, N'35', N'035', N'Bread - Bistro Sour', NULL, N'B', N'Litre', CAST(1573.39 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Integer ac neque.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (96, N'36', N'036', N'Muffin Puck Ww Carrot', NULL, N'E', N'KG', CAST(378.61 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Aenean lectus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (97, N'37', N'037', N'Cheese - Victor Et Berthold', NULL, N'C', N'Litre', CAST(8237.99 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (98, N'38', N'038', N'Sprite, Diet - 355ml', NULL, N'A', N'PC', CAST(6276.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Aliquam sit amet diam in magna bibendum imperdiet.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (99, N'39', N'039', N'Filo Dough', NULL, N'A', N'KG', CAST(4914.17 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (100, N'40', N'040', N'Coriander - Seed', NULL, N'B', N'PC', CAST(6255.57 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Nulla facilisi.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (101, N'41', N'041', N'Isomalt', NULL, N'C', N'Litre', CAST(8099.29 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Maecenas rhoncus aliquam lacus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (102, N'42', N'042', N'Tilapia - Fillets', NULL, N'A', N'KG', CAST(8151.52 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Fusce posuere felis sed lacus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (103, N'43', N'043', N'Straws - Cocktale', NULL, N'C', N'KG', CAST(4519.77 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Suspendisse ornare consequat lectus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (104, N'44', N'044', N'Wine - Chablis J Moreau Et Fils', NULL, N'A', N'Litre', CAST(2990.51 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Integer ac leo.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (105, N'45', N'045', N'Banana', NULL, N'B', N'KG', CAST(8624.78 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (106, N'46', N'046', N'Puree - Mocha', NULL, N'D', N'PC', CAST(3301.42 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Nulla ac enim.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (107, N'47', N'047', N'Wonton Wrappers', NULL, N'A', N'KG', CAST(6199.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Sed accumsan felis.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (108, N'48', N'048', N'Lid - 10,12,16 Oz', NULL, N'D', N'PC', CAST(9689.36 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Curabitur at ipsum ac tellus semper interdum.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (109, N'49', N'049', N'Sage - Fresh', NULL, N'E', N'Litre', CAST(1516.99 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Fusce consequat.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (110, N'50', N'050', N'Sauce - Mint', NULL, N'E', N'Litre', CAST(3069.19 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Pellentesque at nulla.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (111, N'51', N'051', N'Kumquat', NULL, N'B', N'KG', CAST(6784.91 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Donec ut dolor.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (112, N'52', N'052', N'Energy Drink Red Bull', NULL, N'C', N'Litre', CAST(6914.02 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (113, N'53', N'053', N'Amarula Cream', NULL, N'B', N'Litre', CAST(2564.26 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Nulla facilisi.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (114, N'54', N'054', N'Crackers - Trio', NULL, N'B', N'Litre', CAST(9091.03 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'In eleifend quam a odio.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (115, N'55', N'055', N'Crab - Claws, 26 - 30', NULL, N'B', N'KG', CAST(1511.34 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Donec vitae nisi.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (116, N'56', N'056', N'Rice - Jasmine Sented', NULL, N'B', N'PC', CAST(5367.01 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Morbi vel lectus in quam fringilla rhoncus.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (117, N'57', N'057', N'Ice Cream Bar - Hageen Daz To', NULL, N'E', N'PC', CAST(3248.73 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Nunc nisl.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (118, N'58', N'058', N'Coffee - Beans, Whole', NULL, N'A', N'PC', CAST(5393.09 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Morbi a ipsum.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (119, N'59', N'059', N'Glass Clear 8 Oz', NULL, N'A', N'KG', CAST(5825.76 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 1, N'Praesent id massa id nisl venenatis lacinia.')
INSERT [dbo].[ITEM] ([Id], [Code], [Bar_Code], [Name], [Parent_Code], [Type], [Unit], [Rate], [Discount], [Is_Discountable], [Is_Vatable], [Remarks]) VALUES (120, N'60', N'060', N'Icecream Bar - Del Monte', NULL, N'D', N'PC', CAST(1364.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, 0, N'Phasellus sit amet erat.')
SET IDENTITY_INSERT [dbo].[ITEM] OFF
INSERT [dbo].[ITEM_CATEGORY] ([Id], [Code], [Parent_Code], [Description], [Indentation], [Order], [Has_Child], [Modified_Date]) VALUES (N'd10ca0aa-12ea-45e1-ac6c-1585c101b604', N'001.01.01', N'001.01', N'Supreme Wine', 3, 3, 0, CAST(N'2019-03-25 22:11:00.000' AS DateTime))
INSERT [dbo].[ITEM_CATEGORY] ([Id], [Code], [Parent_Code], [Description], [Indentation], [Order], [Has_Child], [Modified_Date]) VALUES (N'ed49e3dc-cd9f-4362-bb6b-857b5ffdd2ed', N'001', NULL, N'Liquor', 1, 1, 1, CAST(N'2019-03-25 22:11:00.000' AS DateTime))
INSERT [dbo].[ITEM_CATEGORY] ([Id], [Code], [Parent_Code], [Description], [Indentation], [Order], [Has_Child], [Modified_Date]) VALUES (N'a9de443a-954e-4a2f-b534-89b3adeee9b3', N'001.02', N'001', N'Beer', 1, 1, 1, CAST(N'2019-03-25 10:10:00.000' AS DateTime))
INSERT [dbo].[ITEM_CATEGORY] ([Id], [Code], [Parent_Code], [Description], [Indentation], [Order], [Has_Child], [Modified_Date]) VALUES (N'6a197715-3d13-47fe-9fbb-91f6dc6e8a8b', N'001.01', N'001', N'Wine', 2, 2, 1, CAST(N'2019-03-25 16:02:02.887' AS DateTime))
SET IDENTITY_INSERT [dbo].[ITEM_GROUP] ON 

INSERT [dbo].[ITEM_GROUP] ([Id], [Code], [Description], [Item_Category_Code]) VALUES (1, N'001', N'Beverage', NULL)
INSERT [dbo].[ITEM_GROUP] ([Id], [Code], [Description], [Item_Category_Code]) VALUES (2, N'002', N'Toys', NULL)
SET IDENTITY_INSERT [dbo].[ITEM_GROUP] OFF
SET IDENTITY_INSERT [dbo].[ITEM_TYPE] ON 

INSERT [dbo].[ITEM_TYPE] ([Id], [Code], [Description]) VALUES (1, N'Combo', N'Combo Items')
INSERT [dbo].[ITEM_TYPE] ([Id], [Code], [Description]) VALUES (2, N'Inventory', N'Inventory Items')
INSERT [dbo].[ITEM_TYPE] ([Id], [Code], [Description]) VALUES (3, N'Service', N'Service Items')
INSERT [dbo].[ITEM_TYPE] ([Id], [Code], [Description]) VALUES (4, N'Raw', N'Raw Items')
SET IDENTITY_INSERT [dbo].[ITEM_TYPE] OFF
SET IDENTITY_INSERT [dbo].[MENU] ON 

INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (1, NULL, 1, N'Store Info', N'Store', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (2, NULL, 2, N'Transaction', NULL, NULL, N'', N'dropdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (3, NULL, 3, N'Setup', NULL, NULL, N'', N'dropdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (4, NULL, 4, N'Reports', N'', N'', N'', N'dripdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (5, NULL, 5, N'Help', NULL, NULL, N'', N'dropdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (7, 2, 1, N'Sales Invoice', N'SalesInvoice', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (8, 2, 2, N'Tax Invoice', N'SalesInvoice', N'Index?tax', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (9, 2, 3, N'Credit Note', N'CreditNote', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (10, 2, 3, N'Cash Denomination', N'Denomination', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (11, 3, 1, N'Customer Setup', N'Customer', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (12, 3, 2, N'Item Category Setup', N'ItemCategory', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (13, 3, 3, N'Item Group Setup', N'ItemGroup', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (14, 3, 4, N'Item Setup', N'Item', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (15, 3, 5, N'Terminal Setup', N'Terminal', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (16, 3, 6, N'UserRole Setup', N'Account', N'Roles', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (17, 3, 7, N'User Setup', N'Account', N'Users', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (18, 3, 8, N'RoleWise Permission', N'Account', N'RoleWisePermission', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (19, 5, 1, N'Shortcuts', N'Settings', N'Shortcut', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (20, 2, 4, N'Cash Settlement', N'Settlement', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (21, 4, 1, N'Sales Invoice Report', N'Reports', N'SalesInvoice', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (22, 4, 2, N'Tax Invoice Report', N'Reports', N'TaxInvoice', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (23, 4, 3, N'Credit Note Report', N'Reports', N'CreditNote', N'', N'link')
SET IDENTITY_INSERT [dbo].[MENU] OFF
SET IDENTITY_INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ON 

INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (69, N'--Select Role --', 2)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (70, N'--Select Role --', 8)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (71, N'--Select Role --', 10)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (85, N'8fa9c224-3621-403a-a487-31e434f5bafd', 2)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (86, N'8fa9c224-3621-403a-a487-31e434f5bafd', 8)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (87, N'8fa9c224-3621-403a-a487-31e434f5bafd', 10)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1177, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 3)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1178, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 23)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1179, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 22)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1180, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 21)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1181, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 4)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1182, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 18)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1183, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 17)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1184, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 16)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1185, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 15)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1186, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 14)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1187, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 13)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1188, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 19)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1189, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 11)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1190, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 5)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1191, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 20)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1192, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 10)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1193, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 9)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1194, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 8)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1195, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 7)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1196, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 2)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1197, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 1)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (1198, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 12)
SET IDENTITY_INSERT [dbo].[ROLEWISE_MENU_PERMISSION] OFF
SET IDENTITY_INSERT [dbo].[ROLEWISE_PERMISSION] ON 

INSERT [dbo].[ROLEWISE_PERMISSION] ([Id], [RoleId], [Sales_Discount_Line_Item], [Sales_Discount_Line_Item_Limit], [Sales_Discount_Flat_Item], [Sales_Discount_Flat_Item_Limit], [Sales_Rate_Edit], [Credit_Note_Bill_Pay]) VALUES (2, N'--Select Role --', 1, CAST(100.00 AS Decimal(18, 2)), 1, CAST(100.00 AS Decimal(18, 2)), 1, 0)
INSERT [dbo].[ROLEWISE_PERMISSION] ([Id], [RoleId], [Sales_Discount_Line_Item], [Sales_Discount_Line_Item_Limit], [Sales_Discount_Flat_Item], [Sales_Discount_Flat_Item_Limit], [Sales_Rate_Edit], [Credit_Note_Bill_Pay]) VALUES (7, N'8fa9c224-3621-403a-a487-31e434f5bafd', 1, CAST(100.00 AS Decimal(18, 2)), 1, CAST(100.00 AS Decimal(18, 2)), 0, 0)
INSERT [dbo].[ROLEWISE_PERMISSION] ([Id], [RoleId], [Sales_Discount_Line_Item], [Sales_Discount_Line_Item_Limit], [Sales_Discount_Flat_Item], [Sales_Discount_Flat_Item_Limit], [Sales_Rate_Edit], [Credit_Note_Bill_Pay]) VALUES (1049, N'98bf8710-7dd2-4b82-bd1e-f09a732f9eaa', 1, CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), 0, 1)
SET IDENTITY_INSERT [dbo].[ROLEWISE_PERMISSION] OFF
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'148341f0-5ebd-4bb3-93c7-08bc239516f9', 16, N'TI-0016-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'17:22:03.0374649' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 17:22:03.037' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'59925d27-5163-4a24-858d-08d62f2934ca', 22, N'TI-0022-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'10:26:45.4442065' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 5, CAST(45701.16 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(45681.16 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 10:26:45.447' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'93ab91b7-e927-4670-8951-12bd8b8d6298', 1, N'SI-0001-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:07:15.2183723' AS Time), N'Sales', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 15, CAST(129948.90 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(129948.90 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:07:15.217' AS DateTime), N'Sales', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'4c9908c1-4491-4390-842d-193b0a3b1b8f', 1, N'TI-0001-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:06:12.2181829' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', N'10', N'Sapphire Stansby', N'21695-777', N'', N'544 Vidon Court', CAST(100.00 AS Decimal(18, 2)), NULL, 37, CAST(201892.35 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), NULL, CAST(221656.07 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:06:12.217' AS DateTime), N'Return', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'90e7ae34-da2f-458d-bbde-1c891831f1b2', 24, N'TI-0024-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'10:28:01.3814593' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(20445.55 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(20445.55 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 10:28:01.380' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'35bb62ba-cc7f-4812-8195-1dc00f471686', 47, N'TI-0047-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:39:47.2767665' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 15, CAST(94113.20 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(94093.20 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:39:47.277' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'565b67ae-ee86-481d-8485-1fa5830e5259', 40, N'TI-0040-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:51:32.5731384' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:51:32.573' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'34f0755e-87e1-4451-b2f8-21650665032b', 18, N'TI-0018-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'23:05:34.1103495' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'41', N'Jacynth Pickavance', N'0186-0324', N'', N'6 Scofield Avenue', NULL, NULL, 14, CAST(124911.70 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(10910.03 AS Decimal(18, 2)), CAST(124891.70 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 23:05:34.110' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'9d7f103f-a717-447b-ab81-217d4d9cd79a', 20, N'TI-0020-CHK-075/76', CAST(N'2019-04-23 00:00:00.000' AS DateTime), N'2076-01-10', CAST(N'11:54:25.2988272' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-23 11:54:25.300' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'1e589179-0b11-4bf9-a966-234b521f2ac2', 23, N'TI-0023-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'10:27:46.1750929' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(15273.24 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(15273.24 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 10:27:46.177' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'31983c96-c286-4543-b059-24f6d7dd846b', 10, N'TI-0010-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:42:21.9539416' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:42:21.953' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'5da54d6e-4ffc-4a32-8a58-26d86329c4cc', 2, N'SI-0002-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:54:47.5063359' AS Time), N'Sales', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(4545.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:54:47.507' AS DateTime), N'Return', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'21468d75-aad7-453c-8a1c-28ab9e601d44', 26, N'TI-0026-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'10:37:22.0590213' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 10:37:22.060' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'566d7c72-ad84-4edb-98d6-2c1d4a8cffd1', 29, N'TI-0029-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'12:41:11.2084423' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(15273.24 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(15273.24 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 12:41:11.207' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'2fd70692-dc41-4005-bda1-2c81d1a21139', 12, N'TI-0012-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:48:48.8183058' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:48:48.820' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'ccc5d318-aee3-4ae2-837c-340c3c22dec5', 46, N'TI-0046-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:36:31.8241006' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 5, CAST(39623.79 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(39603.79 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:36:31.823' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'99f62c8f-b968-4ed4-bd74-3bd5616bac9e', 41, N'TI-0041-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:53:25.1725344' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:53:25.173' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'b3da82d6-886d-4be0-88c1-42282e130a54', 19, N'TI-0019-CHK-075/76', CAST(N'2019-04-19 00:00:00.000' AS DateTime), N'2076-01-06', CAST(N'12:41:23.5926291' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(23864.89 AS Decimal(18, 2)), CAST(40.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(23824.89 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-19 12:41:23.593' AS DateTime), N'Sales', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'5b236026-06a9-4e88-8cbd-423b0325913d', 30, N'TI-0030-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'12:53:25.0785637' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 12:53:25.080' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'eb2d9b53-83ea-4161-8b70-438de0ed309b', 3, N'TI-0003-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'11:05:04.4418565' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 5, CAST(47726.95 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), NULL, CAST(53818.45 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 11:05:04.443' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'bae1c68c-4f31-4848-b3d0-57f13b642d9f', 33, N'TI-0033-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'14:08:00.4371189' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 14:08:00.437' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'ce243ef7-03d9-4d68-9e7d-57faf3fed513', 3, N'SI-0003-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'23:59:53.9139016' AS Time), N'Sales', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(4167.82 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 23:59:53.913' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'229c7863-3ac0-4c62-bbf4-5e11c09adabf', 9, N'TI-0009-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:39:44.6847159' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:39:44.687' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'b1717927-33a7-4ead-a088-6009aa77b502', 35, N'TI-0035-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:29:11.4526580' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:29:11.453' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'e9068abb-2d65-4d79-93f5-602b22fb51ff', 7, N'TI-0007-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'14:51:12.6007011' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(28636.17 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(28616.17 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 14:51:12.600' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'95340e44-4b7b-40fb-9ba3-69a2c16671cc', 14, N'TI-0014-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'17:01:38.3873941' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(5994.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 17:01:38.387' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'202f6769-af9a-4a04-943a-6d60105de480', 39, N'TI-0039-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:47:45.4911721' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:47:45.493' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'f408f990-600b-4676-90e7-6e255f1d9aa6', 32, N'TI-0032-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'13:59:58.4101613' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 13:59:58.410' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'ba4c9806-53d6-4d21-9e40-73ca3cef9594', 8, N'TI-0008-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:38:34.7393733' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:38:34.740' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'216f6972-168a-4f87-b515-74b3545beadc', 21, N'TI-0021-CHK-075/76', CAST(N'2019-04-23 00:00:00.000' AS DateTime), N'2076-01-10', CAST(N'12:03:22.5295549' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-23 12:03:22.530' AS DateTime), N'Return', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'7cd7ce31-6a94-4072-8efe-7746bc50756b', 34, N'TI-0034-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'14:08:16.5130240' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 4, CAST(36155.77 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(36135.77 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 14:08:16.513' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'78d62485-578c-47d1-9750-8aff6dfb73b8', 15, N'TI-0015-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'17:17:47.0332619' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 17:17:47.033' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'cce8484a-d417-43c8-afc1-8e615e76ac73', 25, N'TI-0025-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'10:28:18.7907033' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 4, CAST(21263.02 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(21263.02 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 10:28:18.790' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'c7abd902-f889-4596-98cd-9c8fea2b931e', 28, N'TI-0028-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'12:40:31.8362357' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(25989.78 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(25969.78 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 12:40:31.837' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'0d9458ff-54e5-4208-9d04-9d9d0d5d79ff', 37, N'TI-0037-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:37:30.9186228' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:37:30.920' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', 4, N'TI-0004-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'14:58:16.9730884' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 42, CAST(388200.88 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(438666.99 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 14:58:16.973' AS DateTime), N'Tax', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'0672b2a8-7583-44fb-84a4-afdf826ddf1c', 45, N'TI-0045-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:09:21.1077632' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:09:21.107' AS DateTime), N'Return', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'f981fbbc-05c9-477d-97e1-b3504dbd7f77', 43, N'TI-0043-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:00:25.2634163' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:00:25.263' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'b60b1c39-2200-43fc-bc02-b43880f8e0c2', 6, N'TI-0006-CHK-075/76', CAST(N'2019-04-17 00:00:00.000' AS DateTime), N'2076-01-04', CAST(N'13:59:18.5004710' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'40', N'ABC Company', N'', N'8989898989', N'', NULL, NULL, 3, CAST(26610.38 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(26610.38 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-17 13:59:18.500' AS DateTime), N'Return', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'b99d6972-ea24-4a35-9b4e-b6a3b64fa23d', 13, N'TI-0013-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:52:40.8845724' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 5, CAST(47726.95 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(47706.95 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:52:40.887' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'44122da0-5825-4487-98cf-ba98a7f86cb6', 38, N'TI-0038-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:42:25.9866745' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:42:25.987' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'b17708ec-47ae-464f-b1fe-bfc1f6f61fd5', 31, N'TI-0031-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'13:59:46.1103901' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(19090.78 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(19070.78 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 13:59:46.110' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'754ed6ec-bfa3-4a68-ba18-c359f8b53576', 27, N'TI-0027-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'10:37:46.4935083' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 10:37:46.493' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'0afe9926-3789-4354-b7a9-c3e28e59ad0a', 42, N'TI-0042-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:59:05.4820088' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:59:05.483' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'425167c2-c0e2-4397-88fc-d9ff5c4dfd30', 44, N'TI-0044-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:01:45.4714085' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 3, CAST(25989.78 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(25969.78 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:01:45.470' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'5d24a39b-c960-466b-b44f-dc805ad4ead2', 5, N'TI-0005-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'20:17:10.2464657' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 9, CAST(68034.71 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(75732.62 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 20:17:10.247' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'32fbb9f0-d48d-4149-982a-e1dd9f7c1809', 48, N'TI-0048-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:50:52.6235857' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:50:52.623' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'dee80f9b-927a-4d7a-9e7b-ec1f9794058f', 36, N'TI-0036-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:35:43.0198324' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:35:43.020' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'b83d2321-a177-4b85-9f85-f57ebe5144f2', 11, N'TI-0011-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'16:44:52.0011171' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 16:44:52.003' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'2c6a3703-4c80-4388-9645-fbc8f19b4172', 2, N'TI-0002-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:15:16.2599703' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 30, CAST(127516.57 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(142274.72 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:15:16.260' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [TaxableAmount], [NonTaxableAmount]) VALUES (N'd2ba20a2-4c70-4e1d-bc95-fcab49b940d9', 17, N'TI-0017-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'17:25:13.1663609' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 17:25:13.167' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_BILL] ON 

INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1021, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'Tax', N'TI-0001-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(221656.07 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1022, N'93ab91b7-e927-4670-8951-12bd8b8d6298', N'Sales', N'SI-0001-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(129948.90 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1023, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'Tax', N'TI-0002-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(142274.72 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1024, N'eb2d9b53-83ea-4161-8b70-438de0ed309b', N'Tax', N'TI-0003-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(55818.45 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1025, N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', N'Tax', N'TI-0004-CHK-075/76', NULL, NULL, N'Debit Card', N'CREDIT CARD A\C', CAST(438228.99 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1026, N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', N'Tax', N'TI-0004-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(438.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1027, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'Tax', N'TI-0005-CHK-075/76', NULL, NULL, N'Debit Card', N'CREDIT CARD A\C', CAST(6815.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1028, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'Tax', N'TI-0005-CHK-075/76', NULL, NULL, N'Credit', N'Sapphire Stansby', CAST(61344.62 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1029, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'Tax', N'TI-0005-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(7600.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1030, N'b60b1c39-2200-43fc-bc02-b43880f8e0c2', N'Tax', N'TI-0006-CHK-075/76', NULL, NULL, N'Debit Card', N'', CAST(25610.38 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1031, N'b60b1c39-2200-43fc-bc02-b43880f8e0c2', N'Tax', N'TI-0006-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(1000.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1032, N'e9068abb-2d65-4d79-93f5-602b22fb51ff', N'Tax', N'TI-0007-CHK-075/76', NULL, NULL, N'Credit Note', N'CN-0002-075/75', CAST(142274.74 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1033, N'ba4c9806-53d6-4d21-9e40-73ca3cef9594', N'Tax', N'TI-0008-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1034, N'229c7863-3ac0-4c62-bbf4-5e11c09adabf', N'Tax', N'TI-0009-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1035, N'31983c96-c286-4543-b059-24f6d7dd846b', N'Tax', N'TI-0010-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1036, N'b83d2321-a177-4b85-9f85-f57ebe5144f2', N'Tax', N'TI-0011-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1037, N'2fd70692-dc41-4005-bda1-2c81d1a21139', N'Tax', N'TI-0012-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1038, N'b99d6972-ea24-4a35-9b4e-b6a3b64fa23d', N'Tax', N'TI-0013-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(47706.95 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1039, N'5da54d6e-4ffc-4a32-8a58-26d86329c4cc', N'Sales', N'SI-0002-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(4545.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1040, N'95340e44-4b7b-40fb-9ba3-69a2c16671cc', N'Tax', N'TI-0014-CHK-075/76', NULL, NULL, N'Credit Note', N'CN-0003-075/75', CAST(5994.44 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1041, N'95340e44-4b7b-40fb-9ba3-69a2c16671cc', N'Tax', N'TI-0014-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(5994.44 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1042, N'78d62485-578c-47d1-9750-8aff6dfb73b8', N'Tax', N'TI-0015-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1043, N'148341f0-5ebd-4bb3-93c7-08bc239516f9', N'Tax', N'TI-0016-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (1044, N'd2ba20a2-4c70-4e1d-bc95-fcab49b940d9', N'Tax', N'TI-0017-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2036, N'34f0755e-87e1-4451-b2f8-21650665032b', N'Tax', N'TI-0018-CHK-075/76', NULL, NULL, N'Credit Note', N'CN-0004-075/75', CAST(124891.70 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2037, N'34f0755e-87e1-4451-b2f8-21650665032b', N'Tax', N'TI-0018-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(124891.70 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2038, N'ce243ef7-03d9-4d68-9e7d-57faf3fed513', N'Sales', N'SI-0003-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(4167.82 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2039, N'b3da82d6-886d-4be0-88c1-42282e130a54', N'Tax', N'TI-0019-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(23824.89 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2043, N'9d7f103f-a717-447b-ab81-217d4d9cd79a', N'Tax', N'TI-0020-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2044, N'216f6972-168a-4f87-b515-74b3545beadc', N'Tax', N'TI-0021-CHK-075/76', NULL, NULL, N'Debit Card', N'ATM Card', CAST(17044.99 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2045, N'216f6972-168a-4f87-b515-74b3545beadc', N'Tax', N'TI-0021-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(17044.99 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2046, N'59925d27-5163-4a24-858d-08d62f2934ca', N'Tax', N'TI-0022-CHK-075/76', NULL, NULL, N'Credit', N'12', CAST(45681.16 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2047, N'59925d27-5163-4a24-858d-08d62f2934ca', N'Tax', N'TI-0022-CHK-075/76', NULL, NULL, N'Debit Card', N'ATM Card', CAST(45681.16 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2048, N'59925d27-5163-4a24-858d-08d62f2934ca', N'Tax', N'TI-0022-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(45681.16 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2049, N'1e589179-0b11-4bf9-a966-234b521f2ac2', N'Tax', N'TI-0023-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(15273.24 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2050, N'90e7ae34-da2f-458d-bbde-1c891831f1b2', N'Tax', N'TI-0024-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(20445.55 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2051, N'cce8484a-d417-43c8-afc1-8e615e76ac73', N'Tax', N'TI-0025-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(21263.02 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2052, N'21468d75-aad7-453c-8a1c-28ab9e601d44', N'Tax', N'TI-0026-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2053, N'754ed6ec-bfa3-4a68-ba18-c359f8b53576', N'Tax', N'TI-0027-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(7519.60 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2054, N'c7abd902-f889-4596-98cd-9c8fea2b931e', N'Tax', N'TI-0028-CHK-075/76', NULL, NULL, N'Credit', N'16', CAST(25969.78 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2055, N'c7abd902-f889-4596-98cd-9c8fea2b931e', N'Tax', N'TI-0028-CHK-075/76', NULL, NULL, N'Debit Card', N'ATM Card', CAST(25969.78 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2056, N'c7abd902-f889-4596-98cd-9c8fea2b931e', N'Tax', N'TI-0028-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(25969.78 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2057, N'566d7c72-ad84-4edb-98d6-2c1d4a8cffd1', N'Tax', N'TI-0029-CHK-075/76', NULL, NULL, N'Debit Card', N'ATM Card', CAST(15273.24 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2058, N'566d7c72-ad84-4edb-98d6-2c1d4a8cffd1', N'Tax', N'TI-0029-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(15273.24 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2059, N'5b236026-06a9-4e88-8cbd-423b0325913d', N'Tax', N'TI-0030-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2063, N'b17708ec-47ae-464f-b1fe-bfc1f6f61fd5', N'Tax', N'TI-0031-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(19070.78 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2064, N'f408f990-600b-4676-90e7-6e255f1d9aa6', N'Tax', N'TI-0032-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2065, N'bae1c68c-4f31-4848-b3d0-57f13b642d9f', N'Tax', N'TI-0033-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2066, N'7cd7ce31-6a94-4072-8efe-7746bc50756b', N'Tax', N'TI-0034-CHK-075/76', NULL, NULL, N'Debit Card', N'ATM Card', CAST(36135.77 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2067, N'7cd7ce31-6a94-4072-8efe-7746bc50756b', N'Tax', N'TI-0034-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(36135.77 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2068, N'b1717927-33a7-4ead-a088-6009aa77b502', N'Tax', N'TI-0035-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2069, N'dee80f9b-927a-4d7a-9e7b-ec1f9794058f', N'Tax', N'TI-0036-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2070, N'0d9458ff-54e5-4208-9d04-9d9d0d5d79ff', N'Tax', N'TI-0037-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2071, N'44122da0-5825-4487-98cf-ba98a7f86cb6', N'Tax', N'TI-0038-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2072, N'202f6769-af9a-4a04-943a-6d60105de480', N'Tax', N'TI-0039-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2073, N'565b67ae-ee86-481d-8485-1fa5830e5259', N'Tax', N'TI-0040-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(17044.99 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2074, N'99f62c8f-b968-4ed4-bd74-3bd5616bac9e', N'Tax', N'TI-0041-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2075, N'0afe9926-3789-4354-b7a9-c3e28e59ad0a', N'Tax', N'TI-0042-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2076, N'f981fbbc-05c9-477d-97e1-b3504dbd7f77', N'Tax', N'TI-0043-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2077, N'425167c2-c0e2-4397-88fc-d9ff5c4dfd30', N'Tax', N'TI-0044-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(25969.78 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2080, N'0672b2a8-7583-44fb-84a4-afdf826ddf1c', N'Tax', N'TI-0045-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(9525.39 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2081, N'ccc5d318-aee3-4ae2-837c-340c3c22dec5', N'Tax', N'TI-0046-CHK-075/76', NULL, NULL, N'Cash', N'', CAST(39603.79 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2082, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'Tax', N'TI-0047-CHK-075/76', NULL, NULL, N'Debit Card', N'ATM Card', CAST(94093.20 AS Decimal(18, 2)), NULL)
INSERT [dbo].[SALES_INVOICE_BILL] ([Id], [Invoice_Id], [Invoice_Type], [Invoice_Number], [Division], [Terminal], [Trans_Mode], [Account], [Amount], [Remarks]) VALUES (2083, N'32fbb9f0-d48d-4149-982a-e1dd9f7c1809', N'Tax', N'TI-0048-CHK-075/76', NULL, NULL, N'Credit Note', N'CN-0006-075/75', CAST(9525.39 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_BILL] OFF
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS] ON 

INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1, N'b3da82d6-886d-4be0-88c1-42282e130a54', N'TI-0019-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(7475.44 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7475.44 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(971.81 AS Decimal(18, 2)), CAST(8427.25 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (2, N'b3da82d6-886d-4be0-88c1-42282e130a54', N'TI-0019-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7509.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (3, N'b3da82d6-886d-4be0-88c1-42282e130a54', N'TI-0019-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(6989.42 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(6989.42 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), 1, CAST(908.62 AS Decimal(18, 2)), CAST(7888.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (4, N'9d7f103f-a717-447b-ab81-217d4d9cd79a', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (5, N'216f6972-168a-4f87-b515-74b3545beadc', N'TI-0021-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (6, N'216f6972-168a-4f87-b515-74b3545beadc', N'TI-0021-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (7, N'59925d27-5163-4a24-858d-08d62f2934ca', N'TI-0022-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (8, N'59925d27-5163-4a24-858d-08d62f2934ca', N'TI-0022-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(33788.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(4392.57 AS Decimal(18, 2)), CAST(38161.56 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (9, N'1e589179-0b11-4bf9-a966-234b521f2ac2', N'TI-0023-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(8211.33 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8211.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1067.47 AS Decimal(18, 2)), CAST(9278.80 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (10, N'1e589179-0b11-4bf9-a966-234b521f2ac2', N'TI-0023-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (11, N'90e7ae34-da2f-458d-bbde-1c891831f1b2', N'TI-0024-CHK-075/76', N'022', N'Temperature Recording Station', N'PC', CAST(5172.31 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5172.31 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(5172.31 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (12, N'90e7ae34-da2f-458d-bbde-1c891831f1b2', N'TI-0024-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(8211.33 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8211.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1067.47 AS Decimal(18, 2)), CAST(9278.80 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (13, N'90e7ae34-da2f-458d-bbde-1c891831f1b2', N'TI-0024-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (14, N'cce8484a-d417-43c8-afc1-8e615e76ac73', N'TI-0025-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(3688.34 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3688.34 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(479.48 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (15, N'cce8484a-d417-43c8-afc1-8e615e76ac73', N'TI-0025-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(575.94 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(575.94 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(74.87 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (16, N'cce8484a-d417-43c8-afc1-8e615e76ac73', N'TI-0025-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (17, N'cce8484a-d417-43c8-afc1-8e615e76ac73', N'TI-0025-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (18, N'21468d75-aad7-453c-8a1c-28ab9e601d44', N'TI-0026-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (19, N'754ed6ec-bfa3-4a68-ba18-c359f8b53576', N'TI-0027-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (20, N'c7abd902-f889-4596-98cd-9c8fea2b931e', N'TI-0028-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (21, N'c7abd902-f889-4596-98cd-9c8fea2b931e', N'TI-0028-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (22, N'c7abd902-f889-4596-98cd-9c8fea2b931e', N'TI-0028-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (23, N'566d7c72-ad84-4edb-98d6-2c1d4a8cffd1', N'TI-0029-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(8211.33 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8211.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1067.47 AS Decimal(18, 2)), CAST(9278.80 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (24, N'566d7c72-ad84-4edb-98d6-2c1d4a8cffd1', N'TI-0029-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (25, N'5b236026-06a9-4e88-8cbd-423b0325913d', N'TI-0030-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (26, N'b17708ec-47ae-464f-b1fe-bfc1f6f61fd5', N'TI-0031-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(16894.50 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(2196.28 AS Decimal(18, 2)), CAST(19070.78 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (27, N'f408f990-600b-4676-90e7-6e255f1d9aa6', N'TI-0032-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (28, N'bae1c68c-4f31-4848-b3d0-57f13b642d9f', N'TI-0033-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (29, N'7cd7ce31-6a94-4072-8efe-7746bc50756b', N'TI-0034-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (30, N'7cd7ce31-6a94-4072-8efe-7746bc50756b', N'TI-0034-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(25341.74 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(3294.43 AS Decimal(18, 2)), CAST(28616.17 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (31, N'b1717927-33a7-4ead-a088-6009aa77b502', N'TI-0035-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (32, N'dee80f9b-927a-4d7a-9e7b-ec1f9794058f', N'TI-0036-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (33, N'0d9458ff-54e5-4208-9d04-9d9d0d5d79ff', N'TI-0037-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (34, N'44122da0-5825-4487-98cf-ba98a7f86cb6', N'TI-0038-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (35, N'202f6769-af9a-4a04-943a-6d60105de480', N'TI-0039-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (36, N'565b67ae-ee86-481d-8485-1fa5830e5259', N'TI-0040-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (37, N'565b67ae-ee86-481d-8485-1fa5830e5259', N'TI-0040-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (38, N'99f62c8f-b968-4ed4-bd74-3bd5616bac9e', N'TI-0041-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (39, N'0afe9926-3789-4354-b7a9-c3e28e59ad0a', N'TI-0042-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (40, N'f981fbbc-05c9-477d-97e1-b3504dbd7f77', N'TI-0043-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (41, N'425167c2-c0e2-4397-88fc-d9ff5c4dfd30', N'TI-0044-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (42, N'425167c2-c0e2-4397-88fc-d9ff5c4dfd30', N'TI-0044-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (43, N'425167c2-c0e2-4397-88fc-d9ff5c4dfd30', N'TI-0044-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (44, N'0672b2a8-7583-44fb-84a4-afdf826ddf1c', N'TI-0045-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (45, N'ccc5d318-aee3-4ae2-837c-340c3c22dec5', N'TI-0046-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(30078.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(30078.40 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (46, N'ccc5d318-aee3-4ae2-837c-340c3c22dec5', N'TI-0046-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (47, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(42236.24 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), 0, CAST(5490.71 AS Decimal(18, 2)), CAST(47706.95 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (48, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(152.97 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(152.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(19.89 AS Decimal(18, 2)), CAST(172.86 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (49, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (50, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (51, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1109.75 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(1109.75 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(144.27 AS Decimal(18, 2)), CAST(1254.02 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (52, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3151.73 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3151.73 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(409.72 AS Decimal(18, 2)), CAST(3561.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (53, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(4708.37 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(4708.37 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(612.09 AS Decimal(18, 2)), CAST(5320.46 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (54, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(3688.34 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3688.34 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(479.48 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (55, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(575.94 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(575.94 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(74.87 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (56, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (57, N'35bb62ba-cc7f-4812-8195-1dc00f471686', N'TI-0047-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (58, N'32fbb9f0-d48d-4149-982a-e1dd9f7c1809', N'TI-0048-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS] OFF
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ON 

INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (21, NULL, N'TI-0019-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(7475.44 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7475.44 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(971.81 AS Decimal(18, 2)), CAST(8427.25 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (22, NULL, N'TI-0019-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7509.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (23, NULL, N'TI-0019-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(6989.42 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(6989.42 AS Decimal(18, 2)), CAST(10.00 AS Decimal(18, 2)), 1, CAST(908.62 AS Decimal(18, 2)), CAST(7888.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (89, N'9f671018-ae4d-4af8-9817-1f7ec07cce2a', N'TI-0020-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(6989.42 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(13978.83 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1817.25 AS Decimal(18, 2)), CAST(15796.08 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (90, N'9f671018-ae4d-4af8-9817-1f7ec07cce2a', N'TI-0020-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(15039.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(15039.20 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (91, N'9f671018-ae4d-4af8-9817-1f7ec07cce2a', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(7475.44 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(37377.21 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(4859.04 AS Decimal(18, 2)), CAST(42216.25 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (92, N'9f671018-ae4d-4af8-9817-1f7ec07cce2a', N'TI-0020-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(509.68 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(509.68 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(66.26 AS Decimal(18, 2)), CAST(575.94 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (93, N'967d17ec-2671-4e3a-9fdf-1cc1afc54058', N'TI-0020-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (94, N'967d17ec-2671-4e3a-9fdf-1cc1afc54058', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (101, N'b0b37e90-10dd-4429-865d-d731b1a3d0f3', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(25341.74 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(3294.43 AS Decimal(18, 2)), CAST(28616.17 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1079, N'7b60e898-fd6d-4889-95b7-0ebee7b6fab4', N'TI-0020-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1080, N'7b60e898-fd6d-4889-95b7-0ebee7b6fab4', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1081, N'449f5807-970c-412d-938f-cabcdcdbfe13', N'TI-0020-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1082, N'449f5807-970c-412d-938f-cabcdcdbfe13', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1083, NULL, N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1084, NULL, N'TI-0021-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1085, NULL, N'TI-0021-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1092, N'3070e9bf-8cb1-48f6-9164-d989456c3355', N'TI-0020-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1093, N'3070e9bf-8cb1-48f6-9164-d989456c3355', N'TI-0020-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(15039.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(15039.20 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1094, N'3070e9bf-8cb1-48f6-9164-d989456c3355', N'TI-0020-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1095, N'3070e9bf-8cb1-48f6-9164-d989456c3355', N'TI-0020-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(575.94 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(575.94 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(74.87 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1096, N'3070e9bf-8cb1-48f6-9164-d989456c3355', N'TI-0020-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(3688.34 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3688.34 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(479.48 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1097, N'3070e9bf-8cb1-48f6-9164-d989456c3355', N'TI-0020-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3151.73 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3151.73 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(409.72 AS Decimal(18, 2)), CAST(3561.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1100, N'0a4527d9-d316-43eb-b5ba-5d511ba2b9bf', N'TI-0022-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(22558.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(22558.80 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1101, NULL, N'TI-0022-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1102, NULL, N'TI-0022-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(33788.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(4392.57 AS Decimal(18, 2)), CAST(38161.56 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1103, NULL, N'TI-0023-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(8211.33 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8211.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1067.47 AS Decimal(18, 2)), CAST(9278.80 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1104, NULL, N'TI-0023-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1105, NULL, N'TI-0024-CHK-075/76', N'022', N'Temperature Recording Station', N'PC', CAST(5172.31 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5172.31 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(5172.31 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1106, NULL, N'TI-0024-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(8211.33 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8211.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1067.47 AS Decimal(18, 2)), CAST(9278.80 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1107, NULL, N'TI-0024-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1108, NULL, N'TI-0025-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(3688.34 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3688.34 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(479.48 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1109, NULL, N'TI-0025-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(575.94 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(575.94 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(74.87 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1110, NULL, N'TI-0025-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1111, NULL, N'TI-0025-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1112, NULL, N'TI-0026-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1113, NULL, N'TI-0027-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1114, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5994.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1115, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1116, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(1254.02 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(1254.02 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1117, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3561.45 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(3561.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1118, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1119, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1120, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8924.79 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1121, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(650.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1122, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(4167.82 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1123, N'2603dd34-654c-4ed1-9315-6587f02ac33b', N'SI-0022-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(5320.46 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1124, N'0d2e6421-b288-4220-9e54-9f01c78661b7', N'TI-0028-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1125, NULL, N'TI-0028-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1126, NULL, N'TI-0028-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1127, NULL, N'TI-0028-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1128, NULL, N'TI-0029-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(8211.33 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8211.33 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1067.47 AS Decimal(18, 2)), CAST(9278.80 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1129, NULL, N'TI-0029-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1130, NULL, N'TI-0030-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1131, N'd3587774-f5fe-4c40-8815-4be1be5ee767', N'TI-0031-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1132, NULL, N'TI-0031-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(16894.50 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(2196.28 AS Decimal(18, 2)), CAST(19070.78 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1133, NULL, N'TI-0032-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1134, NULL, N'TI-0033-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1135, NULL, N'TI-0034-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1136, NULL, N'TI-0034-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(25341.74 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(3294.43 AS Decimal(18, 2)), CAST(28616.17 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1137, NULL, N'TI-0035-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1138, NULL, N'TI-0036-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1139, NULL, N'TI-0037-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1140, NULL, N'TI-0038-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1141, NULL, N'TI-0039-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1142, NULL, N'TI-0040-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1143, NULL, N'TI-0040-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1144, NULL, N'TI-0040-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1145, NULL, N'TI-0042-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1146, NULL, N'TI-0043-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1147, NULL, N'TI-0044-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1148, NULL, N'TI-0044-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1149, NULL, N'TI-0044-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1150, N'c01432c5-3334-404f-bcdf-b1be09e92237', N'TI-0045-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1151, NULL, N'TI-0045-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1152, NULL, N'TI-0046-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(30078.40 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(30078.40 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1153, NULL, N'TI-0046-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1154, NULL, N'TI-0047-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(42236.24 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), 0, CAST(5490.71 AS Decimal(18, 2)), CAST(47706.95 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1155, NULL, N'TI-0047-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(152.97 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(152.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(19.89 AS Decimal(18, 2)), CAST(172.86 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1156, NULL, N'TI-0047-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5304.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5304.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(689.63 AS Decimal(18, 2)), CAST(5994.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1157, NULL, N'TI-0047-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1158, NULL, N'TI-0047-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1109.75 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(1109.75 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(144.27 AS Decimal(18, 2)), CAST(1254.02 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1159, NULL, N'TI-0047-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3151.73 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3151.73 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(409.72 AS Decimal(18, 2)), CAST(3561.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1160, NULL, N'TI-0047-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(4708.37 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(4708.37 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(612.09 AS Decimal(18, 2)), CAST(5320.46 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1161, NULL, N'TI-0047-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(3688.34 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3688.34 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(479.48 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1162, NULL, N'TI-0047-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(575.94 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(575.94 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(74.87 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1163, NULL, N'TI-0047-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(7898.04 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7898.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(1026.75 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1164, NULL, N'TI-0047-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(7519.60 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), 1, CAST(0.00 AS Decimal(18, 2)), CAST(7519.60 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1165, N'a989acfa-d3fc-44eb-a693-f648c1161311', N'TI-0048-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Is_Discountable], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1166, NULL, N'TI-0048-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(8447.25 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8447.25 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), 0, CAST(1098.14 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), 1, NULL)
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] OFF
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'7b60e898-fd6d-4889-95b7-0ebee7b6fab4', 0, N'TI-0020-CHK-075/76', CAST(N'2019-04-23 00:00:00.000' AS DateTime), N'2076-01-10', CAST(N'11:48:12.9270722' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-23 11:48:12.927' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'967d17ec-2671-4e3a-9fdf-1cc1afc54058', 0, N'TI-0020-CHK-075/76', CAST(N'2019-04-22 00:00:00.000' AS DateTime), N'2076-01-09', CAST(N'12:54:43.4445616' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), NULL, CAST(N'2019-04-22 12:54:43.447' AS DateTime), N'Sales', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'9f671018-ae4d-4af8-9817-1f7ec07cce2a', 0, N'TI-0020-CHK-075/76', CAST(N'2019-04-22 00:00:00.000' AS DateTime), N'2076-01-09', CAST(N'12:53:50.3335463' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 10, CAST(73647.47 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(73627.47 AS Decimal(18, 2)), NULL, CAST(N'2019-04-22 12:53:50.333' AS DateTime), N'Sales', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'074f2bc5-57ab-4c41-b224-39e0573332d3', 0, N'TI-0006-CHK-075/76', CAST(N'2019-04-17 00:00:00.000' AS DateTime), N'2076-01-04', CAST(N'13:16:18.7211367' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'38', N'Bob Gummory', N'42023-159', N'', N'31912 Memorial Center', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1098.14 AS Decimal(18, 2)), CAST(17064.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-17 13:16:19.770' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'd3587774-f5fe-4c40-8815-4be1be5ee767', 0, N'TI-0031-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'13:59:08.3909632' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), NULL, CAST(N'2019-04-24 13:59:08.393' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'0a4527d9-d316-43eb-b5ba-5d511ba2b9bf', 0, N'TI-0022-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'09:43:35.4948393' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(22558.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(22558.80 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 09:43:35.497' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'b1717927-33a7-4ead-a088-6009aa77b502', 0, N'TI-0035-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:29:11.4526580' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:29:11.453' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'2603dd34-654c-4ed1-9315-6587f02ac33b', 0, N'SI-0022-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'11:10:55.9992175' AS Time), N'Hold', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 10, CAST(55758.78 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(55738.78 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 11:10:56.000' AS DateTime), N'Sales', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'3cbe19fa-8797-4f9c-9d6c-8aa9181a40c8', 0, N'TI-0007-CHK-075/76', CAST(N'2019-04-18 00:00:00.000' AS DateTime), N'2076-01-05', CAST(N'14:46:08.6794661' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(28636.17 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(28616.17 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-18 14:46:08.680' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'0d2e6421-b288-4220-9e54-9f01c78661b7', 0, N'TI-0028-CHK-075/76', CAST(N'2019-04-24 00:00:00.000' AS DateTime), N'2076-01-11', CAST(N'11:25:21.4056912' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 11:25:21.407' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'c01432c5-3334-404f-bcdf-b1be09e92237', 0, N'TI-0045-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:08:33.8041822' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'1', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), NULL, CAST(N'2019-04-26 15:08:33.803' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'0b5d372b-4e2d-4a41-aab6-c36037ae6299', 0, N'TI-0006-CHK-075/76', CAST(N'2019-04-17 00:00:00.000' AS DateTime), N'2076-01-04', CAST(N'13:23:18.7655985' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'39', N'Kitti Chappell', N'0703-4244', N'', N'9 Kinsman Parkway', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(1098.14 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-17 13:23:18.767' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'449f5807-970c-412d-938f-cabcdcdbfe13', 0, N'TI-0020-CHK-075/76', CAST(N'2019-04-23 00:00:00.000' AS DateTime), N'2076-01-10', CAST(N'11:50:33.8609203' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(17044.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-23 11:50:33.860' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'b0b37e90-10dd-4429-865d-d731b1a3d0f3', 0, N'TI-0020-CHK-075/76', CAST(N'2019-04-22 00:00:00.000' AS DateTime), N'2076-01-09', CAST(N'13:03:30.9217127' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', NULL, N'', N'', N'', N'', NULL, NULL, 3, CAST(28636.17 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(28616.17 AS Decimal(18, 2)), NULL, CAST(N'2019-04-22 13:03:30.923' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'3070e9bf-8cb1-48f6-9164-d989456c3355', 0, N'TI-0020-CHK-075/76', CAST(N'2019-04-22 00:00:00.000' AS DateTime), N'2076-01-09', CAST(N'09:29:51.6691742' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'4', N'Ilysa Shellibeer', N'59779-860', N'', N'93593 Hagan Junction', NULL, NULL, 7, CAST(41889.46 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(41869.46 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-24 09:29:51.670' AS DateTime), N'Sales', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'527c79b3-776e-4712-b07e-db25aa4d93e3', 0, N'TI-0006-CHK-075/76', CAST(N'2019-04-17 00:00:00.000' AS DateTime), N'2076-01-04', CAST(N'13:11:39.1443500' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'38', N'Bob Gummory', N'42023-159', N'', N'31912 Memorial Center', NULL, NULL, 2, CAST(17064.99 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(17064.99 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-17 13:11:39.143' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'dee80f9b-927a-4d7a-9e7b-ec1f9794058f', 0, N'TI-0036-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'14:35:43.0198324' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 14:35:43.020' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks], [NonTaxableAmount], [TaxableAmount]) VALUES (N'a989acfa-d3fc-44eb-a693-f648c1161311', 0, N'TI-0048-CHK-075/76', CAST(N'2019-04-26 00:00:00.000' AS DateTime), N'2076-01-13', CAST(N'15:49:47.1465705' AS Time), N'Tax', N'', N'Divisioin', N'Terminal1', N'', N'', N'', N'', N'', NULL, NULL, 1, CAST(9545.39 AS Decimal(18, 2)), CAST(20.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9525.39 AS Decimal(18, 2)), N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', CAST(N'2019-04-26 15:49:47.147' AS DateTime), N'', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Settlement] ON 

INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (26, N'775b4a1d-e998-4f5a-b865-4e448c682ab9', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0033-CHK-075/76', CAST(N'2019-04-24 14:08:04.570' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-24 14:08:04.570' AS DateTime), N'', 22, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (27, N'775b4a1d-e998-4f5a-b865-4e448c682ab9', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0034-CHK-075/76', CAST(N'2019-04-24 14:08:29.217' AS DateTime), N'Debit Card', CAST(36135.77 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-24 14:08:29.217' AS DateTime), N'', 22, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (28, N'775b4a1d-e998-4f5a-b865-4e448c682ab9', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0034-CHK-075/76', CAST(N'2019-04-24 14:08:29.217' AS DateTime), N'Cash', CAST(36135.77 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-24 14:08:29.217' AS DateTime), N'', 22, CAST(6000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (29, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0035-CHK-075/76', CAST(N'2019-04-26 14:34:37.957' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:34:37.957' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (30, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0036-CHK-075/76', CAST(N'2019-04-26 14:35:47.713' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:35:47.713' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (31, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0037-CHK-075/76', CAST(N'2019-04-26 14:37:36.950' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:37:36.950' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (32, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0038-CHK-075/76', CAST(N'2019-04-26 14:42:31.100' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:42:31.100' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (33, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0039-CHK-075/76', CAST(N'2019-04-26 14:47:50.613' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:47:50.617' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (34, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0040-CHK-075/76', CAST(N'2019-04-26 14:51:37.860' AS DateTime), N'Cash', CAST(17044.99 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:51:37.860' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (35, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0041-CHK-075/76', CAST(N'2019-04-26 14:53:39.450' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:53:39.450' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (36, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0042-CHK-075/76', CAST(N'2019-04-26 14:59:11.067' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 14:59:11.067' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (37, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0043-CHK-075/76', CAST(N'2019-04-26 15:00:30.257' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 15:00:30.257' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (38, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0044-CHK-075/76', CAST(N'2019-04-26 15:01:49.783' AS DateTime), N'Cash', CAST(25969.78 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 15:01:49.783' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (41, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0045-CHK-075/76', CAST(N'2019-04-26 15:09:26.317' AS DateTime), N'Cash', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 15:09:26.317' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (42, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0046-CHK-075/76', CAST(N'2019-04-26 15:37:00.793' AS DateTime), N'Cash', CAST(39603.79 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 15:37:00.793' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (43, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0047-CHK-075/76', CAST(N'2019-04-26 15:40:08.533' AS DateTime), N'Debit Card', CAST(94093.20 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 15:40:08.533' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
INSERT [dbo].[Settlement] ([Id], [SessionId], [TerminalId], [UserId], [TransactionNumber], [TransactionDate], [PaymentMode], [Amount], [Status], [VerifiedBy], [VerifiedDate], [Remarks], [DenominationId], [DenominationAmount]) VALUES (44, N'bba0b029-8569-4395-ad56-064eb1c582e1', 5, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'TI-0048-CHK-075/76', CAST(N'2019-04-26 15:56:10.477' AS DateTime), N'Credit Note', CAST(9525.39 AS Decimal(18, 2)), N'Closed', N'', CAST(N'2019-04-26 15:56:10.477' AS DateTime), N'', 23, CAST(10000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[Settlement] OFF
SET IDENTITY_INSERT [dbo].[STORE] ON 

INSERT [dbo].[STORE] ([ID], [INITIAL], [NAME], [COMPANY_NAME], [ADDRESS], [PHONE], [PHONE_ALT], [FAX], [VAT], [EMAIL], [WEBSITE], [FISCAL_YEAR]) VALUES (1, N'CHK', N'SALEWAYS CHAKRAPATH STORE', N'SALEWAYS', N'CHAKRAPATH', N'4720533', N'4720518', N'12345', N'4720518', N'info@saleways.com', N'www.saleways.com', N'075/76')
SET IDENTITY_INSERT [dbo].[STORE] OFF
SET IDENTITY_INSERT [dbo].[TERMINAL] ON 

INSERT [dbo].[TERMINAL] ([Id], [Initial], [Name], [Is_Active], [Remarks], [Cash_Drop_Limit]) VALUES (5, N'CHK1', N'Terminal 1', NULL, NULL, NULL)
INSERT [dbo].[TERMINAL] ([Id], [Initial], [Name], [Is_Active], [Remarks], [Cash_Drop_Limit]) VALUES (6, N'CHK2', N'Terminal 2', 1, NULL, NULL)
INSERT [dbo].[TERMINAL] ([Id], [Initial], [Name], [Is_Active], [Remarks], [Cash_Drop_Limit]) VALUES (7, N'CHK3', N'Terminal 3', 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[TERMINAL] OFF
INSERT [dbo].[User] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'2d9198e8-04c9-4a99-b372-a55a7c7f6675', N'A1', N'A1', N'A1@gmail.com', N'A1@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEEQJIFDtKqcAWzImiWdvurEFbS9fEw8GN2HyJdV15Ux5qk/5sunYQ8ETsUJe4pGIoQ==', N'YXZHR3RGUZGPTWEEH65GBUW3Y6RNAPG7', N'be63d8d4-8550-4e19-9b73-bcfaed97f7db', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[User] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Admin', N'ADMIN', N'Admin@gmail.com', N'ADMIN@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEGauUyNygHE7RyRUYg/vOewDL2kndOe3nqiSoaqUaINX5ECVg3EBjV/50iaStsw+NQ==', N'4Y7RDBU7TWBT4REZEI3L2UKDJSAJWGLZ', N'9d5a02d7-4b19-4d24-b4ce-0f94f69b8d4b', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[User] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8642a0a8-fc10-4001-bf1f-6f847b189f53', N'TestUser', N'TESTUSER', N'Testuser@gmail.com', N'TESTUSER@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEMztSPSU6Sf+B4WFiojgluhD9M1sIIQohXn+He8tyrrA0HXm1AvQwT8cHXZfvMts7g==', N'YY3JBNV3TJTNS6H66YLICITTAN5TACWB', N'35697566-986c-4586-9dd0-4c27088cfc35', NULL, 0, 0, NULL, 1, 0)
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded', 8, NULL)
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-04-26', 8, CAST(N'2019-05-26 10:11:11.720' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-04-26-04', 1, CAST(N'2019-04-27 04:26:24.293' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-04-26-09', 6, CAST(N'2019-04-27 09:55:08.843' AS DateTime))
INSERT [HangFire].[AggregatedCounter] ([Key], [Value], [ExpireAt]) VALUES (N'stats:succeeded:2019-04-26-10', 1, CAST(N'2019-04-27 10:11:11.720' AS DateTime))
SET IDENTITY_INSERT [HangFire].[Job] ON 

INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (1, 3, N'Succeeded', N'{"Type":"System.Console, System.Console, Version=4.1.1.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a","Method":"WriteLine","ParameterTypes":"[\"System.String, System.Private.CoreLib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=7cec85d7bea7798e\"]","Arguments":null}', N'["\"Fire-and-forget!\""]', CAST(N'2019-04-26 04:26:17.733' AS DateTime), CAST(N'2019-04-27 04:26:24.300' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (2, 6, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"0afe9926-3789-4354-b7a9-c3e28e59ad0a\",\"Invoice_Id\":42,\"Invoice_Number\":\"TI-0042-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"14:59:05.4820088\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"\",\"Customer_Name\":\"\",\"Customer_Vat\":\"\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":1,\"Total_Gross_Amount\":9545.39,\"Total_Discount\":20.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":9525.39,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T14:59:05.483\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":39,\"Invoice_Id\":\"0afe9926-3789-4354-b7a9-c3e28e59ad0a\",\"Invoice_Number\":\"TI-0042-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":1.0,\"Gross_Amount\":8447.25,\"Discount\":20.00,\"Is_Discountable\":false,\"Tax\":1098.14,\"Net_Amount\":9525.39,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 09:14:15.850' AS DateTime), CAST(N'2019-04-27 09:14:32.940' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (3, 9, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"f981fbbc-05c9-477d-97e1-b3504dbd7f77\",\"Invoice_Id\":43,\"Invoice_Number\":\"TI-0043-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"15:00:25.2634163\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"\",\"Customer_Name\":\"\",\"Customer_Vat\":\"\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":1,\"Total_Gross_Amount\":9545.39,\"Total_Discount\":20.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":9525.39,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T15:00:25.263\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":40,\"Invoice_Id\":\"f981fbbc-05c9-477d-97e1-b3504dbd7f77\",\"Invoice_Number\":\"TI-0043-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":1.0,\"Gross_Amount\":8447.25,\"Discount\":20.00,\"Is_Discountable\":false,\"Tax\":1098.14,\"Net_Amount\":9525.39,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 09:15:34.360' AS DateTime), CAST(N'2019-04-27 09:15:34.783' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (4, 12, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"425167c2-c0e2-4397-88fc-d9ff5c4dfd30\",\"Invoice_Id\":44,\"Invoice_Number\":\"TI-0044-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"15:01:45.4714085\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"\",\"Customer_Name\":\"\",\"Customer_Vat\":\"\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":3,\"Total_Gross_Amount\":25989.78,\"Total_Discount\":20.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":25969.78,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T15:01:45.47\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":41,\"Invoice_Id\":\"425167c2-c0e2-4397-88fc-d9ff5c4dfd30\",\"Invoice_Number\":\"TI-0044-CHK-075/76\",\"Bar_Code\":\"012\",\"Name\":\"Sauce - Salsa\",\"Unit\":\"KG\",\"Rate\":7898.04,\"Quantity\":1.0,\"Gross_Amount\":7898.04,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":1026.75,\"Net_Amount\":8924.79,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":42,\"Invoice_Id\":\"425167c2-c0e2-4397-88fc-d9ff5c4dfd30\",\"Invoice_Number\":\"TI-0044-CHK-075/76\",\"Bar_Code\":\"011\",\"Name\":\"Mushroom - Porcini, Dry\",\"Unit\":\"PC\",\"Rate\":7519.60,\"Quantity\":1.0,\"Gross_Amount\":7519.60,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":0.00,\"Net_Amount\":7519.60,\"Is_Vatable\":false,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":43,\"Invoice_Id\":\"425167c2-c0e2-4397-88fc-d9ff5c4dfd30\",\"Invoice_Number\":\"TI-0044-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":1.0,\"Gross_Amount\":8447.25,\"Discount\":20.00,\"Is_Discountable\":false,\"Tax\":1098.14,\"Net_Amount\":9525.39,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 09:16:49.913' AS DateTime), CAST(N'2019-04-27 09:16:50.083' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (5, 15, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"0672b2a8-7583-44fb-84a4-afdf826ddf1c\",\"Invoice_Id\":45,\"Invoice_Number\":\"TI-0045-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"15:09:21.1077632\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"1\",\"Customer_Name\":\"Ilysa Shellibeer\",\"Customer_Vat\":\"59779-860\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"93593 Hagan Junction\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":1,\"Total_Gross_Amount\":9545.39,\"Total_Discount\":20.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":9525.39,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T15:09:21.107\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":44,\"Invoice_Id\":\"0672b2a8-7583-44fb-84a4-afdf826ddf1c\",\"Invoice_Number\":\"TI-0045-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":1.0,\"Gross_Amount\":8447.25,\"Discount\":20.00,\"Is_Discountable\":false,\"Tax\":1098.14,\"Net_Amount\":9525.39,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 09:24:26.483' AS DateTime), CAST(N'2019-04-27 09:24:27.537' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (6, 18, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"ccc5d318-aee3-4ae2-837c-340c3c22dec5\",\"Invoice_Id\":46,\"Invoice_Number\":\"TI-0046-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"15:36:31.8241006\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"\",\"Customer_Name\":\"\",\"Customer_Vat\":\"\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":5,\"Total_Gross_Amount\":39623.79,\"Total_Discount\":20.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":39603.79,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T15:36:31.823\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":45,\"Invoice_Id\":\"ccc5d318-aee3-4ae2-837c-340c3c22dec5\",\"Invoice_Number\":\"TI-0046-CHK-075/76\",\"Bar_Code\":\"011\",\"Name\":\"Mushroom - Porcini, Dry\",\"Unit\":\"PC\",\"Rate\":7519.60,\"Quantity\":4.0,\"Gross_Amount\":30078.40,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":0.00,\"Net_Amount\":30078.40,\"Is_Vatable\":false,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":46,\"Invoice_Id\":\"ccc5d318-aee3-4ae2-837c-340c3c22dec5\",\"Invoice_Number\":\"TI-0046-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":1.0,\"Gross_Amount\":8447.25,\"Discount\":20.00,\"Is_Discountable\":false,\"Tax\":1098.14,\"Net_Amount\":9525.39,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 09:52:01.060' AS DateTime), CAST(N'2019-04-27 09:52:01.683' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (7, 21, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Id\":47,\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"15:39:47.2767665\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"1\",\"Customer_Name\":\"Ilysa Shellibeer\",\"Customer_Vat\":\"59779-860\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"93593 Hagan Junction\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":15,\"Total_Gross_Amount\":94113.20,\"Total_Discount\":100.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":94093.20,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T15:39:47.277\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":47,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":5.0,\"Gross_Amount\":42236.24,\"Discount\":100.00,\"Is_Discountable\":false,\"Tax\":5490.71,\"Net_Amount\":47706.95,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":48,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"019\",\"Name\":\"Nut - Walnut, Pieces\",\"Unit\":\"KG\",\"Rate\":152.97,\"Quantity\":1.0,\"Gross_Amount\":152.97,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":19.89,\"Net_Amount\":172.86,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":49,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"020\",\"Name\":\"Radish - Black, Winter, Organic\",\"Unit\":\"Litre\",\"Rate\":5304.81,\"Quantity\":1.0,\"Gross_Amount\":5304.81,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":689.63,\"Net_Amount\":5994.44,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":50,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"018\",\"Name\":\"Chef Hat 25cm\",\"Unit\":\"Litre\",\"Rate\":8820.00,\"Quantity\":1.0,\"Gross_Amount\":8820.00,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":0.00,\"Net_Amount\":8820.00,\"Is_Vatable\":false,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":51,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"017\",\"Name\":\"Tart - Butter Plain Squares\",\"Unit\":\"PC\",\"Rate\":1109.75,\"Quantity\":1.0,\"Gross_Amount\":1109.75,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":144.27,\"Net_Amount\":1254.02,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":52,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"016\",\"Name\":\"Bread - Raisin\",\"Unit\":\"KG\",\"Rate\":3151.73,\"Quantity\":1.0,\"Gross_Amount\":3151.73,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":409.72,\"Net_Amount\":3561.45,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":53,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"015\",\"Name\":\"Lamb Tenderloin Nz Fr\",\"Unit\":\"Litre\",\"Rate\":4708.37,\"Quantity\":1.0,\"Gross_Amount\":4708.37,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":612.09,\"Net_Amount\":5320.46,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":54,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"014\",\"Name\":\"Dc - Sakura Fu\",\"Unit\":\"KG\",\"Rate\":3688.34,\"Quantity\":1.0,\"Gross_Amount\":3688.34,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":479.48,\"Net_Amount\":4167.82,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":55,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"013\",\"Name\":\"Wine - Two Oceans Cabernet\",\"Unit\":\"PC\",\"Rate\":575.94,\"Quantity\":1.0,\"Gross_Amount\":575.94,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":74.87,\"Net_Amount\":650.81,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":56,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"012\",\"Name\":\"Sauce - Salsa\",\"Unit\":\"KG\",\"Rate\":7898.04,\"Quantity\":1.0,\"Gross_Amount\":7898.04,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":1026.75,\"Net_Amount\":8924.79,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}},{\"Id\":57,\"Invoice_Id\":\"35bb62ba-cc7f-4812-8195-1dc00f471686\",\"Invoice_Number\":\"TI-0047-CHK-075/76\",\"Bar_Code\":\"011\",\"Name\":\"Mushroom - Porcini, Dry\",\"Unit\":\"PC\",\"Rate\":7519.60,\"Quantity\":1.0,\"Gross_Amount\":7519.60,\"Discount\":0.00,\"Is_Discountable\":true,\"Tax\":0.00,\"Net_Amount\":7519.60,\"Is_Vatable\":false,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 09:55:08.677' AS DateTime), CAST(N'2019-04-27 09:55:08.843' AS DateTime))
INSERT [HangFire].[Job] ([Id], [StateId], [StateName], [InvocationData], [Arguments], [CreatedAt], [ExpireAt]) VALUES (8, 24, N'Succeeded', N'{"Type":"POS.UI.Controllers.SalesInvoiceController, POS.UI, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null","Method":"SendDataToIRD","ParameterTypes":"[\"POS.DTO.SalesInvoice, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\",\"POS.DTO.Store, POS.DTO, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null\"]","Arguments":null}', N'["{\"$id\":\"1\",\"Id\":\"32fbb9f0-d48d-4149-982a-e1dd9f7c1809\",\"Invoice_Id\":48,\"Invoice_Number\":\"TI-0048-CHK-075/76\",\"Trans_Date_Ad\":\"2019-04-26T00:00:00\",\"Trans_Date_Bs\":\"2076-01-13\",\"Trans_Time\":\"15:50:52.6235857\",\"Trans_Type\":\"Tax\",\"Chalan_Number\":\"\",\"Division\":\"Divisioin\",\"Terminal\":\"Terminal1\",\"Customer_Id\":\"\",\"Customer_Name\":\"\",\"Customer_Vat\":\"\",\"Customer_Mobile\":\"\",\"Customer_Address\":\"\",\"Flat_Discount_Amount\":null,\"Flat_Discount_Percent\":null,\"Total_Quantity\":1,\"Total_Gross_Amount\":9545.39,\"Total_Discount\":20.00,\"Total_Vat\":0.00,\"TaxableAmount\":0.00,\"NonTaxableAmount\":0.00,\"Total_Net_Amount\":9525.39,\"Created_By\":\"4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f\",\"Created_Date\":\"2019-04-26T15:50:52.623\",\"Remarks\":\"\",\"SalesInvoiceItems\":[{\"Id\":58,\"Invoice_Id\":\"32fbb9f0-d48d-4149-982a-e1dd9f7c1809\",\"Invoice_Number\":\"TI-0048-CHK-075/76\",\"Bar_Code\":\"010\",\"Name\":\"Wiberg Cure\",\"Unit\":\"Litre\",\"Rate\":8447.25,\"Quantity\":1.0,\"Gross_Amount\":8447.25,\"Discount\":20.00,\"Is_Discountable\":false,\"Tax\":1098.14,\"Net_Amount\":9525.39,\"Is_Vatable\":true,\"Remarks\":null,\"Invoice\":{\"$ref\":\"1\"}}]}","{\"ID\":1,\"INITIAL\":\"CHK\",\"NAME\":\"SALEWAYS CHAKRAPATH STORE\",\"COMPANY_NAME\":\"SALEWAYS\",\"ADDRESS\":\"CHAKRAPATH\",\"PHONE\":\"4720533\",\"PHONE_ALT\":\"4720518\",\"FAX\":\"12345\",\"VAT\":\"4720518\",\"EMAIL\":\"info@saleways.com\",\"WEBSITE\":\"www.saleways.com\",\"FISCAL_YEAR\":\"075/76\"}"]', CAST(N'2019-04-26 10:11:10.697' AS DateTime), CAST(N'2019-04-27 10:11:11.727' AS DateTime))
SET IDENTITY_INSERT [HangFire].[Job] OFF
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (1, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (2, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (3, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (4, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (5, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (6, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (7, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'CurrentCulture', N'"en-US"')
INSERT [HangFire].[JobParameter] ([JobId], [Name], [Value]) VALUES (8, N'CurrentUICulture', N'"en-US"')
INSERT [HangFire].[Schema] ([Version]) VALUES (7)
INSERT [HangFire].[Server] ([Id], [Data], [LastHeartbeat]) VALUES (N'desktop-p9qn332:17700:508640ca-f370-42ec-a4a1-c22331b06f64', N'{"WorkerCount":20,"Queues":["default"],"StartedAt":"2019-04-26T11:15:15.3475116Z"}', CAST(N'2019-04-26 11:39:16.727' AS DateTime))
SET IDENTITY_INSERT [HangFire].[State] ON 

INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (1, 1, N'Enqueued', NULL, CAST(N'2019-04-26 04:26:17.817' AS DateTime), N'{"EnqueuedAt":"2019-04-26T04:26:17.7070247Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (2, 1, N'Processing', NULL, CAST(N'2019-04-26 04:26:24.173' AS DateTime), N'{"StartedAt":"2019-04-26T04:26:23.7430854Z","ServerId":"desktop-p9qn332:17988:ada41bef-25bd-4053-825f-b2f06de3e459","WorkerId":"7949246c-1f65-4375-bc06-501d867dec70"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (3, 1, N'Succeeded', NULL, CAST(N'2019-04-26 04:26:24.297' AS DateTime), N'{"SucceededAt":"2019-04-26T04:26:24.2692302Z","PerformanceDuration":"22","Latency":"6513"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (4, 2, N'Enqueued', NULL, CAST(N'2019-04-26 09:14:16.150' AS DateTime), N'{"EnqueuedAt":"2019-04-26T09:14:15.8016532Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (5, 2, N'Processing', NULL, CAST(N'2019-04-26 09:14:21.787' AS DateTime), N'{"StartedAt":"2019-04-26T09:14:21.4228682Z","ServerId":"desktop-p9qn332:13360:701dbb14-095f-461d-b45d-3e56656ffc8a","WorkerId":"06e4d3c1-cee3-4f1e-ad3f-0566141d3a2b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (6, 2, N'Succeeded', NULL, CAST(N'2019-04-26 09:14:32.937' AS DateTime), N'{"SucceededAt":"2019-04-26T09:14:32.9268112Z","PerformanceDuration":"11065","Latency":"6011"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (7, 3, N'Enqueued', NULL, CAST(N'2019-04-26 09:15:34.390' AS DateTime), N'{"EnqueuedAt":"2019-04-26T09:15:34.3333905Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (8, 3, N'Processing', NULL, CAST(N'2019-04-26 09:15:34.420' AS DateTime), N'{"StartedAt":"2019-04-26T09:15:34.4084483Z","ServerId":"desktop-p9qn332:13360:701dbb14-095f-461d-b45d-3e56656ffc8a","WorkerId":"06e4d3c1-cee3-4f1e-ad3f-0566141d3a2b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (9, 3, N'Succeeded', NULL, CAST(N'2019-04-26 09:15:34.780' AS DateTime), N'{"SucceededAt":"2019-04-26T09:15:34.6289346Z","PerformanceDuration":"140","Latency":"128"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (10, 4, N'Enqueued', NULL, CAST(N'2019-04-26 09:16:49.917' AS DateTime), N'{"EnqueuedAt":"2019-04-26T09:16:49.9124449Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (11, 4, N'Processing', NULL, CAST(N'2019-04-26 09:16:49.947' AS DateTime), N'{"StartedAt":"2019-04-26T09:16:49.9320214Z","ServerId":"desktop-p9qn332:13360:701dbb14-095f-461d-b45d-3e56656ffc8a","WorkerId":"06e4d3c1-cee3-4f1e-ad3f-0566141d3a2b"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (12, 4, N'Succeeded', NULL, CAST(N'2019-04-26 09:16:50.083' AS DateTime), N'{"SucceededAt":"2019-04-26T09:16:50.0760676Z","PerformanceDuration":"98","Latency":"64"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (13, 5, N'Enqueued', NULL, CAST(N'2019-04-26 09:24:26.557' AS DateTime), N'{"EnqueuedAt":"2019-04-26T09:24:26.4185009Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (14, 5, N'Processing', NULL, CAST(N'2019-04-26 09:24:26.850' AS DateTime), N'{"StartedAt":"2019-04-26T09:24:26.6557047Z","ServerId":"desktop-p9qn332:21796:61408b70-d238-4f54-87f3-39d614d1a8bf","WorkerId":"111b1563-1f01-4895-b259-e3b319a9f931"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (15, 5, N'Succeeded', NULL, CAST(N'2019-04-26 09:24:27.533' AS DateTime), N'{"SucceededAt":"2019-04-26T09:24:27.5247107Z","PerformanceDuration":"592","Latency":"449"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (16, 6, N'Enqueued', NULL, CAST(N'2019-04-26 09:52:01.133' AS DateTime), N'{"EnqueuedAt":"2019-04-26T09:52:00.9925040Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (17, 6, N'Processing', NULL, CAST(N'2019-04-26 09:52:01.247' AS DateTime), N'{"StartedAt":"2019-04-26T09:52:01.1831643Z","ServerId":"desktop-p9qn332:23656:5b0c2eef-3617-40b6-ac4e-0da74499d043","WorkerId":"0c59c38d-41a9-4bf9-9424-b1c1826d717d"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (18, 6, N'Succeeded', NULL, CAST(N'2019-04-26 09:52:01.680' AS DateTime), N'{"SucceededAt":"2019-04-26T09:52:01.6695149Z","PerformanceDuration":"408","Latency":"201"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (19, 7, N'Enqueued', NULL, CAST(N'2019-04-26 09:55:08.717' AS DateTime), N'{"EnqueuedAt":"2019-04-26T09:55:08.6741833Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (20, 7, N'Processing', NULL, CAST(N'2019-04-26 09:55:08.750' AS DateTime), N'{"StartedAt":"2019-04-26T09:55:08.7420946Z","ServerId":"desktop-p9qn332:23656:5b0c2eef-3617-40b6-ac4e-0da74499d043","WorkerId":"ec8af2ca-ce32-462e-ac50-c7f604a60550"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (21, 7, N'Succeeded', NULL, CAST(N'2019-04-26 09:55:08.843' AS DateTime), N'{"SucceededAt":"2019-04-26T09:55:08.8418967Z","PerformanceDuration":"88","Latency":"76"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (22, 8, N'Enqueued', NULL, CAST(N'2019-04-26 10:11:10.770' AS DateTime), N'{"EnqueuedAt":"2019-04-26T10:11:10.5928377Z","Queue":"default"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (23, 8, N'Processing', NULL, CAST(N'2019-04-26 10:11:10.843' AS DateTime), N'{"StartedAt":"2019-04-26T10:11:10.8204778Z","ServerId":"desktop-p9qn332:22012:7abfbef4-b034-4200-84ee-aff14c449198","WorkerId":"1afa4641-d512-4e7b-86e6-462ee5358dca"}')
INSERT [HangFire].[State] ([Id], [JobId], [Name], [Reason], [CreatedAt], [Data]) VALUES (24, 8, N'Succeeded', NULL, CAST(N'2019-04-26 10:11:11.727' AS DateTime), N'{"SucceededAt":"2019-04-26T10:11:11.7165741Z","PerformanceDuration":"802","Latency":"216"}')
SET IDENTITY_INSERT [HangFire].[State] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UniqueInvoiceNumber]    Script Date: 04/26/19 5:24:23 PM ******/
ALTER TABLE [dbo].[SALES_INVOICE] ADD  CONSTRAINT [UniqueInvoiceNumber] UNIQUE NONCLUSTERED 
(
	[Invoice_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO
ALTER TABLE [dbo].[CREDIT_NOTE_ITEMS]  WITH CHECK ADD  CONSTRAINT [FK_CREDIT_NOTE_ITEMS_CREDIT_NOTE_Credit_Note_Id] FOREIGN KEY([Credit_Note_Id])
REFERENCES [dbo].[CREDIT_NOTE] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CREDIT_NOTE_ITEMS] CHECK CONSTRAINT [FK_CREDIT_NOTE_ITEMS_CREDIT_NOTE_Credit_Note_Id]
GO
ALTER TABLE [dbo].[DENOMINATION]  WITH CHECK ADD  CONSTRAINT [FK_DENOMINATION_TERMINAL_Terminal_Id] FOREIGN KEY([Terminal_Id])
REFERENCES [dbo].[TERMINAL] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DENOMINATION] CHECK CONSTRAINT [FK_DENOMINATION_TERMINAL_Terminal_Id]
GO
ALTER TABLE [dbo].[SALES_INVOICE_ITEMS]  WITH CHECK ADD  CONSTRAINT [FK_SALES_INVOICE_ITEMS_SALES_INVOICE_Invoice_Id] FOREIGN KEY([Invoice_Id])
REFERENCES [dbo].[SALES_INVOICE] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SALES_INVOICE_ITEMS] CHECK CONSTRAINT [FK_SALES_INVOICE_ITEMS_SALES_INVOICE_Invoice_Id]
GO
ALTER TABLE [dbo].[SALES_INVOICE_ITEMS_TMP]  WITH CHECK ADD  CONSTRAINT [FK_SALES_INVOICE_ITEMS_TMP_SALES_INVOICE_TMP_Invoice_Id] FOREIGN KEY([Invoice_Id])
REFERENCES [dbo].[SALES_INVOICE_TMP] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SALES_INVOICE_ITEMS_TMP] CHECK CONSTRAINT [FK_SALES_INVOICE_ITEMS_TMP_SALES_INVOICE_TMP_Invoice_Id]
GO
ALTER TABLE [HangFire].[JobParameter]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_JobParameter_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[JobParameter] CHECK CONSTRAINT [FK_HangFire_JobParameter_Job]
GO
ALTER TABLE [HangFire].[State]  WITH CHECK ADD  CONSTRAINT [FK_HangFire_State_Job] FOREIGN KEY([JobId])
REFERENCES [HangFire].[Job] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [HangFire].[State] CHECK CONSTRAINT [FK_HangFire_State_Job]
GO
