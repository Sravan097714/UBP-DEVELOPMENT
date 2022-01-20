tableextension 50000 VendorExt extends Vendor
{
    fields
    {
        field(50000; "National Id No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        modify("Telex No.")
        {
            Caption = 'BRN No.';
        }
        field(50001; "Payee Name"; Text[100])
        {

        }
        field(50002; BRN; Code[10])
        {

        }
        field(50003; NID; Code[10])
        {

        }
    }

    var
        myInt: Integer;
}