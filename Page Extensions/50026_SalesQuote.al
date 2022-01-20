pageextension 50026 "Sales Quote " extends "Sales Quotes"
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Created By" := UserId;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        "Created By" := UserId;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Created By" := UserId;
    end;



}