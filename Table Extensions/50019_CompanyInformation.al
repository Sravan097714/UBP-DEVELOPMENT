tableextension 50019 "Company Information Ext" extends "Company Information"
{
    fields
    {
        field(50000; BRN; Code[20])
        {

        }
        field(50001; TAN; Code[10])
        {

        }
        field(50003; "Telephone Number - MRA"; Code[20])
        {

        }
        field(50004; "Mobile Number - MRA"; Code[20])
        {

        }
        field(50005; "Name of Declarant"; Text[200])
        {

        }
        field(50006; "Email Address - MRA"; Text[200])
        {

        }


        // Add changes to table fields here
    }

    var
        myInt: Integer;
}