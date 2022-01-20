pageextension 50028 "General Ledger SetupExt" extends "General Ledger Setup"
{
    layout
    {
        addafter("Bank Account Nos.")
        {
            field("SalesPerson Document Nos"; "SalesPerson Document Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Salesperson Document No for journal';
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}