pageextension 50030 "Posted Sales InvoiceExt" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Remaining Amount")
        {
            field("Created By"; "Created By")
            {
                ApplicationArea = all;
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