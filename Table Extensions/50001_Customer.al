tableextension 50001 CustomerExts extends Customer
{
    fields
    {
        field(50000; "National Id No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Client Risque"; Text[3])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Sync External"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify("Telex No.")
        {
            Caption = 'BRN No.';
        }
    }

    var
        myInt: Integer;
}