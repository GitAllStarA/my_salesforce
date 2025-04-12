import {api, LightningElement } from 'lwc';

export default class ProductDetailsModelPopup extends LightningElement {

    isShowModal = false;

    @api selectedProductRow = {};

    @api showModalBox() {  
        if(this.selectedProductRow){
            this.isShowModal = true;
            const productModel = this.template.querySelector('c-model-popup');
            
            if(productModel) {
                productModel.style.display = 'none';
            }

            console.log('called product details model')
        }
    }

    handleDialogClose() {
        this.isShowModal = false;
        const productModel = this.template.querySelector('c-model-popup');
            
            if(productModel) {
                productModel.style.display = 'block';
            }
    }


    get formattedData() {
        console.log('formatted data form product details model')
        console.log('stringfy -- json');
        return JSON.stringify(this.selectedProductRow,null,2);
      }


      get ObjectProp() {
        Object.entries(this.selectedProductRow).map(([Keyt,val])=> ({Keyt,val}));
      }
}