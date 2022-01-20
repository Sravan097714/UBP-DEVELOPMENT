pageextension 50034 "Sales credit MemoExt" extends "Sales Credit Memos"
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