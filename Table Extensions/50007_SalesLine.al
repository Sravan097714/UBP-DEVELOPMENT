tableextension 50007 SalesLineExt extends "Sales Line"
{
    fields
    {
        modify(Type)
        {
            trigger OnBeforeValidate()
            begin
                Rec.TestField(Type, Rec.Type::Item);
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                if ("Line Discount Amount Per Unit" <> 0) and (Quantity <> 0) then
                    Rec.Validate("Line Discount Amount", "Line Discount Amount Per Unit" * Quantity)
                else
                    IF "Line Amount" <> 0 then
                        Rec.Validate("Line Discount Amount", 0)
            end;
        }
        field(50000; "Line Discount Amount Per Unit"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if ("Line Discount Amount Per Unit" <> 0) and (Quantity <> 0) then
                    Rec.Validate("Line Discount Amount", "Line Discount Amount Per Unit" * Quantity)
                else
                    IF "Line Amount" <> 0 then
                        Rec.Validate("Line Discount Amount", 0)
            end;
        }
        field(50001; "Corresponding Item Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Line"."Line No." where("Document Type" = field("Document Type"), "Document No." = field("Document No."));
        }
    }

    var
        myInt: Integer;
}