tableextension 50003 ItemExts extends Item
{
    fields
    {
        field(50000; "Famille Category"; Code[20])
        {
            TableRelation = "Item Category";
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}