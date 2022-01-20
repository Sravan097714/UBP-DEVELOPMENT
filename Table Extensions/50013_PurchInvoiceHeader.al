tableextension 50013 "Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    var
        myInt: Integer;
}