xmlport 50001 "Export Customers"
{
    Direction = Export;
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(Customer; Customer)
            {
                textattribute(ItemNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ItemNo := CopyStr(Customer."No.", 1, 6)
                    end;
                }
                textattribute(Name)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Name := CopyStr(Customer.Name + ' ' + Customer."Name 2", 1, 100)
                    end;
                }
                textattribute(Address)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Address := Customer.Address
                    end;
                }
                textattribute(Address2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Address2 := Customer."Address 2"
                    end;
                }
                textattribute(City)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Address2 := Customer.City
                    end;
                }
                textattribute(PostalCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PostalCode := Customer."Post Code"
                    end;
                }
                textattribute(Telephone)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Telephone := Customer."Phone No."
                    end;
                }
                textattribute(Email)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Email := Customer."E-Mail"
                    end;
                }
                textattribute(Risque)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Risque := Customer."Client Risque"
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