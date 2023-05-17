#!/bin/sh
source ./script/init.sh

loadValue "so3" "so3"
loadValue "chef" "chef"
loadValue "market" "market"

mint(){
  cast send  $commargs --value "0.01 ether" $market "mint(address)" "$1" ;
}

claim(){
  cast send $commargs $chef  "claim(address[])" "[$1]" ;
}



# searchOrder(){
#   loadValue "exchange.proxy" "EXCHANGE"

#   cast call --rpc-url $ETH_RPC_URL  $EXCHANGE "getOrder(bytes32) returns(Order calldata)" "$1"
# }



case $1 in
"mint") mint $2;;
"claim") claim $2;;
esac