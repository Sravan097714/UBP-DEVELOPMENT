pageextension 50036 "Company Information Ext" extends "Company Information"
{
    layout
    {
        addafter("Auto. Send Transactions")
        {
            field(BRN; BRN)
            {

            }
            field(TAN; TAN)
            {

            }
            field("Telephone Number - MRA"; "Telephone Number - MRA")
            {
                Caption = 'Telephone Number';

            }
            field("Mobile Number - MRA"; "Mobile Number - MRA")
            {
                Caption = 'Mobile Number';
            }
            field("Name of Declarant"; "Name of Declarant")
            {

            }
            field("Email Address - MRA"; "Email Address - MRA")
            {
                Caption = 'Email of Declarant';
            }

        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}