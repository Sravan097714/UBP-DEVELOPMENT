pageextension 50004 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        modify("Posting Description")
        {
            Visible = true;
        }
        modify("Shipment Method Code")
        {
            Caption = 'Vehicle Code';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Contractor';
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