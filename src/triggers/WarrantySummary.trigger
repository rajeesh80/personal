trigger WarrantySummary on Case (before insert) {
    for(Case myCase:Trigger.new){
        String purchaseDate         =   myCase.Product_Purchase_Date__c.format();
        String createdDate      =   DateTime.now().format();//myCase.CreatedDate;
        Integer warrantyDays        =   myCase.Product_Total_Warranty_Days__c.intValue();
        //Decimal warrantyPercentage    =   (Date.today() - purchaseDate) / warrantyDays;   
        Decimal warrantyPercentage  =   (100*(myCase.Product_Purchase_Date__c.daysBetween(Date.today()) / myCase.Product_Total_Warranty_Days__c)).setScale(2);  
        Boolean hasExtendedWarranty =   myCase.Product_Has_Extended_Warranty__c;
        String endingStatement      =   'Have a nice day!';
        myCase.Warranty_Summary__c  =   'Product Purchase on' + purchaseDate + ' '
                                    +   'and case created on' + createdDate  + ' '  
                                    +   'Warranty is for '    + warrantyDays + ' '
                                    +   'and is '             + warrantyPercentage + '% through its warranty period.\n'
                                    +   'Extended warranty:'  + hasExtendedWarranty + '\n'
                                    +   endingStatement;                

    }                               
}