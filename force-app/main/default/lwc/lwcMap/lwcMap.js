import { LightningElement } from 'lwc';

export default class LwcMap extends LightningElement {
    mapMarkers;

    mapMarkers = [{
        location: {
            City: 'San Francisco',
            Country: 'USA',
            PostalCode: '94105',
            State: 'CA',
            Street: 'The Landmark @ One Market, Suite 300',
        },
        value: 'location001',
        title: 'The Landmark Building',
        description:
            'The Landmark is considered to be one of the city&#39;s most architecturally distinct and historic properties', //escape the apostrophe in the string using &#39;
        icon: 'standard:account',
    }
        ,
    {
        location: {
            City: "Hutto",
            Country: "USA",
            State: "TX",
            Street: "504 windy reed road",
            PostalCode: "78634",
        },
        title: "salesforce vik austin",
        description: "i'am here",
        icon: "standard:account"
    }
        ,
    {
        location: {
            City: "Dallas",
            Country: "USA",
            State: "TX",
            Street: "2013 Dublin court",
        },
        title: "salesforce vik dallas",
        description: "i'am not here",
        icon: "standard:account"
    }];
}