//SPDX-License-Identifier: GPL-2.0-or-Later
pragma solidity >=0.7.0 < 0.9.0;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

contract SingleSwapToken{

    ISwapRouter public constant swapRouter=ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);

    address public constant LINK=0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
    address public constant WETH=0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
    address public constant USDC=0x07865c6E87B9F70255377e024ace6630C1Eaa37F;

    function swapExactInputSingle(uint amountIn) external returns(uint amountOut){

        TransferHelper.safeTransferFrom(WETH,msg.sender,address(this), amountIn);
        TransferHelper.safeApprove(WETH,address(swapRouter),amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams({
            tokenIn:WETH,
            tokenOut:USDC,
            fee:3000,
            recipient:msg.sender,
            deadline:block.timestamp,
            amountIn:amountIn,
            amountOutMinimum:0,
            sqrtPriceLimitX96:0
        });
        amountOut=swapRouter.exactInputSingle(params);
    }
}
