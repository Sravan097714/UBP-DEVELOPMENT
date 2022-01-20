pageextension 50022 PurchInvSubform extends "Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        moveafter(Quantity; "VAT Prod. Posting Group")
        moveafter("VAT Prod. Posting Group"; "Gen. Prod. Posting Group")
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
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