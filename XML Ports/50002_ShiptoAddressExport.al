xmlport 50002 "Export ShipTo Address"
{
    Direction = Export;
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(SalesHeader; "Sales Header")
            {
                textattribute(CustomerNo)
                {
                    trigger OnBeforePassVariable()
                    begin
                        CustomerNo := SalesHeader."Sell-to Customer No."
                    end;
                }
                textattribute(ShippingCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        ShippingCode := SalesHeader."Shipment Method Code";
                    end;
                }
                textattribute(ShippingDescription)
                {
                    trigger OnBeforePassVariable()
                    var
                        ShipmentMethod: Record "Shipment Method";
                    begin
                        if ShipmentMethod.Get(SalesHeader."Shipment Method Code") then
                            ShippingDescription := ShipmentMethod.Description
                    end;
                }
                textattribute(Address)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Address := SalesHeader."Ship-to Address";
                    end;
                }
                textattribute(Address2)
                {
                    trigger OnBeforePassVariable()
                    begin
                        Address2 := SalesHeader."Ship-to Address 2"
                    end;
                }
                textattribute(City)
                {
                    trigger OnBeforePassVariable()
                    begin
                        City := SalesHeader."Ship-to City"
                    end;
                }
                textattribute(PostalCode)
                {
                    trigger OnBeforePassVariable()
                    begin
                        PostalCode := SalesHeader."Ship-to Post Code";
                    end;
                }
                textattribute(Telephone)
                {
                    trigger OnBeforePassVariable()
                    begin
                        //Telephone := SalesHeader.ship
                    end;
                }
                textattribute(Email)
                {
                    trigger OnBeforePassVariable()
                    begin
                        //Email := Customer."E-Mail"
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