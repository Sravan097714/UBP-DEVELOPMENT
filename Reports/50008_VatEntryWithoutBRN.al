report 50008 "Vat Entry Without BRN"
{
    Caption = 'RC-Vat Entry Without BRN';
    ProcessingOnly = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting("Entry No.") where(Type = filter('Sale'), "Document Type" = filter('Invoice|Credit Memo'));
            RequestFilterFields = "Posting Date", "Document No.";
            trigger OnAfterGetRecord()
            var
                Customer: Record Customer;
                VatPeriodDate: Date;
                VatPeriod: Text;
                VatMonth: Text;
                VatDate: Text;
            begin
                if Customer.Get("VAT Entry"."Bill-to/Pay-to No.") then;
                if ("VAT Entry"."VAT Registration No." = '') and (Customer."Telex No." = '') then begin
                    ExcelBuffer1.NewRow;
                    ExcelBuffer1.AddColumn(CopyStr("VAT Entry"."VAT Registration No.", 4, 20), FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(Customer.Name, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                    if "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice then begin
                        ExcelBuffer1.AddColumn(Abs("VAT Entry".Base), FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                        ExcelBuffer1.AddColumn(Abs("VAT Entry".Amount), FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                    end else begin
                        ExcelBuffer1.AddColumn(-"VAT Entry".Base, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                        ExcelBuffer1.AddColumn(-"VAT Entry".Amount, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                    end;
                    VatPeriodDate := "VAT Entry"."Posting Date";
                    if StrLen(Format(Date2DMY(VatPeriodDate, 2))) = 1 then
                        VatMonth := '0' + Format(Date2DMY(VatPeriodDate, 2))
                    else
                        VatMonth := Format(Date2DMY(VatPeriodDate, 2));
                    if StrLen(Format(Date2DMY(VatPeriodDate, 1))) = 1 then
                        VatDate := '0' + Format(Date2DMY(VatPeriodDate, 1))
                    else
                        VatDate := Format(Date2DMY(VatPeriodDate, 1));
                    VatPeriod := Format(Date2DMY(VatPeriodDate, 3)) + VatMonth + VatDate;
                    ExcelBuffer1.AddColumn(VatPeriod, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn("VAT Entry"."Document No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                    ExcelBuffer1.AddColumn(Customer."Telex No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        ExcelBuffer1: Record "Excel Buffer" temporary;
        CompanyInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        MakeOrderExcelDataBody1();
        MakeExcelDataHeader1();
        MakeOrderExcelDataBody2();
        MakeExcelDataHeader2();
    end;

    trigger OnPostReport()
    begin
        ExcelBuffer1.CreateBookAndOpenExcel('', 'Vat Entries', '', COMPANYNAME, USERID);
    end;

    PROCEDURE MakeExcelDataHeader1()
    BEGIN
        ExcelBuffer1.NewRow;
        ExcelBuffer1.AddColumn('VAT Payer Tan', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('VAT Payer Business Registration Number (BRN)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Vat Payer Full Name', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('VAT Period', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Telephone Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Mobile Number', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Name of Declarant', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Email Address', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
    END;

    PROCEDURE MakeExcelDataHeader2()
    BEGIN
        ExcelBuffer1.NewRow;
        ExcelBuffer1.AddColumn('VAT Registration No. of person to whom supplies is made', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Name of person to whom supplies is made', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Value of Supplies (MUR)', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('VAT Amount ', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Date of Invoice', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('Invoice No.', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn('BRN of person to whom supplies is made', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
    END;

    PROCEDURE MakeOrderExcelDataBody1()
    BEGIN
        ExcelBuffer1.NewRow;
        //ExcelBuffer1.AddColumn(CompanyInfo.MNS, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo.VT03, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."V1.0", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
    END;

    PROCEDURE MakeOrderExcelDataBody2()
    var
        VatPeriodDate: Date;
        VatPeriod: Text;
        VatMonth: Text;
    BEGIN
        VatPeriodDate := "VAT Entry".GetRangeMin("Posting Date");
        if StrLen(Format(Date2DMY(VatPeriodDate, 2))) = 1 then
            VatMonth := '0' + Format(Date2DMY(VatPeriodDate, 2))
        else
            VatMonth := Format(Date2DMY(VatPeriodDate, 2));
        VatPeriod := Format(Date2DMY(VatPeriodDate, 3)) + VatMonth;
        ExcelBuffer1.NewRow;
        //ExcelBuffer1.AddColumn(CompanyInfo."VAT Payer Tan", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."VAT BRN No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."Vat Payer Name", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        ExcelBuffer1.AddColumn(VatPeriod, FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."Telephone Number", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."Vat Mobile Number", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."Name of VAT Declarant", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
        //ExcelBuffer1.AddColumn(CompanyInfo."VAT Email Address", FALSE, '', false, FALSE, TRUE, '', ExcelBuffer1."Cell Type"::Text);
    END;
}