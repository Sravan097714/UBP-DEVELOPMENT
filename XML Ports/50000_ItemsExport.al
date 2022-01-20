xmlport 50000 "Export Items"
{
    Direction = Export;
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(Item; Item)
            {
                textattribute(ItemNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemNo := CopyStr(Item."No.", 1, 10)
                    end;
                }
                textattribute(ItemNo2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemNo2 := CopyStr(Item."No.", 1, 10)
                    end;
                }
                textattribute(Description)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Description := CopyStr(Item.Description, 1, 40)
                    end;
                }
                textattribute(ItemCat)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemNo := Item."Famille Category";
                    end;
                }
                textattribute(UOM)
                {
                    trigger OnBeforePassVariable()
                    begin
                        UOM := Item."Base Unit of Measure"
                    end;
                }
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    var
        myInt: Integer;
}