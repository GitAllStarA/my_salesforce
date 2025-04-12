import { LightningElement, track, wire } from 'lwc';
import fetchExternalDataById from '@salesforce/apex/ApiCalls.callMyStoreModel';
import { publish, MessageContext } from 'lightning/messageService';
import COMPONENT_PUB_SUB from '@salesforce/messageChannel/ComponentPubSub__c';

export default class Jsonviewer extends LightningElement {
    //data;
    error;
    id = '';
    myStore;

    storeInfo = '';
    @track inventoryData = '';
    layoutData = '';

    @wire(MessageContext)
    messageContext;

    handleProductJson() {
        if (this.inventoryData.length > 0) {
            console.log('handleBillingPeripheralStatus --- start');
            this.handleBillingPeripheralStatus(this.inventoryData);
            console.log('handleBillingPeripheralStatus ---- end');
        }
        console.log('handleProductJson start');
        const msgInput = this.template.querySelector(".pingEinstein").value;
        const payload = {
            message: msgInput,
            billing: this.billingPeripherals,
        };
        console.log('publish');
        console.log(payload.message);
        console.log(JSON.parse(JSON.stringify(payload.billing)));
        publish(this.messageContext, COMPONENT_PUB_SUB, payload);
        this.handleBillingPeripheralLMSUpdate();
        console.log('handleProductJson end');
    }

    billingPeripherals = [];

    handleBillingPeripheralLMSUpdate() {
        console.log('device data cleared');
        if(this.billingPeripherals.length > 0){
            this.billingPeripherals = [];
        }
    }

    handleBillingPeripheralStatus(data) {
        try {
            
                data.forEach((invData) => {
                    if (invData.category.toLowerCase() == 'billing') {
                        console.log('adding billing peripherals')
                        this.billingPeripherals.push(invData);

                    }
                })
                if (this.billingPeripherals.length > 0) {
                    console.log('added billing data')
                }
           
        } catch (error) {
            console.log(error)
        }
    }

    handleIdChange(event) {
        console.log('handleIdChange id value :: ' + event.target.value);
        this.id = event.target.value;
    }

    connectedCallback() {
        this.template.addEventListener('click', (event) => {
            if (event.target.classList.contains('section')) {
                this.handleShowSectionModel(event.target.textContent.trim());
                console.log("Clicked Section:", event.target.textContent.trim());
            }
            else {
                console.log("please input the id value and search");
            }
        });

    }

    inventorySplitHandler(dataStr) {
        try {
            console.log('splitResult start ---------- ');
            if (dataStr == null || dataStr == '' || dataStr == undefined) {
                console.log('dataStr  is null or undefined');
                console.log('splitResult end --------------');
                return [];
            }
            let splitResult = dataStr.toLowerCase().split(' ');
            console.log(splitResult);
            console.log('splitResult end --------------');

            return splitResult;
        } catch (error) {
            console.log('splitResult error ---------- ');

            console.error(error);
        }
    }

    handleShowSectionModel(selectedSectionNameOnStore) {
        let findSectionNameLikeKey = this.inventorySplitHandler(selectedSectionNameOnStore.toLowerCase());

        const model = this.template.querySelector('c-model-popup');
        if (model) {
            console.log('model start its present');
            model.sectionName = selectedSectionNameOnStore;
            let sectionArray = [];
            if (this.inventoryData) {
                console.log('------------------------------');
                console.log(this.inventoryData);
                console.log('------------------------------');
                this.inventoryData.forEach((invData) => {

                    let invDataBrand = invData.brand.toLowerCase();
                    let invDataCategory = invData.category.toLowerCase();

                    //brand - smart phones & tablets
                    if (findSectionNameLikeKey.includes(invDataBrand) || findSectionNameLikeKey.includes(invDataCategory)) {
                        /*let name = invData.name;
                        let stockCount = invData.stockCount;
                        let sales = invData.sales;
                        let obj = {
                            'name': name,
                            'stockCount': stockCount,
                            'sales': sales,
                        };*/
                        let obj = JSON.parse(JSON.stringify(invData));
                        console.log(obj.name);
                        console.log(sectionArray);
                        sectionArray.push(obj);
                    }

                    //Accessories 
                    else if (findSectionNameLikeKey.includes(invDataCategory)) {
                        /*let name = invData.name;
                        let stockCount = invData.stockCount;
                        let sales = invData.sales;
                        let obj = {
                            'name': name,
                            'stockCount': stockCount,
                            'sales': sales,
                        };*/
                        let obj = JSON.parse(JSON.stringify(invData));
                        console.log(obj.name);
                        console.log(sectionArray);
                        sectionArray.push(obj);
                    }


                })
                model.sectionInvData = sectionArray;
            } else {
                console.log('inventory data not present to match');
            }
            console.log('sectionName:', selectedSectionNameOnStore);
            console.log('model:', model.sectionInvData);
            model.showModalBox();
            console.log('model end')
        } else {
            console.log('not present');
        }
    }

    handleOnCloseModel() {
        const model = this.template.querySelector('c-model-popup');
        model.handleDialogClose();
    }

    async handleSearchData() {
        try {
            console.log(this.id);
            this.myStore = await fetchExternalDataById({ id: this.id });

            if (this.myStore) {
                try {
                    this.myStore = JSON.parse(this.myStore);
                    this.createLayout(this.myStore);
                } catch (error) {
                    console.error(error);
                }
            } else {
                console.log('unable to parse store data');
            }
        } catch (error) {
            this.error = error;
            this.myStore = undefined;
        }
    }

