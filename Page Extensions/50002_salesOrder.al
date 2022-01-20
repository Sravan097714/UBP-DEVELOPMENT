pageextension 50002 SalesOrder extends "Sales Order"
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
        addafter("Promised Delivery Date")
        {
            field("Promised Delivery Time"; Rec."Promised Delivery Time")
            {
                ApplicationArea = all;
            }
        }
        addafter("Requested Delivery Date")
        {
            field("Requested Delivery Time"; Rec."Requested Delivery Time")
            {
                ApplicationArea = all;
            }
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        moveafter("Your Reference"; "Transport Method")


        addafter("Shipping Time")
        {
            field("Shipping Time2"; Rec."Shipping Time2")
            {
                ApplicationArea = all;
                Caption = 'Shipping Time';
            }
        }
    }

    actions
    {
        modify(Reopen)
        {
            Enabled = EnableReopen;
        }
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    begin
        EnableReopen := false;

        if UserSetup.Get(UserId) then;
        if UserSetup."ReOpen Sales Order" then
            EnableReopen := true;
    end;

    var
        myInt: Integer;
        EnableReopen: Boolean;
        UserSetup: record "User Setup";
}