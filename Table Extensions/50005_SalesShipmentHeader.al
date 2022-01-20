tableextension 50005 "Sales Shipment Header" extends "Sales Shipment Header"
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
}