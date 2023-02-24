interface IWETH{
    function deposit() external payable;
    function approve(address spender,uint amount) external returns(bool);
}