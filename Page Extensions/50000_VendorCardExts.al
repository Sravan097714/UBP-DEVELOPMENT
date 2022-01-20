pageextension 50000 VendorCardExts extends "Vendor Card"
{
    layout
    {
        addafter("Responsibility Center")
        {
            field("Telex No."; Rec."Telex No.")
            {
                ApplicationArea = all;
                Caption = 'BRN No.';
            }
            field("National Id No"; Rec."National Id No")
            {
                ApplicationArea = all;
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