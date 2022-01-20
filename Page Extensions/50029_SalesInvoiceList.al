pageextension 50029 "Sales Invoice ListExt" extends "Sales Invoice List"
{
    layout
    {
        addafter("Posting Date")
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