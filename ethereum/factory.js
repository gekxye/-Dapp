import web3 from './web3';

import CampaignFactory from './build/CampaignFactory.json';

const instance = new web3.eth.Contract(
    JSON.parse(CampaignFactory.interface),
    '0x5986B541FFC8d19901B4FDdAD56D11b84785b232'

);


export default instance;
