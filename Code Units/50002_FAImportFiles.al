codeunit 50002 "FA Import Files"
{
    trigger OnRun()
    begin
    end;

    procedure ImportFAJnl()
    var
        FAJournalLine: Record "FA Journal Line";
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

            NumberSeriesLinesRec.SetRange("Series Code", 'GEN');
            if NumberSeriesLinesRec.FindLast() then DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            FAJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            FAJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if FAJournalLine.FindLast() then begin
                LineNo += FAJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                FAJournalLine."Line No." := LineNo;
                FAJournalLine."Journal Batch Name" := JournalBatchName;
                FAJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(FAJournalLine."FA Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."FA Posting Date");

                Evaluate(FAJournalLine."Document Type", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Document Type");

                Evaluate(FAJournalLine."Document No.", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Document No.");

                Evaluate(FAJournalLine."FA No.", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."FA No.");

                Evaluate(FAJournalLine."Depreciation Book Code", GetValueAtIndex(RowNo, 5, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Depreciation Book Code");

                Evaluate(FAJournalLine."FA Posting Type", GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."FA Posting Type");

                Evaluate(FAJournalLine.Description, GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine.Description);

                Evaluate(FAJournalLine.Amount, GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine.Amount);

                Evaluate(FAJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Shortcut Dimension 1 Code");

                Evaluate(FAJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 10, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Shortcut Dimension 2 Code");

                FAJournalLine.Insert();
                LineNo := LineNo + 10000;
                DocumentNo := IncStr(DocumentNo);
            end;
            Message('Import Completed');
        end;
    end;

    procedure ImportGenJnlFile()
    var
        FAJournalLine: Record "FA Journal Line";
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
        Sheetname := ExcelBufferRec.SelectSheetsNameStream(ImportStream);

        if Sheetname <> '' then begin
            ExcelBufferRec.OpenBookStream(ImportStream, Sheetname);
            ExcelBufferRec.ReadSheet();
            Rows := ExcelBufferRec."Row No.";

            NumberSeriesLinesRec.SetRange("Series Code", 'GEN');
            if NumberSeriesLinesRec.FindLast() then DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            FAJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            FAJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if FAJournalLine.FindLast() then begin
                LineNo += FAJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                FAJournalLine."Line No." := LineNo;
                FAJournalLine."Journal Batch Name" := JournalBatchName;
                FAJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(FAJournalLine."Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Posting Date");

                Evaluate(FAJournalLine."Document No.", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Document No.");

                Evaluate(FAJournalLine."FA No.", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."FA No.");

                Evaluate(FAJournalLine."Depreciation Book Code", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Depreciation Book Code");

                Evaluate(FAJournalLine."FA Posting Type", GetValueAtIndex(RowNo, 5, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."FA Posting Type");

                Evaluate(FAJournalLine.Description, GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine.Description);

                Evaluate(FAJournalLine.Amount, GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine.Amount);

                Evaluate(FAJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Shortcut Dimension 1 Code");

                Evaluate(FAJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                FAJournalLine.Validate(FAJournalLine."Shortcut Dimension 2 Code");

                FAJournalLine.Insert();
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