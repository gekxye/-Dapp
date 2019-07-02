import React, {Component}from 'react';
import factory from '../ethereum/factory';
import Layout from '../components/Layout';
import { Card,Button } from 'semantic-ui-react';
import {Link} from '../routes';

// export default ()=>{
//
//   return <h1> hello index </h1>
// }

class Campaindex extends Component {

  static async getInitialProps(){
    const compaign = await factory.methods.getdeployedCampaign().call();
    return {compaign};

  }


//   async componentDidMount(){
//     const compaign = factory.methods.getdeployedCampaign().call();
//     console.log(compaign);
//
// }

renderCampaign(){
  const items = this.props.compaign.map(address=>{
    return {
      header:address,
      description:  <Link route={`/compaigns/${address}`}><a>查看众筹</a></Link>,
      fluid:true
    }
  });

  return<Card.Group items={items} />

  }


render(){
  return (
    <Layout>
   <div>

   <h3>众筹列表</h3>


    <Link route="/compaigns/new">
    <a>
   <Button floated='right' content='查看众筹'primary icon='right arrow' labelPosition='right' />
   </a>
   </Link>
   {this.renderCampaign()}
   </div>
   </Layout>

  )
}


}

export default Campaindex;
