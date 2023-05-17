#!/bin/sh
source ./scripts/init.sh


loadValue "config" "config"
loadValue "exchange.proxy" "exchange"

verifyVotePool(){
  symbol="$1"
  echo "$symbol"
  loadValue "pools.$symbol.nft" "NFT"
  loadValue "pools.$symbol.impl" "Impl"
  loadValue "pools.$symbol.proxy" "Proxy"
  loadValue "pools.$symbol.config.weightWithoutBidder" "weightWithoutBidder"
  loadValue "pools.$symbol.config.weightWithBidder" "weightWithBidder"
  loadValue "pools.$symbol.config.mintVoteAmount" "mintVoteAmount"
  loadValue "pools.$symbol.asset" "asset"
  initializeData="$(cast abi-encode "initialize(address,address,address,address,(uint120,uint32,uint32))" "$config" "$exchange" "$NFT" "$asset" "($mintVoteAmount,$weightWithoutBidder,$weightWithBidder)" )"
  checkErr
  forge verify-contract $Proxy ERC1967Proxy --constructor-args $(cast abi-encode "constructor(address,bytes)" "$Impl"  "$initializeData")
  checkErr

  # vote pool implement
  forge verify-contract $Impl VotePool

  # vote token
  nftName="$(cast call $NFT "name()(string)")"
  nftSymbol="$(cast call $NFT "symbol()(string)")"
  forge verify-contract $NFT VoteToken \
  --constructor-args $(cast abi-encode "constructor(string,string,address,string)"  "$nftName" "$nftSymbol" "$asset" 'https://nft.nftvoter.com')
}

verifyExchange(){
  impl="$(jq ."$CHAIN".exchange.impl deployInfo.json -r)"

  forge verify-contract $impl NFTExchange

  config="$(jq ."$CHAIN".config deployInfo.json -r)"
  Proxy="$(jq ."$CHAIN".exchange.proxy deployInfo.json -r)"

  initCode="$(cast abi-encode "initialize(address)" "$config")"
  forge verify-contract $Proxy ERC1967Proxy \
   --constructor-args "$(cast abi-encode "constructor(address,bytes)" $impl $initCode)"
}

verifyUSDT(){
  USDT="$(jq ."$CHAIN".USDT deployInfo.json -r)"
  forge verify-contract $USDT MockERC20 \
   --constructor-args "$(cast abi-encode "constructor(string,string,uint8)" "USDT2" "USDT2" "6")"
}

case $1 in
 "exchange" ) verifyExchange ;;
 "votepool" ) verifyVotePool "$2" ;;
 "verifyUSDT") verifyUSDT;;
 "all" )
    verifyExchange
    verifyVotePool "vETH"
    verifyVotePool "vUSDT"
    ;;
 *) echo "invalid command" ;;
esac
