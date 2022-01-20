pageextension 50031 "Purchase Order Ext" extends "Purchase Order List"
{
    layout
    {
        addafter("Amount Including VAT")
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

    var
        myInt: Integer;
}