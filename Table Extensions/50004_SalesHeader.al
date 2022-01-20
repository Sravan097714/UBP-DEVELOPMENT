tableextension 50004 "Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(50000; "Promised Delivery Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Requested Delivery Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Shipping Time2"; Time)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shipping Time';
        }
        field(50003; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        "Created By" := UserId;
    end;

    trigger OnModify()
    begin
        "Created By" := UserId;

    end;

    trigger OnDelete()
    begin
        "Created By" := UserId;
    end;
}