import { api, LightningElement } from 'lwc';


const columns = [
    { label: 'name', fieldName: 'name' },
    { label: 'stockCount', fieldName: 'stockCount' },
    {
        type: 'button',
        typeAttributes: {
            label: 'View',
            name: 'view',
            variant: 'brand'
        }
    }
    
    // { label: 'Phone', fieldName: 'phone', type: 'phone' },
    // { label: 'Balance', fieldName: 'amount', type: 'currency' },
    // { label: 'CloseAt', fieldName: 'closeAt', type: 'date' },
];

export default class ModelPopup extends LightningElement {

    isShowModal = false;

    @api sectionName;
    @api sectionInvData = [];

    

    columns = columns;

    selectedRow = {};

    @api showModalBox() {  
        this.isShowModal = true;
        console.log('model js ----- start');
        
        this.sectionInvData.forEach( (invData) => {
            let name = invData.name;
            let stockCount = invData.stockCount;
            console.log(name, ' ', stockCount);
        })
        console.log('model js ----- end');
    }

    handleDialogClose() {
        this.isShowModal = false;
    }



    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        console.log('row ----> ');
        console.log(row);
        const plainObj = JSON.parse(JSON.stringify(row));
        console.log(plainObj.name);
        if (actionName === 'view') {
            
            const productModel = this.template.querySelector('c-product-details-model-popup');
            if(productModel){
                productModel.selectedProductRow = row;
                productModel.showModalBox();
            }

        }
    }

    
}