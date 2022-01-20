pageextension 50011 ItemCard extends "Item Card"
{
    layout
    {
        addafter("Item Category Code")
        {
            field("Famille Category"; Rec."Famille Category")
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