pageextension 50032 "Purchase Invoice Ext" extends "Purchase Invoices"
{
    layout
    {
        addafter(Amount)
        {
            field("Created By"; "Created By")
            {
                ApplicationArea = All;
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