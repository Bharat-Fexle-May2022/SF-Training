import { LightningElement, track } from 'lwc';

import getTextMethod1 from '@salesforce/apex/ContactController.getTextMethod1';
import getTextMethod2 from '@salesforce/apex/ContactController.getTextMethod2';
import getTextMethod3 from '@salesforce/apex/ContactController.getTextMethod3';

export default class RenderMultipleHTMLTemplates extends LightningElement {

    @track message1 = "";
    @track message2 = "";
    @track message3 = "";

    handleClickMe() {
        this.invokeApexMethods();
    }

    invokeApexMethods() {
        getTextMethod1()
        .then((result1) => {
            this.message1 = ('Method1 result: ' + result1);
 
            getTextMethod2()
            .then((result2) => {
                this.message2 = ('Method2 result: ' + result1 + ' ' + result2);

                getTextMethod3()
                .then((result3) => {
                    this.message3 = ('Method3 result: ' + result1 + ' ' + result2 + ' ' + result3);
                })
                .catch((error => {
                    console.log(error);
                }));
            })
            .catch((error => {
                console.log(error);
            }));
        })
        .catch((error) => {
            console.log(error);
        })
    }
}