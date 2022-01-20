pageextension 50009 PurchordersubFormExts extends "Purchase Order Subform"
{
    layout
    {
        modify("Reserved Quantity")
        {
            Visible = false;
        }

        moveafter(Quantity; "VAT Prod. Posting Group")


        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        addafter(Quantity)
        {
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                Visible = true;
            }
        }
        modify("Bin Code") { Visible = false; }
        modify("Tax Area Code") { Visible = false; }
        modify("Tax Group Code") { Visible = false; }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}