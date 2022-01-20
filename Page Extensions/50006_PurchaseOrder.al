pageextension 50006 PurchaseOrder extends "Purchase Order"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }
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