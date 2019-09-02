using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using System;

namespace POS.Core.Migrations
{
    public partial class updatetable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "AspNetUserTokens",
                nullable: false,
                oldClrType: typeof(string),
                oldMaxLength: 128);

            migrationBuilder.AlterColumn<string>(
                name: "LoginProvider",
                table: "AspNetUserTokens",
                nullable: false,
                oldClrType: typeof(string),
                oldMaxLength: 128);

            migrationBuilder.AlterColumn<string>(
                name: "ProviderKey",
                table: "AspNetUserLogins",
                nullable: false,
                oldClrType: typeof(string),
                oldMaxLength: 128);

            migrationBuilder.AlterColumn<string>(
                name: "LoginProvider",
                table: "AspNetUserLogins",
                nullable: false,
                oldClrType: typeof(string),
                oldMaxLength: 128);

            migrationBuilder.CreateTable(
                name: "Customer",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Code = table.Column<string>(nullable: true),
                    Name = table.Column<string>(nullable: true),
                    Address = table.Column<string>(nullable: true),
                    Image = table.Column<string>(nullable: true),
                    Tel1 = table.Column<string>(nullable: true),
                    Tel2 = table.Column<string>(nullable: true),
                    Mobile1 = table.Column<string>(nullable: true),
                    Mobile2 = table.Column<string>(nullable: true),
                    Email = table.Column<string>(nullable: true),
                    Vat = table.Column<string>(nullable: true),
                    Fax = table.Column<string>(nullable: true),
                    Po_Box = table.Column<string>(nullable: true),
                    Type = table.Column<string>(nullable: true),
                    Credit_Limit = table.Column<decimal>(nullable: true),
                    Credit_Day = table.Column<int>(nullable: true),
                    Is_Sale_Refused = table.Column<bool>(nullable: true),
                    Is_Member = table.Column<bool>(nullable: true),
                    Member_Id = table.Column<string>(nullable: true),
                    Barcode = table.Column<string>(nullable: true),
                    Dob = table.Column<DateTime>(nullable: true),
                    Dob_Bs = table.Column<string>(nullable: true),
                    Wedding_Date = table.Column<DateTime>(nullable: true),
                    Family_Member_Int = table.Column<int>(nullable: true),
                    Occupation = table.Column<string>(nullable: true),
                    Office_Name = table.Column<string>(nullable: true),
                    Office_Address = table.Column<string>(nullable: true),
                    Designation = table.Column<string>(nullable: true),
                    Registration_Date = table.Column<DateTime>(nullable: true),
                    Validity_Period = table.Column<string>(nullable: true),
                    Validity_Date = table.Column<DateTime>(nullable: true),
                    Membership_Scheme = table.Column<int>(nullable: true),
                    Reference_By = table.Column<string>(nullable: true),
                    Created_By = table.Column<string>(nullable: true),
                    Created_Date = table.Column<DateTime>(nullable: true),
                    Remarks = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Customer", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Item",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Code = table.Column<string>(nullable: true),
                    Bar_Code = table.Column<string>(nullable: true),
                    Name = table.Column<string>(nullable: true),
                    Parent_Code = table.Column<string>(nullable: true),
                    Type = table.Column<string>(nullable: true),
                    Unit = table.Column<string>(nullable: true),
                    Rate = table.Column<decimal>(nullable: true),
                    Is_Vatable = table.Column<bool>(nullable: true),
                    Remarks = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Item", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Item_Category",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Code = table.Column<string>(nullable: true),
                    Parent_Code = table.Column<string>(nullable: true),
                    Description = table.Column<string>(nullable: true),
                    Indentation = table.Column<int>(nullable: false),
                    Order = table.Column<int>(nullable: false),
                    Has_Child = table.Column<bool>(nullable: false),
                    Modified_Date = table.Column<DateTime>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Item_Category", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Item_Group",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Code = table.Column<string>(nullable: true),
                    Description = table.Column<string>(nullable: true),
                    Item_Category_Code = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Item_Group", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SALES_INVOICE",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Invoice_Id = table.Column<int>(nullable: false),
                    Invoice_Number = table.Column<string>(nullable: true),
                    Trans_Date_Ad = table.Column<DateTime>(nullable: true),
                    Trans_Date_Bs = table.Column<string>(nullable: true),
                    Trans_Time = table.Column<TimeSpan>(nullable: true),
                    Trans_Type = table.Column<string>(nullable: true),
                    Chalan_Number = table.Column<string>(nullable: true),
                    Division = table.Column<string>(nullable: true),
                    Terminal = table.Column<string>(nullable: true),
                    Customer_Id = table.Column<int>(nullable: true),
                    Customer_Name = table.Column<string>(nullable: true),
                    Customer_Vat = table.Column<string>(nullable: true),
                    Customer_Mobile = table.Column<string>(nullable: true),
                    Customer_Address = table.Column<string>(nullable: true),
                    Flat_Discount_Amount = table.Column<decimal>(nullable: true),
                    Flat_Discount_Percent = table.Column<decimal>(nullable: true),
                    Total_Quantity = table.Column<int>(nullable: true),
                    Total_Gross_Amount = table.Column<decimal>(nullable: true),
                    Total_Discount = table.Column<decimal>(nullable: true),
                    Total_Vat = table.Column<decimal>(nullable: true),
                    Total_Net_Amount = table.Column<decimal>(nullable: true),
                    Created_By = table.Column<string>(nullable: true),
                    Created_Date = table.Column<DateTime>(nullable: true),
                    Remarks = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SALES_INVOICE", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SALES_INVOICE_BILL",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Invoice_Id_Temp = table.Column<Guid>(nullable: false),
                    Invoice_Number = table.Column<string>(nullable: true),
                    Division = table.Column<string>(nullable: true),
                    Terminal = table.Column<string>(nullable: true),
                    Trans_Mode = table.Column<string>(nullable: true),
                    Account = table.Column<string>(nullable: true),
                    Amount = table.Column<decimal>(nullable: false),
                    Remarks = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SALES_INVOICE_BILL", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "SALES_INVOICE_TMP",
                columns: table => new
                {
                    Id = table.Column<Guid>(nullable: false),
                    Invoice_Id = table.Column<int>(nullable: false),
                    Invoice_Number = table.Column<string>(nullable: true),
                    Trans_Date_Ad = table.Column<DateTime>(nullable: true),
                    Trans_Date_Bs = table.Column<string>(nullable: true),
                    Trans_Time = table.Column<TimeSpan>(nullable: true),
                    Trans_Type = table.Column<string>(nullable: true),
                    Chalan_Number = table.Column<string>(nullable: true),
                    Division = table.Column<string>(nullable: true),
                    Terminal = table.Column<string>(nullable: true),
                    Customer_Id = table.Column<int>(nullable: true),
                    Customer_Name = table.Column<string>(nullable: true),
                    Customer_Vat = table.Column<string>(nullable: true),
                    Customer_Mobile = table.Column<string>(nullable: true),
                    Customer_Address = table.Column<string>(nullable: true),
                    Flat_Discount_Amount = table.Column<decimal>(nullable: true),
                    Flat_Discount_Percent = table.Column<decimal>(nullable: true),
                    Total_Quantity = table.Column<int>(nullable: true),
                    Total_Gross_Amount = table.Column<decimal>(nullable: true),
                    Total_Discount = table.Column<decimal>(nullable: true),
                    Total_Vat = table.Column<decimal>(nullable: true),
                    Total_Net_Amount = table.Column<decimal>(nullable: true),
                    Created_By = table.Column<string>(nullable: true),
                    Created_Date = table.Column<DateTime>(nullable: true),
                    Remarks = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_SALES_INVOICE_TMP", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Terminal",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    Initial = table.Column<string>(nullable: true),
                    Name = table.Column<string>(nullable: true),
                    Is_Active = table.Column<bool>(nullable: true),
                    Remarks = table.Column<string>(nullable: true),
                    Cash_Drop_Limit = table.Column<decimal>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Terminal", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Denomination",
                columns: table => new
                {
                    Id = table.Column<int>(nullable: false)
                        .Annotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn),
                    User_Id = table.Column<string>(nullable: true),
                    Terminal_Id = table.Column<int>(nullable: false),
                    Date = table.Column<DateTime>(nullable: false),
                    Debit_Card = table.Column<decimal>(nullable: true),
                    Cheque = table.Column<decimal>(nullable: true),
                    R1000 = table.Column<decimal>(nullable: true),
                    R500 = table.Column<decimal>(nullable: true),
                    R250 = table.Column<decimal>(nullable: true),
                    R100 = table.Column<decimal>(nullable: true),
                    R50 = table.Column<decimal>(nullable: true),
                    R25 = table.Column<decimal>(nullable: true),
                    R20 = table.Column<decimal>(nullable: true),
                    R10 = table.Column<decimal>(nullable: true),
                    R5 = table.Column<decimal>(nullable: true),
                    R2 = table.Column<decimal>(nullable: true),
                    R1 = table.Column<decimal>(nullable: true),
                    R05 = table.Column<decimal>(nullable: true),
                    Ric = table.Column<decimal>(nullable: true),
                    Other = table.Column<decimal>(nullable: true),
                    Total = table.Column<decimal>(nullable: true),
                    Remarks = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Denomination", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Denomination_Terminal_Terminal_Id",
                        column: x => x.Terminal_Id,
                        principalTable: "Terminal",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Denomination_Terminal_Id",
                table: "Denomination",
                column: "Terminal_Id");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Customer");

            migrationBuilder.DropTable(
                name: "Denomination");

            migrationBuilder.DropTable(
                name: "Item");

            migrationBuilder.DropTable(
                name: "Item_Category");

            migrationBuilder.DropTable(
                name: "Item_Group");

            migrationBuilder.DropTable(
                name: "SALES_INVOICE");

            migrationBuilder.DropTable(
                name: "SALES_INVOICE_BILL");

            migrationBuilder.DropTable(
                name: "SALES_INVOICE_TMP");

            migrationBuilder.DropTable(
                name: "Terminal");

            migrationBuilder.AlterColumn<string>(
                name: "Name",
                table: "AspNetUserTokens",
                maxLength: 128,
                nullable: false,
                oldClrType: typeof(string));

            migrationBuilder.AlterColumn<string>(
                name: "LoginProvider",
                table: "AspNetUserTokens",
                maxLength: 128,
                nullable: false,
                oldClrType: typeof(string));

            migrationBuilder.AlterColumn<string>(
                name: "ProviderKey",
                table: "AspNetUserLogins",
                maxLength: 128,
                nullable: false,
                oldClrType: typeof(string));

            migrationBuilder.AlterColumn<string>(
                name: "LoginProvider",
                table: "AspNetUserLogins",
                maxLength: 128,
                nullable: false,
                oldClrType: typeof(string));
        }
    }
}
