pageextension 50008 PurchaseCreditMemo extends "Purchase Credit Memo"
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
        test: Report 405;
        Teest2: Page "Posted Sales Invoice";
}