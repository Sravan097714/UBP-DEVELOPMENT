tableextension 50002 UsersetupExts extends "User Setup"
{
    fields
    {
        field(50000; "Discount Amount(Max)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Ship Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Invoice Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Ship & Invoice Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Receive Purchase Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Invoice Purchase Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Receive & Invoice Purch. Order"; Boolean)
        {
            Caption = 'Receive & Invoice Purchase Order';
            DataClassification = ToBeClassified;
        }
        field(50007; "Modify Unit Price"; Boolean)
        {
            Caption = 'Modify Sales Unit Price';
            DataClassification = ToBeClassified;
        }
        field(50008; "Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(50009; "Batches Assigned"; Integer)
        {
            Editable = false;
            Caption = 'No. of Batches Assigned';
            FieldClass = FlowField;
            CalcFormula = count("SalesPerson Batch Setup" where("User ID" = field("User ID")));
        }
        field(50010; "ReOpen Sales Order"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Name on documents"; Text[100])
        {

        }
    }

    var
        myInt: Integer;
}