pragma solidity ^0.4.24;


contract CampaignFactory{

 address[] public deployedCampain;
 function createCampain(uint mininum) public {

   address newCampain = new Campaign(mininum,msg.sender);
   deployedCampain.push(newCampain);

 }

 function getdeployedCampaign() public view returns (address[]) {
   return deployedCampain;
 }
 
}



contract Campaign{


    struct Request{
        string description;      //项目描述
        uint value;              //项目金额
        address recipients;     //请求项目的地址
        bool compelte;          //请求是否通过
        uint approvalCount;    //请求赞同人数

        mapping(address => bool) approvers;  //请求项目的地址和是否成功建立关联关系，形成表
    }

    Request[] public requests;   //请求项目数组，便于建立索引
    address public manager;      //众筹发起人地址
    uint public minimunContribute;   //参与者最小参与金额
    mapping(address => bool) public approvers;  //参与者的地址和是否成功参与建立关系
    uint public approvesCount;  //成功参与者的数量

   modifier restricted{
       require(msg.sender == manager);
       _;
   }

    constructor(uint minimum,address _address) public{

        manager = _address;
        minimunContribute = minimum;

    }                          //构造发起人的地址和参与最小金额

    function contribute() public payable{

        require(msg.value > minimunContribute);  //要求参与金额大于最小参与金额
        approvers[msg.sender] = true;           //这样地址则为真
        approvesCount++;                       //成功参与人数量增加

    }

    function createRequest(string _description,uint _value,address _addr) public{
        Request memory newrequest = Request({
            description:_description,
            value:_value,
            recipients:_addr,
            compelte:false,
            approvalCount:0
        });        //建立新项目的各个属性，包括描述，金额，接受地址，初始是否通过的状态，初始支持者的数量

        requests.push(newrequest);   //将新创建的项目添加到项目数组中

    }




    function approvalRequest(uint index) public{

        Request storage request = requests[index];  //通过项目索引找到项目
        require(approvers[msg.sender]);    //投票人需要是成功参与该项目的人
        require(!request.approvers[msg.sender]);  //每个投票人只能参与1次
        request.approvers[msg.sender]=true;   //投票人成功投票
        request.approvalCount++;   //支持该项目人数增加

    }

    function finalizeRequest(uint index) public restricted payable{

        Request storage request = requests[index];  //通过项目索引找到项目
        require (request.approvalCount > approvesCount/2);  //要求支持项目人数大于参与项目人数的一半
        request.recipients.transfer(request.value);  //将众筹的钱转到该项目地址中
        request.compelte = true;  //项目获得通过，初始值变化
    }

    function getSummary() public view returns(uint,uint,uint,uint,address){
        return(minimunContribute,address(this).balance,requests.length,approvesCount,manager);
    }   //根据需要打印出最小参与金额、众筹余额、请求项目的数量、众筹参与人数、众筹发起人地址

    function getRequestCount()public view returns(uint){
        return requests.length;
    }

}
