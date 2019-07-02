const HDWalletProvider = require('truffle-hdwallet-provider');

const Web3 = require('web3');

// const {bytecode,interface} = require('./compile');
const compileFactory = require('./build/CampaignFactory.json');

const provider = new HDWalletProvider(
'supply leisure fluid coyote valid hub quality chef scissors casino repeat horror',
'https://rinkeby.infura.io/v3/9775b32aa31644948ff93b12985ca253'

);

const web3 = new Web3(provider);

const deploy = async ()=>{
  // console.log(interface);
  const accounts = await web3.eth.getAccounts();
  // console.log('Attemp to deploy contract',accounts[0]);

const result = await new web3.eth.Contract(JSON.parse(compileFactory.interface)).deploy({data:'0x'+compileFactory.bytecode})
     .send({from:accounts[0],gas:'1000000'});

 console.log('contract deployed to ', result.options.address);

}

deploy();
