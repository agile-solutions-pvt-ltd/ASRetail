USE [master]
GO
/****** Object:  Database [POS]    Script Date: 04/15/19 5:08:03 PM ******/
CREATE DATABASE [POS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'POS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\POS.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'POS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\POS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [POS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [POS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [POS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [POS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [POS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [POS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [POS] SET ARITHABORT OFF 
GO
ALTER DATABASE [POS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [POS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [POS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [POS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [POS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [POS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [POS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [POS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [POS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [POS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [POS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [POS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [POS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [POS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [POS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [POS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [POS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [POS] SET RECOVERY FULL 
GO
ALTER DATABASE [POS] SET  MULTI_USER 
GO
ALTER DATABASE [POS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [POS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [POS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [POS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [POS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'POS', N'ON'
GO
USE [POS]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoleClaims]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[AspNetUserTokens]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[CREDIT_NOTE]    Script Date: 04/15/19 5:08:04 PM ******/
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
	[Customer_Id] [int] NULL,
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
 CONSTRAINT [PK_CREDIT_NOTE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CREDIT_NOTE_ITEMS]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 04/15/19 5:08:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
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
	[Member_Id] [nvarchar](50) NULL,
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
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DENOMINATION]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[ITEM]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[ITEM_CATEGORY]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[ITEM_GROUP]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[ITEM_TYPE]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[MENU]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[ROLEWISE_MENU_PERMISSION]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[ROLEWISE_PERMISSION]    Script Date: 04/15/19 5:08:04 PM ******/
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
 CONSTRAINT [PK_ROLEWISE_PERMISSION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_INVOICE]    Script Date: 04/15/19 5:08:04 PM ******/
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
	[Customer_Id] [int] NULL,
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
 CONSTRAINT [PK_SALES_INVOICE] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SALES_INVOICE_BILL]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[SALES_INVOICE_ITEMS]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[SALES_INVOICE_ITEMS_TMP]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[SALES_INVOICE_TMP]    Script Date: 04/15/19 5:08:04 PM ******/
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
	[Customer_Id] [int] NULL,
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
 CONSTRAINT [PK_SALES_INVOICE_TMP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STORE]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  Table [dbo].[TERMINAL]    Script Date: 04/15/19 5:08:04 PM ******/
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
/****** Object:  View [dbo].[User_View_Model]    Script Date: 04/15/19 5:08:04 PM ******/
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
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'8fa9c224-3621-403a-a487-31e434f5bafd', N'Administrator', N'ADMINISTRATOR', N'5474351b-782b-43ac-bb43-f6423087e47c')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'ac490c4d-4068-4c52-ae59-d72f470986a5', N'Report Agent', N'REPORT AGENT', N'ebfa7481-2f66-4558-89ae-9d05c0a31c00')
INSERT [dbo].[AspNetRoles] ([Id], [Name], [NormalizedName], [ConcurrencyStamp]) VALUES (N'bbbf71a3-0a6f-48fd-8120-c1eb1afa0f70', N'Sales Manager', N'SALES MANAGER', N'1ba4f8d4-1006-454f-8fbb-94fcdacf729d')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'2d9198e8-04c9-4a99-b372-a55a7c7f6675', N'ac490c4d-4068-4c52-ae59-d72f470986a5')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'8fa9c224-3621-403a-a487-31e434f5bafd')
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'8642a0a8-fc10-4001-bf1f-6f847b189f53', N'bbbf71a3-0a6f-48fd-8120-c1eb1afa0f70')
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'2d9198e8-04c9-4a99-b372-a55a7c7f6675', N'A1', N'A1', N'A1@gmail.com', N'A1@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEEQJIFDtKqcAWzImiWdvurEFbS9fEw8GN2HyJdV15Ux5qk/5sunYQ8ETsUJe4pGIoQ==', N'YXZHR3RGUZGPTWEEH65GBUW3Y6RNAPG7', N'be63d8d4-8550-4e19-9b73-bcfaed97f7db', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', N'Admin', N'ADMIN', N'Admin@gmail.com', N'ADMIN@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEGauUyNygHE7RyRUYg/vOewDL2kndOe3nqiSoaqUaINX5ECVg3EBjV/50iaStsw+NQ==', N'4Y7RDBU7TWBT4REZEI3L2UKDJSAJWGLZ', N'f64f05b3-120c-4f90-904c-248148bd2cd8', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[AspNetUsers] ([Id], [UserName], [NormalizedUserName], [Email], [NormalizedEmail], [EmailConfirmed], [PasswordHash], [SecurityStamp], [ConcurrencyStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEnd], [LockoutEnabled], [AccessFailedCount]) VALUES (N'8642a0a8-fc10-4001-bf1f-6f847b189f53', N'TestUser', N'TESTUSER', N'Testuser@gmail.com', N'TESTUSER@GMAIL.COM', 0, N'AQAAAAEAACcQAAAAEMztSPSU6Sf+B4WFiojgluhD9M1sIIQohXn+He8tyrrA0HXm1AvQwT8cHXZfvMts7g==', N'YY3JBNV3TJTNS6H66YLICITTAN5TACWB', N'35697566-986c-4586-9dd0-4c27088cfc35', NULL, 0, 0, NULL, 1, 0)
INSERT [dbo].[CREDIT_NOTE] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Reference_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Credit_Note], [Remarks]) VALUES (N'7eaad0c2-5a18-4cca-9c90-3ea494ddc9a2', 1, N'CN-0001-075/75', N'TI-0002-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:18:01.7403918' AS Time), N'Sales', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 4, CAST(21761.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(24590.85 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:18:01.740' AS DateTime), N'Defective piece', N'')
SET IDENTITY_INSERT [dbo].[CREDIT_NOTE_ITEMS] ON 

INSERT [dbo].[CREDIT_NOTE_ITEMS] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1, N'7eaad0c2-5a18-4cca-9c90-3ea494ddc9a2', N'CN-0001-075/75', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(2508.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(326.05 AS Decimal(18, 2)), CAST(2834.09 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[CREDIT_NOTE_ITEMS] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (2, N'7eaad0c2-5a18-4cca-9c90-3ea494ddc9a2', N'CN-0001-075/75', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(9278.80 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9278.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1206.24 AS Decimal(18, 2)), CAST(10485.04 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[CREDIT_NOTE_ITEMS] ([Id], [Credit_Note_Id], [Credit_Note_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (3, N'7eaad0c2-5a18-4cca-9c90-3ea494ddc9a2', N'CN-0001-075/75', N'023', N'Wine - Prem Select Charddonany', N'PC', CAST(9974.97 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9974.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1296.75 AS Decimal(18, 2)), CAST(11271.72 AS Decimal(18, 2)), 0, NULL)
SET IDENTITY_INSERT [dbo].[CREDIT_NOTE_ITEMS] OFF
SET IDENTITY_INSERT [dbo].[CUSTOMER] ON 

INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (4, N'1', N'Ilysa Shellibeer', N'93593 Hagan Junction', NULL, N'169-173-7808', NULL, N'237-817-0990', NULL, N'ishellibeer0@bloglines.com', N'59779-860', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (5, N'2', N'Windham Beiderbeck', N'2370 Park Meadow Court', NULL, N'170-170-4789', NULL, N'783-794-3813', NULL, N'wbeiderbeck1@europa.eu', N'0378-2180', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (6, N'3', N'Jacynth Pickavance', N'6 Scofield Avenue', NULL, N'231-635-3343', NULL, N'733-611-6671', NULL, N'jpickavance2@github.io', N'0186-0324', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (7, N'4', N'Lorinda Infante', N'17958 Bayside Place', NULL, N'134-273-2022', NULL, N'418-868-4621', NULL, N'linfante3@reuters.com', N'64720-125', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (8, N'5', N'Moyna Alenov', N'8097 Crescent Oaks Street', NULL, N'881-224-0421', NULL, N'663-282-4678', NULL, N'malenov4@jiathis.com', N'68788-0999', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (9, N'6', N'Jobie Shankland', N'97853 Ridge Oak Center', NULL, N'433-697-0679', NULL, N'892-612-2338', NULL, N'jshankland5@google.com.br', N'62670-4826', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (10, N'7', N'Sapphire Stansby', N'544 Vidon Court', NULL, N'266-559-5045', NULL, N'816-414-5762', NULL, N'sstansby6@typepad.com', N'21695-777', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (11, N'8', N'Goldia Tourne', N'66 Stephen Junction', NULL, N'405-263-8106', NULL, N'682-930-0430', NULL, N'gtourne7@rediff.com', N'37000-153', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (12, N'9', N'Brewster Beckey', N'7325 4th Drive', NULL, N'810-771-6678', NULL, N'542-141-5104', NULL, N'bbeckey8@phoca.cz', N'68151-0185', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (13, N'10', N'Alvina Lassen', N'2431 Dakota Plaza', NULL, N'153-839-4807', NULL, N'356-101-5293', NULL, N'alassen9@eepurl.com', N'43063-094', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (14, N'11', N'Pattin Morch', N'22148 Burrows Point', NULL, N'526-997-5445', NULL, N'392-964-7743', NULL, N'pmorcha@oakley.com', N'59667-0058', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (15, N'12', N'Babbette Garth', N'9 Ohio Plaza', NULL, N'397-868-6666', NULL, N'700-318-2067', NULL, N'bgarthb@webmd.com', N'54569-5840', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (16, N'13', N'Seymour Alp', N'67 Carpenter Center', NULL, N'729-218-5336', NULL, N'728-684-8357', NULL, N'salpc@sogou.com', N'24236-943', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (17, N'14', N'Enrique Rissom', N'97 Eggendart Alley', NULL, N'447-715-6032', NULL, N'294-608-0364', NULL, N'erissomd@indiegogo.com', N'50268-691', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (18, N'15', N'Dion Sponder', N'2625 Bluejay Alley', NULL, N'783-329-3576', NULL, N'719-830-8161', NULL, N'dspondere@eepurl.com', N'65841-675', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (19, N'16', N'Jo ann Colombier', N'64 Village Green Junction', NULL, N'301-447-8078', NULL, N'118-957-8073', NULL, N'jannf@1und1.de', N'49762-450', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (20, N'17', N'Brit Venmore', N'0593 Dayton Pass', NULL, N'285-441-2729', NULL, N'115-327-3874', NULL, N'bvenmoreg@smugmug.com', N'39765-002', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (21, N'18', N'Henrie Booy', N'459 Moland Parkway', NULL, N'641-710-2363', NULL, N'478-195-4300', NULL, N'hbooyh@ed.gov', N'0113-0476', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (22, N'19', N'Darin McLaughlan', N'96528 Village Pass', NULL, N'647-429-2087', NULL, N'611-337-5397', NULL, N'dmclaughlani@tumblr.com', N'25225-014', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (23, N'20', N'Stanford Pescud', N'0881 Marcy Road', NULL, N'109-726-2023', NULL, N'141-626-2898', NULL, N'spescudj@qq.com', N'62011-0001', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (24, N'21', N'Bob Gummory', N'31912 Memorial Center', NULL, N'380-601-1387', NULL, N'172-832-5679', NULL, N'bgummoryk@gizmodo.com', N'42023-159', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (25, N'22', N'Kitti Chappell', N'9 Kinsman Parkway', NULL, N'859-884-7286', NULL, N'122-734-3812', NULL, N'kchappelll@zdnet.com', N'0703-4244', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (26, N'23', N'Christal Covert', N'540 Northridge Road', NULL, N'616-766-6349', NULL, N'950-440-3039', NULL, N'ccovertm@canalblog.com', N'50523-100', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (27, N'24', N'Clarinda Paoli', N'182 Crescent Oaks Avenue', NULL, N'748-323-9151', NULL, N'718-914-5742', NULL, N'cpaolin@netlog.com', N'54868-6366', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (28, N'25', N'Reinhold Endrizzi', N'66 Farwell Lane', NULL, N'338-746-1299', NULL, N'747-200-7089', NULL, N'rendrizzio@vimeo.com', N'51862-155', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (29, N'26', N'Aimee Frederick', N'1563 Cascade Court', NULL, N'509-904-0972', NULL, N'359-341-6796', NULL, N'afrederickp@163.com', N'59467-318', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (30, N'27', N'Sallyanne Van der Velde', N'013 Goodland Junction', NULL, N'200-140-2726', NULL, N'202-451-7155', NULL, N'svanq@blog.com', N'63354-162', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (31, N'28', N'Corella Eisold', N'82 Stoughton Lane', NULL, N'583-427-1291', NULL, N'698-901-8378', NULL, N'ceisoldr@webnode.com', N'0440-1595', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (32, N'29', N'Mona Vallender', N'7897 Golf View Way', NULL, N'435-876-3924', NULL, N'809-464-1608', NULL, N'mvallenders@house.gov', N'51514-0324', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[CUSTOMER] ([Id], [Code], [Name], [Address], [Image], [Tel1], [Tel2], [Mobile1], [Mobile2], [Email], [Vat], [Fax], [PO_Box], [Type], [Credit_Limit], [Credit_day], [Is_Sale_Refused], [Is_Member], [Member_Id], [Barcode], [DOB], [DOB_BS], [Wedding_Date], [Family_Member_Int], [Occupation], [Office_Name], [Office_Address], [Designation], [Registration_Date], [Validity_Period], [Validity_Date], [Membership_Scheme], [Reference_By], [Created_By], [Created_Date], [Remarks]) VALUES (33, N'30', N'Frankie Faustian', N'1 La Follette Road', NULL, N'852-322-7016', NULL, N'626-268-5766', NULL, N'ffaustiant@accuweather.com', N'44567-506', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[CUSTOMER] OFF
SET IDENTITY_INSERT [dbo].[DENOMINATION] ON 

INSERT [dbo].[DENOMINATION] ([Id], [User_Id], [Terminal_Id], [Date], [Date_BS], [Debit_Card], [Cheque], [R1000], [R500], [R250], [R100], [R50], [R25], [R20], [R10], [R5], [R2], [R1], [R05], [RIC], [Other], [Total], [Remarks]) VALUES (8, N'4fc785e7-d4ff-4a25-83a8-bb7aadcc1f2f', 5, CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', NULL, NULL, CAST(6 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(6000.00 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[DENOMINATION] OFF
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
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (2, NULL, 2, N'Transactions', NULL, NULL, N'', N'dropdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (3, NULL, 3, N'Setup', NULL, NULL, N'', N'dropdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (4, NULL, 4, N'Settings', N'Settings', N'Index', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (5, NULL, 5, N'Help', NULL, NULL, N'', N'dropdown')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (6, NULL, 6, N'Contact', N'Store', N'Index', N'', N'link')
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
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (18, 3, 8, N'Rolewise Permission Setup', N'Account', N'RoleWisePermission', N'', N'link')
INSERT [dbo].[MENU] ([Id], [ParentId], [SN], [Name], [Controller], [Action], [Route], [Type]) VALUES (19, 5, 1, N'Shortcuts', N'Settings', N'Shortcut', N'', N'link')
SET IDENTITY_INSERT [dbo].[MENU] OFF
SET IDENTITY_INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ON 

INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (63, N'8fa9c224-3621-403a-a487-31e434f5bafd', 2)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (64, N'8fa9c224-3621-403a-a487-31e434f5bafd', 8)
INSERT [dbo].[ROLEWISE_MENU_PERMISSION] ([Id], [RoleId], [MenuId]) VALUES (65, N'8fa9c224-3621-403a-a487-31e434f5bafd', 10)
SET IDENTITY_INSERT [dbo].[ROLEWISE_MENU_PERMISSION] OFF
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'93ab91b7-e927-4670-8951-12bd8b8d6298', 1, N'SI-0001-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:07:15.2183723' AS Time), N'Sales', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 15, CAST(129948.90 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(129948.90 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:07:15.217' AS DateTime), N'Sales')
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'4c9908c1-4491-4390-842d-193b0a3b1b8f', 1, N'TI-0001-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:06:12.2181829' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', 10, N'Sapphire Stansby', N'21695-777', N'', N'544 Vidon Court', CAST(100.00 AS Decimal(18, 2)), NULL, 37, CAST(201892.35 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), NULL, CAST(221656.07 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:06:12.217' AS DateTime), N'Tax')
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'eb2d9b53-83ea-4161-8b70-438de0ed309b', 3, N'TI-0003-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'11:05:04.4418565' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 5, CAST(47726.95 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), NULL, CAST(53818.45 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 11:05:04.443' AS DateTime), N'')
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', 4, N'TI-0004-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'14:58:16.9730884' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 42, CAST(388200.88 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(438666.99 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 14:58:16.973' AS DateTime), N'Tax')
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'5d24a39b-c960-466b-b44f-dc805ad4ead2', 5, N'TI-0005-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'20:17:10.2464657' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 9, CAST(68034.71 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(75732.62 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 20:17:10.247' AS DateTime), N'')
INSERT [dbo].[SALES_INVOICE] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'2c6a3703-4c80-4388-9645-fbc8f19b4172', 2, N'TI-0002-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'01:15:16.2599703' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 30, CAST(127516.57 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(142274.72 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 01:15:16.260' AS DateTime), N'')
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
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_BILL] OFF
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS] ON 

INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (7, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(38181.56 AS Decimal(18, 2)), CAST(18.91 AS Decimal(18, 2)), CAST(4961.14 AS Decimal(18, 2)), CAST(43123.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (8, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(22558.80 AS Decimal(18, 2)), CAST(11.17 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(22547.63 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (9, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26774.37 AS Decimal(18, 2)), CAST(13.26 AS Decimal(18, 2)), CAST(3478.94 AS Decimal(18, 2)), CAST(30240.05 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (10, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(1952.43 AS Decimal(18, 2)), CAST(0.97 AS Decimal(18, 2)), CAST(253.69 AS Decimal(18, 2)), CAST(2205.15 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (11, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(12503.46 AS Decimal(18, 2)), CAST(6.19 AS Decimal(18, 2)), CAST(1624.65 AS Decimal(18, 2)), CAST(14121.92 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (12, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(15961.38 AS Decimal(18, 2)), CAST(7.91 AS Decimal(18, 2)), CAST(2073.95 AS Decimal(18, 2)), CAST(18027.42 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (13, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(10684.35 AS Decimal(18, 2)), CAST(5.29 AS Decimal(18, 2)), CAST(1388.28 AS Decimal(18, 2)), CAST(12067.34 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (14, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(3762.06 AS Decimal(18, 2)), CAST(1.86 AS Decimal(18, 2)), CAST(488.83 AS Decimal(18, 2)), CAST(4249.03 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (15, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26460.00 AS Decimal(18, 2)), CAST(13.11 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(26446.89 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (16, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(518.58 AS Decimal(18, 2)), CAST(0.26 AS Decimal(18, 2)), CAST(67.38 AS Decimal(18, 2)), CAST(585.70 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (17, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(23977.76 AS Decimal(18, 2)), CAST(11.88 AS Decimal(18, 2)), CAST(3115.56 AS Decimal(18, 2)), CAST(27081.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (18, N'4c9908c1-4491-4390-842d-193b0a3b1b8f', N'TI-0001-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(9278.80 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(18557.60 AS Decimal(18, 2)), CAST(9.19 AS Decimal(18, 2)), CAST(2411.29 AS Decimal(18, 2)), CAST(20959.70 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (19, N'93ab91b7-e927-4670-8951-12bd8b8d6298', N'SI-0001-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(47726.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(47726.95 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (20, N'93ab91b7-e927-4670-8951-12bd8b8d6298', N'SI-0001-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(37598.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(37598.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (21, N'93ab91b7-e927-4670-8951-12bd8b8d6298', N'SI-0001-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(44623.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44623.95 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (22, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26774.37 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3480.67 AS Decimal(18, 2)), CAST(30255.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (23, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(1952.43 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(253.82 AS Decimal(18, 2)), CAST(2206.25 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (24, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(12503.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1625.45 AS Decimal(18, 2)), CAST(14128.91 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (25, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(15961.38 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(2074.98 AS Decimal(18, 2)), CAST(18036.36 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (26, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3561.45 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(462.99 AS Decimal(18, 2)), CAST(4024.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (27, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(2508.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(326.05 AS Decimal(18, 2)), CAST(2834.09 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (28, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (29, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(6 AS Decimal(18, 0)), CAST(1037.16 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(134.83 AS Decimal(18, 2)), CAST(1171.99 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (30, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(29972.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3896.39 AS Decimal(18, 2)), CAST(33868.59 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (31, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(9278.80 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9278.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1206.24 AS Decimal(18, 2)), CAST(10485.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (32, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'022', N'Temperature Recording Station', N'PC', CAST(5172.31 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5172.31 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5172.31 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (33, N'2c6a3703-4c80-4388-9645-fbc8f19b4172', N'TI-0002-CHK-075/76', N'023', N'Wine - Prem Select Charddonany', N'PC', CAST(9974.97 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9974.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1296.75 AS Decimal(18, 2)), CAST(11271.72 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (34, N'eb2d9b53-83ea-4161-8b70-438de0ed309b', N'TI-0003-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(47726.95 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(6191.50 AS Decimal(18, 2)), CAST(53818.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (35, N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', N'TI-0004-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(35 AS Decimal(18, 0)), CAST(334088.65 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(43431.52 AS Decimal(18, 2)), CAST(377520.17 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (36, N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', N'TI-0004-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(44623.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5801.11 AS Decimal(18, 2)), CAST(50425.06 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (37, N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', N'TI-0004-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(4167.82 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(541.82 AS Decimal(18, 2)), CAST(4709.64 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (38, N'6f6ed62e-d1fe-448b-88d0-a6e58779023c', N'TI-0004-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(691.66 AS Decimal(18, 2)), CAST(6012.12 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (39, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'TI-0005-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(47726.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(6204.50 AS Decimal(18, 2)), CAST(53931.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (40, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'TI-0005-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(691.66 AS Decimal(18, 2)), CAST(6012.12 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (41, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'TI-0005-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (42, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'TI-0005-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(172.86 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(22.47 AS Decimal(18, 2)), CAST(195.33 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (43, N'5d24a39b-c960-466b-b44f-dc805ad4ead2', N'TI-0005-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5994.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(779.28 AS Decimal(18, 2)), CAST(6773.72 AS Decimal(18, 2)), 1, NULL)
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS] OFF
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ON 

INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (10, NULL, N'SI-0007-CHK-075/76', N'010', N'samsung J5', N'pc', CAST(20000.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(20000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (36, NULL, N'TI-0008-CHK-075/76', N'010', N'samsung J5', N'pc', CAST(20000.00 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(60000.00 AS Decimal(18, 2)), CAST(8.81 AS Decimal(18, 2)), CAST(7798.85 AS Decimal(18, 2)), CAST(67790.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (37, NULL, N'TI-0008-CHK-075/76', N'011', N'iphone x', N'pc', CAST(100000.00 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(300000.00 AS Decimal(18, 2)), CAST(44.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(299955.96 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (38, NULL, N'TI-0008-CHK-075/76', N'012', N'lenovo smart tv', N'pc', CAST(120000.00 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(240000.00 AS Decimal(18, 2)), CAST(35.23 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(239964.77 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (39, NULL, N'TI-0008-CHK-075/76', N'013', N'Micromax mobile', N'pc', CAST(12500.00 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(37500.00 AS Decimal(18, 2)), CAST(5.50 AS Decimal(18, 2)), CAST(4874.28 AS Decimal(18, 2)), CAST(42368.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (40, NULL, N'TI-0008-CHK-075/76', N'014', N'Sony IPTV', N'pc', CAST(14567.00 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(43701.00 AS Decimal(18, 2)), CAST(6.42 AS Decimal(18, 2)), CAST(5680.30 AS Decimal(18, 2)), CAST(49374.88 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (64, NULL, N'TI-0001-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(38181.56 AS Decimal(18, 2)), CAST(18.91 AS Decimal(18, 2)), CAST(4961.14 AS Decimal(18, 2)), CAST(43123.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (65, NULL, N'TI-0001-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(22558.80 AS Decimal(18, 2)), CAST(11.17 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(22547.63 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (66, NULL, N'TI-0001-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26774.37 AS Decimal(18, 2)), CAST(13.26 AS Decimal(18, 2)), CAST(3478.94 AS Decimal(18, 2)), CAST(30240.05 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (67, NULL, N'TI-0001-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(1952.43 AS Decimal(18, 2)), CAST(0.97 AS Decimal(18, 2)), CAST(253.69 AS Decimal(18, 2)), CAST(2205.15 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (68, NULL, N'TI-0001-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(12503.46 AS Decimal(18, 2)), CAST(6.19 AS Decimal(18, 2)), CAST(1624.65 AS Decimal(18, 2)), CAST(14121.92 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (69, NULL, N'TI-0001-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(15961.38 AS Decimal(18, 2)), CAST(7.91 AS Decimal(18, 2)), CAST(2073.95 AS Decimal(18, 2)), CAST(18027.42 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (70, NULL, N'TI-0001-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(10684.35 AS Decimal(18, 2)), CAST(5.29 AS Decimal(18, 2)), CAST(1388.28 AS Decimal(18, 2)), CAST(12067.34 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (71, NULL, N'TI-0001-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(3762.06 AS Decimal(18, 2)), CAST(1.86 AS Decimal(18, 2)), CAST(488.83 AS Decimal(18, 2)), CAST(4249.03 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (72, NULL, N'TI-0001-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26460.00 AS Decimal(18, 2)), CAST(13.11 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(26446.89 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (73, NULL, N'TI-0001-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(518.58 AS Decimal(18, 2)), CAST(0.26 AS Decimal(18, 2)), CAST(67.38 AS Decimal(18, 2)), CAST(585.70 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (74, NULL, N'TI-0001-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(4 AS Decimal(18, 0)), CAST(23977.76 AS Decimal(18, 2)), CAST(11.88 AS Decimal(18, 2)), CAST(3115.56 AS Decimal(18, 2)), CAST(27081.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (75, NULL, N'TI-0001-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(9278.80 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(18557.60 AS Decimal(18, 2)), CAST(9.19 AS Decimal(18, 2)), CAST(2411.29 AS Decimal(18, 2)), CAST(20959.70 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (79, NULL, N'SI-0002-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(47726.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(47726.95 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (80, NULL, N'SI-0002-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(37598.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(37598.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (81, NULL, N'SI-0002-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(44623.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44623.95 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (94, NULL, N'TI-0002-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26774.37 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3480.67 AS Decimal(18, 2)), CAST(30255.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (95, NULL, N'TI-0002-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(1952.43 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(253.82 AS Decimal(18, 2)), CAST(2206.25 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (96, NULL, N'TI-0002-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(12503.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1625.45 AS Decimal(18, 2)), CAST(14128.91 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (97, NULL, N'TI-0002-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(15961.38 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(2074.98 AS Decimal(18, 2)), CAST(18036.36 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (98, NULL, N'TI-0002-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3561.45 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(462.99 AS Decimal(18, 2)), CAST(4024.44 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (99, NULL, N'TI-0002-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(2508.04 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(326.05 AS Decimal(18, 2)), CAST(2834.09 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (100, NULL, N'TI-0002-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (101, NULL, N'TI-0002-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(6 AS Decimal(18, 0)), CAST(1037.16 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(134.83 AS Decimal(18, 2)), CAST(1171.99 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (102, NULL, N'TI-0002-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(29972.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3896.39 AS Decimal(18, 2)), CAST(33868.59 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (103, NULL, N'TI-0002-CHK-075/76', N'021', N'Gatorade - Xfactor Berry', N'Litre', CAST(9278.80 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9278.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1206.24 AS Decimal(18, 2)), CAST(10485.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (104, NULL, N'TI-0002-CHK-075/76', N'022', N'Temperature Recording Station', N'PC', CAST(5172.31 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5172.31 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5172.31 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (105, NULL, N'TI-0002-CHK-075/76', N'023', N'Wine - Prem Select Charddonany', N'PC', CAST(9974.97 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(9974.97 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1296.75 AS Decimal(18, 2)), CAST(11271.72 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (106, NULL, N'TI-0003-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(47726.95 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), CAST(6191.50 AS Decimal(18, 2)), CAST(53818.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (122, N'cea2b68d-0d6e-41c7-a395-8513a2e6dbc6', N'TI-0004-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(8 AS Decimal(18, 0)), CAST(76363.12 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(9927.21 AS Decimal(18, 2)), CAST(86290.33 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (123, N'cea2b68d-0d6e-41c7-a395-8513a2e6dbc6', N'TI-0004-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(22558.80 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(22558.80 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (124, N'cea2b68d-0d6e-41c7-a395-8513a2e6dbc6', N'TI-0004-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(26774.37 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3480.67 AS Decimal(18, 2)), CAST(30255.04 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (129, NULL, N'TI-0004-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(35 AS Decimal(18, 0)), CAST(334088.65 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(43431.52 AS Decimal(18, 2)), CAST(377520.17 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (130, NULL, N'TI-0004-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(44623.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5801.11 AS Decimal(18, 2)), CAST(50425.06 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (131, NULL, N'TI-0004-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(4167.82 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(541.82 AS Decimal(18, 2)), CAST(4709.64 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (132, NULL, N'TI-0004-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(691.66 AS Decimal(18, 2)), CAST(6012.12 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (134, NULL, N'TI-0005-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(5 AS Decimal(18, 0)), CAST(47726.95 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(6204.50 AS Decimal(18, 2)), CAST(53931.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (135, NULL, N'TI-0005-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(691.66 AS Decimal(18, 2)), CAST(6012.12 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (136, NULL, N'TI-0005-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (137, NULL, N'TI-0005-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(172.86 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(22.47 AS Decimal(18, 2)), CAST(195.33 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (138, NULL, N'TI-0005-CHK-075/76', N'020', N'Radish - Black, Winter, Organic', N'Litre', CAST(5994.44 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5994.44 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(779.28 AS Decimal(18, 2)), CAST(6773.72 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1142, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'019', N'Nut - Walnut, Pieces', N'KG', CAST(172.86 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(172.86 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(172.86 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1143, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'018', N'Chef Hat 25cm', N'Litre', CAST(8820.00 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8820.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8820.00 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1144, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'017', N'Tart - Butter Plain Squares', N'PC', CAST(1254.02 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(1254.02 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1254.02 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1145, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'016', N'Bread - Raisin', N'KG', CAST(3561.45 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(3561.45 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(3561.45 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1146, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'015', N'Lamb Tenderloin Nz Fr', N'Litre', CAST(5320.46 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(5320.46 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(5320.46 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1147, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'014', N'Dc - Sakura Fu', N'KG', CAST(4167.82 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(4167.82 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(4167.82 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1148, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'013', N'Wine - Two Oceans Cabernet', N'PC', CAST(650.81 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(650.81 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(650.81 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1149, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'012', N'Sauce - Salsa', N'KG', CAST(8924.79 AS Decimal(18, 2)), CAST(1 AS Decimal(18, 0)), CAST(8924.79 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(8924.79 AS Decimal(18, 2)), 1, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1150, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'011', N'Mushroom - Porcini, Dry', N'PC', CAST(7519.60 AS Decimal(18, 2)), CAST(2 AS Decimal(18, 0)), CAST(15039.20 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(15039.20 AS Decimal(18, 2)), 0, NULL)
INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Bar_Code], [Name], [Unit], [Rate], [Quantity], [Gross_Amount], [Discount], [Tax], [Net_Amount], [Is_Vatable], [Remarks]) VALUES (1151, N'a2094f6d-10a9-492d-8a6b-c644875bc56f', N'SI-0006-CHK-075/76', N'010', N'Wiberg Cure', N'Litre', CAST(9545.39 AS Decimal(18, 2)), CAST(3 AS Decimal(18, 0)), CAST(28636.17 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(28636.17 AS Decimal(18, 2)), 1, NULL)
SET IDENTITY_INSERT [dbo].[SALES_INVOICE_ITEMS_TMP] OFF
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'cea2b68d-0d6e-41c7-a395-8513a2e6dbc6', 0, N'TI-0004-CHK-075/76', CAST(N'2019-04-11 00:00:00.000' AS DateTime), N'2075-12-28', CAST(N'11:16:51.8029070' AS Time), N'Tax', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 14, CAST(125696.29 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(139104.16 AS Decimal(18, 2)), N'', CAST(N'2019-04-11 11:16:51.803' AS DateTime), N'Sales')
INSERT [dbo].[SALES_INVOICE_TMP] ([Id], [Invoice_Id], [Invoice_Number], [Trans_Date_AD], [Trans_Date_BS], [Trans_Time], [Trans_Type], [Chalan_Number], [Division], [Terminal], [Customer_Id], [Customer_Name], [Customer_Vat], [Customer_Mobile], [Customer_Address], [Flat_Discount_Amount], [Flat_Discount_Percent], [Total_Quantity], [Total_Gross_Amount], [Total_Discount], [Total_Vat], [Total_Net_Amount], [Created_By], [Created_Date], [Remarks]) VALUES (N'a2094f6d-10a9-492d-8a6b-c644875bc56f', 0, N'SI-0006-CHK-075/76', NULL, NULL, CAST(N'16:50:26.8667925' AS Time), N'Hold', N'', N'Divisioin', N'Terminal', NULL, N'', N'', N'', N'', NULL, NULL, 13, CAST(76547.58 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, CAST(76547.58 AS Decimal(18, 2)), N'', CAST(N'2019-04-12 16:50:26.867' AS DateTime), N'Sales')
SET IDENTITY_INSERT [dbo].[STORE] ON 

INSERT [dbo].[STORE] ([ID], [INITIAL], [NAME], [COMPANY_NAME], [ADDRESS], [PHONE], [PHONE_ALT], [FAX], [VAT], [EMAIL], [WEBSITE], [FISCAL_YEAR]) VALUES (1, N'CHK', N'SALEWAYS CHAKRAPATH STORE', N'SALEWAYS', N'CHAKRAPATH', N'4720533', N'4720518', NULL, N'4720518', N'info@saleways.com', N'www.saleways.com', N'075/76')
SET IDENTITY_INSERT [dbo].[STORE] OFF
SET IDENTITY_INSERT [dbo].[TERMINAL] ON 

INSERT [dbo].[TERMINAL] ([Id], [Initial], [Name], [Is_Active], [Remarks], [Cash_Drop_Limit]) VALUES (5, N'CHK1', N'Terminal 1', NULL, NULL, NULL)
INSERT [dbo].[TERMINAL] ([Id], [Initial], [Name], [Is_Active], [Remarks], [Cash_Drop_Limit]) VALUES (6, N'CHK2', N'Terminal 2', 1, NULL, NULL)
INSERT [dbo].[TERMINAL] ([Id], [Initial], [Name], [Is_Active], [Remarks], [Cash_Drop_Limit]) VALUES (7, N'CHK3', N'Terminal 3', 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[TERMINAL] OFF
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
USE [master]
GO
ALTER DATABASE [POS] SET  READ_WRITE 
GO
