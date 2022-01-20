tableextension 50010 "Sales Invoice Line" extends "Sales Invoice Line"
{
    fields
    {
        field(50001; "Corresponding Item Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}