pageextension 50035 "Purchase Credit MemosExt" extends "Purchase Credit Memos"
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