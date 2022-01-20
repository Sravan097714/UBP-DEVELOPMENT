report 50084 "VAT Return Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\Layout\VATReturnReport.rdl';
    Caption = 'RC-VAT Return Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            //DataItemTableView = WHERE(Type = FILTER('Sale'));
            RequestFilterFields = "Posting Date";
            column(CompanyName; COMPANYNAME)
            {
            }
            column(compadd1; compadd1) { }
            column(compadd2; compadd2) { }
            column(compadd3; compadd3) { }

            column(Filter1_VatEntry; TABLECAPTION + ': ' + VATEntryFilter)
            {
            }
            column(MinVatDifference; MinVATDifference)
            {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
            }
            column(MinVatDiffText; MinVATDiffText)
            {
            }
            column(AddCurrAmt_VatEntry; AddCurrAmtTxt)
            {
            }
            column(PostingDate_VatEntry; FORMAT("Posting Date"))
            {
            }
            column(DocumentType_VatEntry; "Document Type")
            {
            }
            column(DocumentNo_VatEntry; "Document No.")
            {
                IncludeCaption = true;
            }
            column(Type_VatEntry; Type)
            {
                IncludeCaption = true;
            }
            column(GenBusPostGrp_VatEntry; "Gen. Bus. Posting Group")
            {
            }
            column(GenProdPostGrp_VatEntry; "Gen. Prod. Posting Group")
            {
            }
            column(VATProdPostingGrp_VatEntry; "VAT Prod. Posting Group")
            {
            }
            column(Base_VatEntry; Base)
            {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                IncludeCaption = true;
            }
            column(Amount_VatEntry; Amount)
            {
                AutoFormatExpression = GetCurrency;
                AutoFormatType = 1;
                IncludeCaption = true;
            }
            column(VatCalType_VatEntry; "VAT Calculation Type")
            {
            }
            column(BillToPay_VatEntry; "Bill-to/Pay-to No.")
            {
                IncludeCaption = true;
            }
            column(Eu3PartyTrade_VatEntry; FORMAT("EU 3-Party Trade"))
            {
            }
            column(FormatClosed; FORMAT(Closed))
            {
            }
            column(EntrtyNo_VatEntry; "Entry No.")
            {
                IncludeCaption = true;
            }
            column(VatDiff_VatEntry; "VAT Difference")
            {
                IncludeCaption = true;
            }
            column(VATExceptionsCaption; VATExceptionsCaptionLbl)
            {
            }
            column(CurrReportPageNoOCaption; CurrReportPageNoOCaptionLbl)
            {
            }
            column(FORMATEU3PartyTradeCap; FORMATEU3PartyTradeCapLbl)
            {
            }
            column(FORMATClosedCaption; FORMATClosedCaptionLbl)
            {
            }
            column(VATEntryVATCalcTypeCap; VATEntryVATCalcTypeCapLbl)
            {
            }
            column(GenProdPostingGrpCaption; GenProdPostingGrpCaptionLbl)
            {
            }
            column(GenBusPostingGrpCaption; GenBusPostingGrpCaptionLbl)
            {
            }
            column(DocumentTypeCaption; DocumentTypeCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(VatRate; VATRate)
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(Description; SalesDesc)
            {
            }
            column(TaxableAmt; "VAT Entry".Base)
            {
            }
            column(GrossAmt; Base + Amount)
            {
            }
            column(VATAmt; "VAT Entry".Amount)
            {
            }
            column(VATAmtMur; "VAT Entry"."Additional-Currency Amount")
            {
            }
            column(BaseAmtMur; "VAT Entry"."Additional-Currency Base")
            {
            }
            column(AmtInclVatMur; "VAT Entry"."Additional-Currency Base" + "VAT Entry"."Additional-Currency Amount")
            {
            }
            column(DateFrom; DateFrom)
            {
            }
            column(DateTo; DateTo)
            {
            }
            column(VATBusPostingGroup_VATEntry; "VAT Entry"."VAT Bus. Posting Group")
            {
            }
            column(VATRegNo; VATRegNo)
            {
            }
            column(BRN; BRN)
            {

            }
            column(VATAmount1; VATAmount[1]) { }
            column(VATAmount2; VATAmount[2]) { }
            column(VATAmount3; VATAmount[3]) { }
            column(VATAmount4; VATAmount[4]) { }
            column(VATAmount5; VATAmount[5]) { }
            column(VATAmount6; VATAmount[6]) { }
            column(VATAmount7; VATAmount[7]) { }
            column(VATAmount8; VATAmount[8]) { }
            column(VATAmount9; VATAmount[9]) { }
            column(VATAmount10; VATAmount[10]) { }
            column(VATAmount11; VATAmount[11]) { }
            column(VATAmount12; VATAmount[12]) { }
            column(VATAmount13; VATAmount[13]) { }
            column(VATAmount14; VATAmount[14]) { }
            column(VATAmount15; VATAmount[15]) { }

            column(VATAmount16; VATAmount[16]) { }






            column(External_Document_No_; "External Document No.") { }

            trigger OnAfterGetRecord()
            var
                companyinformationrec: Record "Company Information";
            begin
                companyinformationrec.Reset();
                companyinformationrec.SetRange(Name, CompanyName);
                if companyinformationrec.FindFirst
                then begin
                    compadd1 := companyinformationrec.Address;
                    compadd2 := companyinformationrec."Address 2";
                    compadd3 := companyinformationrec.City;
                end;
                //Added Codes//
                if "VAT Entry"."VAT Prod. Posting Group" = 'ZERO 1.1'
                then
                    VATAmount[1] += "VAT Entry".Amount;

                if "VAT Entry"."VAT Prod. Posting Group" = 'ZERO 1.2'
                then
                    VATAmount[2] += "VAT Entry".Amount;

                if "VAT Entry"."VAT Prod. Posting Group" = 'ZERO 1.3'
                then
                    VATAmount[3] += "VAT Entry".Amount;

                if "VAT Entry"."VAT Prod. Posting Group" = 'OTHER 1.4' then begin
                    VATAmount[4] += "VAT Entry".Amount;
                    VATAmount[16] += "VAT Entry".Amount;

                end;



                if "VAT Entry"."VAT Prod. Posting Group" = 'DEFERRED 2.0'
                then
                    VATAmount[5] += "VAT Entry".Amount;

                if "VAT Entry"."VAT Prod. Posting Group" = 'EXEMPT 3'
                then
                    VATAmount[6] += "VAT Entry".Amount;

                if "VAT Entry"."VAT Prod. Posting Group" = 'CAP 6.1'
                then
                    VATAmount[7] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'ZERO 6.2'
                then
                    VATAmount[8] += "VAT Entry".Amount;

                if "VAT Entry"."VAT Prod. Posting Group" = 'OTHER 6.3'
                then
                    VATAmount[9] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'CAP 6.4'
                then
                    VATAmount[10] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'ZERO 6.5'
                then
                    VATAmount[11] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'OTHER 6.6'
                then
                    VATAmount[12] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'TAXABLE 7'
                then
                    VATAmount[13] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'IMPORT 8.1'
                then
                    VATAmount[14] += "VAT Entry".Amount;
                if "VAT Entry"."VAT Prod. Posting Group" = 'GOODS 8.2'
                then
                    VATAmount[15] += "VAT Entry".Amount;
            end;

            trigger OnPreDataItem()
            begin
                /* IF UseAmtsInAddCurr THEN
                    SETFILTER("Add.-Curr. VAT Difference", '<=%1|>=%2', -ABS(MinVATDifference), ABS(MinVATDifference))
                ELSE
                    SETFILTER("VAT Difference", '<=%1|>=%2', -ABS(MinVATDifference), ABS(MinVATDifference)); */

                //EIS-YB-001
                //"VAT Entry".SETFILTER("VAT Entry"."Posting Date",'>=%1',DateFrom);
                //"VAT Entry".SETFILTER("VAT Entry"."Posting Date",'<=%1',DateTo);
                "VAT Entry".SETRANGE("VAT Entry"."Posting Date", DateFrom, DateTo);
                //EIS-YB-001
                CLEAR(VATRegNo);
            end;


        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AmountsInAddReportingCurrency; UseAmtsInAddCurr)
                    {
                        Caption = 'Show Amounts in Add. Reporting Currency';
                        MultiLine = true;
                        //ApplicationArea = All;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        Caption = 'Include Reversed Entries';
                        //ApplicationArea = All;
                    }
                    field(MinVATDifference; MinVATDifference)
                    {
                        AutoFormatExpression = GetCurrency;
                        AutoFormatType = 1;
                        Caption = 'Min. VAT Difference';
                        //ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            MinVATDifference := ABS(ROUND(MinVATDifference));
                        end;
                    }
                    field(DateFrom; DateFrom)
                    {
                        Caption = 'From';
                        ApplicationArea = All;
                    }
                    field(DateTo; DateTo)
                    {
                        Caption = 'To';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GLSetup.GET;
        VATEntryFilter := "VAT Entry".GETFILTERS;
        IF UseAmtsInAddCurr THEN
            AddCurrAmtTxt := STRSUBSTNO(Text000, GLSetup."Additional Reporting Currency");
        MinVATDiffText := STRSUBSTNO(Text001, "VAT Entry".FIELDCAPTION("VAT Difference"));
    end;

    var
        Text000: Label 'Amounts are shown in %1.';
        Text001: Label 'Show %1 equal to or greater than';
        VATExceptionsCaptionLbl: Label 'VAT Exceptions';
        CurrReportPageNoOCaptionLbl: Label 'Page';
        FORMATEU3PartyTradeCapLbl: Label 'EU 3-Party Trade';
        FORMATClosedCaptionLbl: Label 'Closed';
        VATEntryVATCalcTypeCapLbl: Label 'VAT Calculation Type';
        GenProdPostingGrpCaptionLbl: Label 'Gen. Prod. Posting Group';
        GenBusPostingGrpCaptionLbl: Label 'Gen. Bus. Posting Group';
        DocumentTypeCaptionLbl: Label 'Document Type';
        PostingDateCaptionLbl: Label 'Posting Date';
        GLSetup: Record "General Ledger Setup";
        VATEntryFilter: Text[250];
        UseAmtsInAddCurr: Boolean;
        AddCurrAmtTxt: Text[50];
        MinVATDifference: Decimal;
        MinVATDiffText: Text[250];
        PrintReversedEntries: Boolean;
        Vat: Record "VAT Posting Setup";
        VATRate: Decimal;
        DateFrom: Date;
        DateTo: Date;
        Customer: Record Customer;
        CustomerName: Text[250];
        SalesInv: Record "Sales Invoice Line";
        SalesDesc: Text[100];
        VATAmt: Decimal;
        VATRegNo: Code[50];
        BRN: Text[20];
        GLEntry: Record "G/L Entry";
        compadd1: Text[50];
        compadd2: Text[50];
        compadd3: Text[50];

        VATAmount: array[100] of Decimal;
        ZERO12: array[2] of Decimal;
        ZERO13: array[2] of Decimal;
        other14: array[2] of Decimal;
        deferred20: array[2] of Decimal;
        exempt3: array[2] of Decimal;
        cap61: array[2] of Decimal;
        zero62: array[2] of Decimal;
        other63: array[2] of Decimal;
        cap64: array[2] of Decimal;
        zero65: array[2] of Decimal;
        other66: array[2] of Decimal;
        taxable7: array[2] of Decimal;
        import81: array[2] of Decimal;
        goods82: array[2] of Decimal;




    local procedure GetCurrency(): Code[10]
    begin
        IF UseAmtsInAddCurr THEN
            EXIT(GLSetup."Additional Reporting Currency");

        EXIT('');
    end;

    procedure InitializeRequest(NewUseAmtsInAddCurr: Boolean; NewPrintReversedEntries: Boolean; NewMinVATDifference: Decimal)
    begin
        UseAmtsInAddCurr := NewUseAmtsInAddCurr;
        PrintReversedEntries := NewPrintReversedEntries;
        MinVATDifference := ABS(ROUND(NewMinVATDifference));
    end;
}

