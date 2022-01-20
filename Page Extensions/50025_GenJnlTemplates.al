pageextension 50025 GenJnlTemplates extends "General Journal Templates"
{
    layout
    {
        addafter("Reason Code")
        {
            field("PageID"; "Page ID")
            {
                ApplicationArea = all;
            }
            field("Posting ReportID"; "Posting Report ID")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}