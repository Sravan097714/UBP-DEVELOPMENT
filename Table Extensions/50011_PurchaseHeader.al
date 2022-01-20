tableextension 50011 "Purchase Header Exts" extends "Purchase Header"
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

    trigger OnAfterInsert()
    begin
        "Created By" := UserId;
    end;
}