reportextension 50001 "Sales Order Report" extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Header)
        {
            column(HomePage_Header_Lbl; HomePageLbl2)
            {
            }

            column(EMail_Header_Lbl; EMailLbl2)
            {
            }
            column(SalesPerson_Name; SalesPerson.Name) { }
            column(SalesPerson_JobTitle; SalesPerson."Job Title") { }
            column(SalesPerson_PhoneNo; SalesPerson."Phone No.") { }

        }

        add(Line)
        {
            column(Corresponding_Item_Line_No; "Corresponding Item Line No")
            {

            }
            column(SumOfUnitPrice; SumOfUnitPrice)
            {

            }
            column(SumofLineAmount; SumofLineAmount)
            {

            }
        }
        modify(Line)
        {

            trigger OnAfterAfterGetRecord()
            var
                SalesLine: Record "Sales Line";
            begin
                Clear(SumofLineAmount);
                Clear(SumOfUnitPrice);
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", "Document No.");
                SalesLine.SetRange("Corresponding Item Line No", "Line No.");
                if SalesLine.FindSet() then begin
                    SalesLine.CalcSums("Unit Price");
                    SalesLine.CalcSums("Line Amount");
                    SumOfUnitPrice := format(SalesLine."Unit Price" + "Unit Price");
                    SumofLineAmount := format(SalesLine."Line Amount" + "Line Amount");
                    "Corresponding Item Line No" := "Line No.";
                end else begin
                    if "Corresponding Item Line No" = 0 then
                        "Corresponding Item Line No" := "Line No." + 1;
                    SumOfUnitPrice := Format("Unit Price");
                    SumofLineAmount := Format("Line Amount");
                end;
                if Type = Type::" " then begin
                    Clear(SumofLineAmount);
                    Clear(SumOfUnitPrice);
                    "Corresponding Item Line No" := "Line No." + 1;
                end;
            end;

        }

        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            var
            begin

                if SalesPerson.Get("Salesperson Code") then;

            end;
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }
    var
        SumOfUnitPrice: Text;
        SumofLineAmount: Text;

        HomePageLbl2: Label 'Home Page';
        EMailLbl2: Label 'Email';
        SalesPerson: Record "Salesperson/Purchaser";
}