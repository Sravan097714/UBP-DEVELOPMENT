codeunit 50005 ReportSelection
{
    trigger OnRun()
    begin
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
    local procedure SubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        // if ReportId = 50006 then

        // NewReportId := Report::"Your Report";

        //ca add other reports same way
    End;
}