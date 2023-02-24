const {expect}=require('chai');
const {ethers}=require('hardhat');

const LINK="0x326C977E6efc84E512bB9C30f76E30c160eD06FB";
const WETH="0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6";
const USDC="0x07865c6E87B9F70255377e024ace6630C1Eaa37F";

describe("SingleSwapToken",()=>{
    let singleSwapToken;
    let accounts;
    let weth;
    let link;
    let usdc;

    before(async()=>{
        accounts=await ethers.getSigners(1);

        const SingleSwapToken=await ethers.getContractFactory('SingleSwapToken');
        singleSwapToken=SingleSwapToken.deploy();

        (await singleSwapToken).deployed;

        weth=await ethers.getContractAt('IWETH',WETH);
        link=await ethers.getContractAt('IERC20',LINK);
        usdc=await ethers.getContractAt('IERC20',USDC);

        // console.log(weth);
        // console.log(link);
        // console.log(usdc);
        // console.log(accounts);
        // console.log(singleSwapToken);

    })

    it("swapExactInputSingle",async()=>{
        const amountIn=10n ** 18n;

        //Let's Deposit WETH
        await weth.deposit({value:amountIn});
        await weth.approve(singleSwapToken.address,amountIn);

        await singleSwapToken.swapExactInputSingle(2);
        console.log("USDC balance:", await usdc.balanceOf(accounts[0].address));

        // console.log(weth);
        // console.log(link);
        // console.log(usdc);
        // console.log(accounts);
        // console.log(singleSwapToken);
    })

})

