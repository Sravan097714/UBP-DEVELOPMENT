tableextension 50015 "Charts of Account Ext" extends "G/L Account"
{
    fields
    {
        field(50001; "Sales Person"; Boolean)
        {
            Caption = 'For Salesperson';

        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}