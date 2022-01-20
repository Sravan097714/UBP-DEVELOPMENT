pageextension 50033 "Posted Purchase Invoice" extends "Posted Purchase Invoices"
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