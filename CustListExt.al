pageextension 50118 CustListExt extends "Customer List"
{
    actions
    {
        addafter(Email)
        {
            action(ImportRichText)
            {
                ApplicationArea = All;
                Caption = 'Import Rich Text';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ToolTip = 'Import Rich text from a CSV file.';
                trigger OnAction()
                begin
                    Xmlport.Run(Xmlport::"Import Customer Rich Text", false, true);
                end;
            }
        }
    }
}
