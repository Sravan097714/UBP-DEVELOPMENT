report 50012 "Sales Interface"
{
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            trigger OnPreDataItem()
            begin
                FilePath := '\\UBP-PMX-APP-DEV\Interface\SalesInterface.txt';
                CreateFile.CREATE(FilePath);
                CreateFile.CreateOutStream(FileOutstream);
            end;

            trigger OnAfterGetRecord()
            var
                Item: Record Item;
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Get("Document Type", "Document No.");

                if Item.Get("No.") then begin
                    if (Item.Type = Item.Type::"Non-Inventory") then begin
                        CLEAR(TXTLINES);
                        TXTLINES := 'E' + ',' + "Document No." + ',' + "Sell-to Customer No." + ',' + "No." + ',' + format(Quantity)
                        + ',' + Format(SalesHeader."Order Date") + ',' + Format(Time) + ',' + Format("Document No.") + Format("Line No.");
                        FileOutstream.WriteText(TXTLINES);
                        FileOutstream.WriteText();
                    end;
                    if (Item.Type = Item.Type::Service) then begin
                        CLEAR(TXTLINES);
                        TXTLINES := 'D' + ',' + "Document No." + ',' + "No." + ',' + format(Quantity) + ',' + format("Unit of Measure")
                        + ',' + Format("Document No.") + Format("Line No.");
                        FileOutstream.WriteText(TXTLINES);
                        FileOutstream.WriteText();
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                CreateFile.Close();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
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
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        QT: Label '"';
        CreateFile: File;
        FileOutstream: OutStream;
        FilePath: Text;
        TXTLINES: Text;
}