    get storeDetails() {
        return this.myStore ? 'data present' : '';
    }

    createLayout(myStoreData) {
        const storeMapInner = this.template.querySelector(".store-map-inner");
        const sections = {};


        if (!storeMapInner) {
            console.log('store-map-inner not found');
            return;
        }

        if (storeMapInner.innerHTML) {
            console.log('store map html clearing');
            storeMapInner.innerHTML = '';
            console.log('store map html cleared');
        }
        let set = new Set();
        if (storeMapInner) {
            // const detailsPanel = this.template.querySelector(".details-panel");
            // const itemTitle = this.template.querySelector(".item-title");
            // const itemDescription = this.template.querySelector(".item-description");
            try {
                if (myStoreData.payload == undefined) {
                    console.log('no payload, check the mulesoft and apex call outs');
                }
            } catch (error) {
                console.log(error);
            }

            this.storeInfo = myStoreData["0"].payload; // details of a single store based of id
            this.inventoryData = myStoreData["1"].payload; // details of a single store with addtional details like inventory and sales, based of id
            this.layoutData = myStoreData["2"].payload; // store map data contains postions of each section in store

            console.log('layoutData');
            console.log(this.layoutData);

            console.log('inventoryData');
            console.log(this.inventoryData);

            const grid = {};
            this.layoutData.forEach((sectionData) => {
                if (!set.has(sectionData.sectionName) && sectionData.sectionName !== undefined && sectionData.sectionName !== null && sectionData.sectionName !== '' && sectionData.sectionName.length > 1) {
                    set.add(sectionData.sectionName);
                    const section = document.createElement('div');
                    section.classList.add('section');
                    section.textContent = sectionData.sectionName;


                    let rowStart, colStart, rowEnd, colEnd;
                    let validPlacement = false;
                    //console.log(sectionData.sectionName);


                    // Try random placements until a valid one is found
                    for (let attempts = 0; attempts < 100; attempts++) {
                        // Limit attempts to prevent infinite loop
                        rowStart = Math.floor(Math.random() * 5) + 1; //1
                        colStart = Math.floor(Math.random() * 6) + 1; //2
                        rowEnd = Math.min(
                            rowStart + Math.floor(Math.random() * 3) + 1,
                            6
                        ); //5
                        colEnd = Math.min(
                            colStart + Math.floor(Math.random() * 4) + 1,
                            7
                        ); //6

                        validPlacement = true;

                        // Check for overlaps
                        for (let r = rowStart; r < rowEnd; r++) {
                            for (let c = colStart; c < colEnd; c++) {
                                if (grid[`${r}-${c}`]) {
                                    // Cell is occupied
                                    validPlacement = false;
                                    break; // Exit inner loop
                                }
                            }
                            if (!validPlacement) {
                                break;
                            } // Exit outer loop
                        }

                        if (validPlacement) {
                            break;
                        } // Exit loop if a valid placement is found

                        /*console.log(
                            "new area reset points for storemap ",
                            rowStart,
                            colStart,
                            rowEnd,
                            colEnd
                        );*/
                    }

                    if (!validPlacement) {
                        console.warn(
                            `Could not find a valid placement for ${sectionData.sectionName} after 100 attempts.`
                        );
                        return; // Skip this section if no placement found
                    }

                    // Mark grid cells as occupied
                    for (let r = rowStart; r < rowEnd; r++) {
                        for (let c = colStart; c < colEnd; c++) {
                            grid[`${r}-${c}`] = true;
                        }
                    }

                    section.style.gridArea = `${rowStart} / ${colStart} / ${rowEnd} / ${colEnd}`;
                    section.style.backgroundColor = this.getRandomColor();
                    console.log('added eventlistener');
                    storeMapInner.appendChild(section);
                    sections[sectionData.sectionName] = section;

                } else {
                    console.log('set have section name, so skip section creation');
                    console.log('skip sectionData.sectionName:', sectionData.sectionName);
                }
            })
        } else {
            console.log('store-map-inner not found')
        }


        /* this.layoutData.forEach((itemData) => {
             const sectionName = itemData.category; // Or get category from JSON
             const section = sections[sectionName];
 
             if (section) {
                 // Only add if section exists
                 const item = document.createElement("div");
                 item.classList.add("item");
                 item.dataset.itemName = itemData.name;
                 item.innerHTML = `<span>${itemData.name}</span>`; // Tooltip
                 item.addEventListener("click", () => this.showDetails(itemData));
                 const icon = document.createElement("span"); // Create the icon element
                 icon.textContent = this.getIconForItem(itemData.category); // Function to get icon
                 //item.prepend(icon); // Add the icon before the name
 
                 section.appendChild(item);
             }
         });*/

        console.log('done');
        console.log('section added on layout :: :: ', set);
    }


    getRandomColor() {
        const r = Math.floor(Math.random() * 256);
        const g = Math.floor(Math.random() * 256);
        const b = Math.floor(Math.random() * 256);
        return `rgba(${r}, ${g}, ${b}, 0.3)`; // Add some transparency
    }

    showDetails(itemData) {
        detailsPanel.style.display = "block";
        itemTitle.textContent = itemData.name;
        itemDescription.textContent =
            itemData.specifications || "Details not available";
    }

    getIconForItem(category) {
        switch (category) {
            case "iPhone":
            case "Android":
            case "Unlocked":
                return "📱";
            case "Accessories":
                return "🎧"; // Or ⌚, 🔋, 🔌, etc.
            default:
                return ""; // Default icon or empty
        }
    }

}