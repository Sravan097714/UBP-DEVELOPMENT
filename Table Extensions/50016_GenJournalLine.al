tableextension 50016 "Gen Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Account No. SalesPerson"; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" WHERE("Account Type" = CONST(Posting),
                                                                                          Blocked = CONST(false), "Sales Person" = const(true));

            trigger OnValidate()
            begin
                "Account No." := "Account No. SalesPerson";
                Validate("Account No.");

            end;

        }
        field(50001; "SalesPerson No. Series"; Code[20])
        {

        }
        field(50002; "Payee Name"; Text[100])
        {

        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}