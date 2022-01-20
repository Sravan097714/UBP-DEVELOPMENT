codeunit 50001 "Import Files"
{
    trigger OnRun()
    begin
    end;

    procedure ImportPurchaseJnl()
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlBatach: Record "Gen. Journal Batch";
        ExcelBufferRec: Record "Excel Buffer";
        Name: Text;
        Sheetname: Text;
        ImportStream: InStream;
        Rows: Integer;
        LineNo: Integer;
        UploadResult: Boolean;
        RowNo: Integer;
        DocumentNo: Text[10];
        NumberSeriesLinesRec: Record "No. Series Line";
    begin
        ExcelBufferRec.DeleteAll();
        UploadResult := UploadIntoStream('Select file to upload', '', '', Name, ImportStream);
        Sheetname := ExcelBufferRec.SelectSheetsNameStream(ImportStream);

        if Sheetname <> '' then begin
            ExcelBufferRec.OpenBookStream(ImportStream, Sheetname);
            ExcelBufferRec.ReadSheet();
            Rows := ExcelBufferRec."Row No.";

            GenJnlBatach.Get(JournalTemplateName, JournalBatchName);
            GenJnlBatach.TestField("No. Series");

            NumberSeriesLinesRec.Reset();
            NumberSeriesLinesRec.SetRange("Series Code", GenJnlBatach."No. Series");
            if NumberSeriesLinesRec.FindLast() then
                DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            GenJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            GenJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if GenJournalLine.FindLast() then begin
                LineNo += GenJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := JournalBatchName;
                GenJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(GenJournalLine."Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Posting Date");

                Evaluate(GenJournalLine."Document Date", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document Date");

                Evaluate(GenJournalLine."Due Date", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Due Date");
                if GetValueAtIndex(RowNo, 4, ExcelBufferRec) <> '' then begin
                    Evaluate(GenJournalLine."Document No.", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                    GenJournalLine.Validate(GenJournalLine."Document No.");
                end else
                    GenJournalLine.Validate(GenJournalLine."Document No.", DocumentNo);

                Evaluate(GenJournalLine."Document Type", GetValueAtIndex(RowNo, 5, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document Type");

                Evaluate(GenJournalLine."External Document No.", GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."External Document No.");

                Evaluate(GenJournalLine."Account Type", GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account Type");

                Evaluate(GenJournalLine."Account No.", GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account No.");

                Evaluate(GenJournalLine."Gen. Prod. Posting Group", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Gen. Prod. Posting Group");

                Evaluate(GenJournalLine."Gen. Posting Type", GetValueAtIndex(RowNo, 10, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Gen. Posting Type");

                Evaluate(GenJournalLine."VAT Prod. Posting Group", GetValueAtIndex(RowNo, 11, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."VAT Prod. Posting Group");

                Evaluate(GenJournalLine."Currency Code", GetValueAtIndex(RowNo, 12, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Currency Code");

                Evaluate(GenJournalLine.Description, GetValueAtIndex(RowNo, 13, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Description);

                Evaluate(GenJournalLine.Amount, GetValueAtIndex(RowNo, 14, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Amount);

                Evaluate(GenJournalLine."Amount (LCY)", GetValueAtIndex(RowNo, 15, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Amount (LCY)");

                Evaluate(GenJournalLine."VAT Amount", GetValueAtIndex(RowNo, 16, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."VAT Amount");


                Evaluate(GenJournalLine."Bal. Account Type", GetValueAtIndex(RowNo, 17, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");

                Evaluate(GenJournalLine."Bal. Account No.", GetValueAtIndex(RowNo, 18, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");

                Evaluate(GenJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 19, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");

                Evaluate(GenJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 20, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");



                GenJournalLine.Insert();
                LineNo := LineNo + 10000;
                DocumentNo := IncStr(DocumentNo);
            end;
            Message('Import Completed');
        end;
    end;

    procedure ImportGenJnlFile()
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJnlBatach: Record "Gen. Journal Batch";
        ExcelBufferRec: Record "Excel Buffer";
        Name: Text;
        Sheetname: Text;
        ImportStream: InStream;
        Rows: Integer;
        LineNo: Integer;
        UploadResult: Boolean;
        RowNo: Integer;
        DocumentNo: Text[10];
        NumberSeriesLinesRec: Record "No. Series Line";
    //Coloums: Integer;
    begin
        ExcelBufferRec.DeleteAll();
        UploadResult := UploadIntoStream('Select file to upload', '', '', Name, ImportStream);
        if not UploadResult then
            exit;
        Sheetname := ExcelBufferRec.SelectSheetsNameStream(ImportStream);

        if Sheetname <> '' then begin
            ExcelBufferRec.OpenBookStream(ImportStream, Sheetname);
            ExcelBufferRec.ReadSheet();
            Rows := ExcelBufferRec."Row No.";

            GenJnlBatach.Get(JournalTemplateName, JournalBatchName);
            GenJnlBatach.TestField("No. Series");

            NumberSeriesLinesRec.Reset();
            NumberSeriesLinesRec.SetRange("Series Code", GenJnlBatach."No. Series");
            if NumberSeriesLinesRec.FindLast() then
                DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            GenJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            GenJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if GenJournalLine.FindLast() then begin
                LineNo += GenJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := JournalBatchName;
                GenJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(GenJournalLine."Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Posting Date");

                if GetValueAtIndex(RowNo, 2, ExcelBufferRec) <> '' then begin
                    Evaluate(GenJournalLine."Document No.", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                    GenJournalLine.Validate(GenJournalLine."Document No.");
                end else
                    GenJournalLine.Validate(GenJournalLine."Document No.", DocumentNo);

                Evaluate(GenJournalLine."Account Type", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account Type");

                Evaluate(GenJournalLine."Account No.", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account No.");

                Evaluate(GenJournalLine.Description, GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Description);

                Evaluate(GenJournalLine."Currency Code", GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Currency Code");

                Evaluate(GenJournalLine.Amount, GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Amount);

                Evaluate(GenJournalLine."Bal. Account Type", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");

                Evaluate(GenJournalLine."Bal. Account No.", GetValueAtIndex(RowNo, 10, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");

                Evaluate(GenJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 11, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");

                Evaluate(GenJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 12, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                GenJournalLine.Insert();
                LineNo := LineNo + 10000;
                DocumentNo := IncStr(DocumentNo);
            end;
            Message('Import Completed');
        end;
    end;

    procedure ImportItemJnlFile()
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlBatch: Record "Item Journal Batch";
        ExcelBufferRec: Record "Excel Buffer";
        Name: Text;
        Sheetname: Text;
        ImportStream: InStream;
        Rows: Integer;
        LineNo: Integer;
        UploadResult: Boolean;
        RowNo: Integer;
        DocumentNo: Text[10];
        NumberSeriesLinesRec: Record "No. Series Line";
    //Coloums: Integer;
    begin
        ExcelBufferRec.DeleteAll();
        UploadResult := UploadIntoStream('Select file to upload', '', '', Name, ImportStream);
        if not UploadResult then
            exit;
        Sheetname := ExcelBufferRec.SelectSheetsNameStream(ImportStream);

        if Sheetname <> '' then begin
            ExcelBufferRec.OpenBookStream(ImportStream, Sheetname);
            ExcelBufferRec.ReadSheet();
            Rows := ExcelBufferRec."Row No.";

            ItemJnlBatch.Get(JournalTemplateName, JournalBatchName);
            ItemJnlBatch.TestField("No. Series");

            NumberSeriesLinesRec.Reset();
            NumberSeriesLinesRec.SetRange("Series Code", ItemJnlBatch."No. Series");
            if NumberSeriesLinesRec.FindLast() then
                DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            ItemJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            ItemJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if ItemJournalLine.FindLast() then begin
                LineNo += ItemJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                ItemJournalLine."Line No." := LineNo;
                ItemJournalLine."Journal Batch Name" := JournalBatchName;
                ItemJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(ItemJournalLine."Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Posting Date");

                Evaluate(ItemJournalLine."Entry Type", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Entry Type");

                if GetValueAtIndex(RowNo, 3, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine."Document No.", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine."Document No.");
                end else
                    ItemJournalLine.Validate(ItemJournalLine."Document No.", DocumentNo);

                Evaluate(ItemJournalLine."Item No.", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Item No.");

                if GetValueAtIndex(RowNo, 5, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine.Description, GetValueAtIndex(RowNo, 5, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine.Description);
                end;

                Evaluate(ItemJournalLine."Location Code", GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Location Code");

                if GetValueAtIndex(RowNo, 7, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine.Quantity, GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine.Quantity);
                end;
                Evaluate(ItemJournalLine."Unit of Measure Code", GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Unit of Measure Code");

                if GetValueAtIndex(RowNo, 9, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine."Unit Amount", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine."Unit Amount");
                end;

                if GetValueAtIndex(RowNo, 10, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine.Amount, GetValueAtIndex(RowNo, 10, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine.Amount);
                end;

                if GetValueAtIndex(RowNo, 11, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine."Discount Amount", GetValueAtIndex(RowNo, 11, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine."Discount Amount");
                end;

                if GetValueAtIndex(RowNo, 12, ExcelBufferRec) <> '' then begin
                    Evaluate(ItemJournalLine."Unit Cost", GetValueAtIndex(RowNo, 12, ExcelBufferRec));
                    ItemJournalLine.Validate(ItemJournalLine."Unit Cost");
                end;

                Evaluate(ItemJournalLine."Gen. Prod. Posting Group", GetValueAtIndex(RowNo, 13, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Gen. Prod. Posting Group");

                Evaluate(ItemJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 14, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Shortcut Dimension 1 Code");

                Evaluate(ItemJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 15, ExcelBufferRec));
                ItemJournalLine.Validate(ItemJournalLine."Shortcut Dimension 2 Code");

                ItemJournalLine.Insert();
                LineNo := LineNo + 10000;
                DocumentNo := IncStr(DocumentNo);
            end;
            Message('Import Completed');
        end;
    end;

    procedure SetJournalTemplateBatch(Template: Code[10]; Batch: Code[10])
    begin
        JournalTemplateName := Template;
        JournalBatchName := Batch;
    end;

    var
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];

    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer; ExcelBufferRec: Record "Excel Buffer"): Text
    begin
        ExcelBufferRec.Reset();
        If ExcelBufferRec.Get(RowNo, ColNo) then
            exit(ExcelBufferRec."Cell Value as Text");

    end;
}