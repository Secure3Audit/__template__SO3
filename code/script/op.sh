#!/bin/sh
source ./script/init.sh

loadValue "so3" "so3"
loadValue "chef" "chef"
loadValue "market" "market"

initialize(){
  cast send  $commargs $so3 "setMaster(address)" "$chef";
  cast send  $commargs $chef "setAgent(address)" "$market";
}
searchAgent(){
  cast call  $commargs $chef "agent() returns(address)";

  cast call  $commargs $chef "totalDeposits() returns(uint256)";

  cast call  $commargs $chef "rewardPerBlock() returns(uint256)";

}

buy(){
  cast send  $commargs --value "10000000000000000" $market "buy(address)" "$1";
}

batchBuy(){
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x1003ff39d25F2Ab16dBCc18EcE05a9B6154f65F4"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x9eAF5590f2c84912A08de97FA28d0529361Deb9E"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x11e8F3eA3C6FcF12EcfF2722d75CEFC539c51a1C"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x7D86687F980A56b832e9378952B738b614A99dc6"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x9eF6c02FB2ECc446146E05F1fF687a788a8BF76d"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x08A2DE6F3528319123b25935C92888B16db8913E"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xe141C82D99D85098e03E1a1cC1CdE676556fDdE0"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x4b23D303D9e3719D6CDf8d172Ea030F80509ea15"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xC004e69C5C04A223463Ff32042dd36DabF63A25a"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x5eb15C0992734B5e77c888D713b4FC67b3D679A2"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x7Ebb637fd68c523613bE51aad27C35C4DB199B9c"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x3c3E2E178C69D4baD964568415a0f0c84fd6320A"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x35304262b9E87C00c430149f28dD154995d01207"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xD4A1E660C916855229e1712090CcfD8a424A2E33"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xEe7f6A930B29d7350498Af97f0F9672EaecbeeFf"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x145e2dc5C8238d1bE628F87076A37d4a26a78544"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xD6A098EbCc5f8Bd4e174D915C54486B077a34A51"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x042a63149117602129B6922ecFe3111168C2C323"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xa0EC9eE47802CeB56eb58ce80F3E41630B771b04"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xe8B1ff302A740fD2C6e76B620d45508dAEc2DDFf"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xAb707cb80e7de7C75d815B1A653433F3EEc44c74"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x0d803cdeEe5990f22C2a8DF10A695D2312dA26CC"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x1c87Bb9234aeC6aDc580EaE6C8B59558A4502220"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x4779d18931B35540F84b0cd0e9633855B84df7b8"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xC0543b0b980D8c834CBdF023b2d2A75b5f9D1909"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x73B3074ac649A8dc31c2C90a124469456301a30F"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x265188114EB5d5536BC8654d8e9710FE72C28c4d"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x924Ba5Ce9f91ddED37b4ebf8c0dc82A40202fc0A"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x64492E25C30031EDAD55E57cEA599CDB1F06dad1"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x262595fa2a3A86adACDe208589614d483e3eF1C0"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xDFd99099Fa13541a64AEe9AAd61c0dbf3D32D492"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x63c3686EF31C03a641e2Ea8993A91Ea351e5891a"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x9394cb5f737Bd3aCea7dcE90CA48DBd42801EE5d"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x344dca30F5c5f74F2f13Dc1d48Ad3A9069d13Ad9"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xF23E054D8b4D0BECFa22DeEF5632F27f781f8bf5"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x6d69F301d1Da5C7818B5e61EECc745b30179C68b"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xF0cE7BaB13C99bA0565f426508a7CD8f4C247E5a"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x011bD5423C5F77b5a0789E27f922535fd76B688F"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xD9065f27e9b706E5F7628e067cC00B288dddbF19"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x54ccCeB38251C29b628ef8B00b3cAB97e7cAc7D5"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xA1196426b41627ae75Ea7f7409E074BE97367da2"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xE74cEf90b6CF1a77FEfAd731713e6f53e575C183"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x7Df8Efa6d6F1CB5C4f36315e0AcB82b02Ae8BA40"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x9E126C57330FA71556628e0aabd6B6B6783d99fA"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x586BA39027A74e8D40E6626f89Ae97bA7f616644"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x9A50ed082Cf2fc003152580dcDB320B834fA379E"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xbc8183bac3E969042736f7af07f76223D11D2148"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x586aF62EAe7F447D14D25f53918814e04d3A5BA4"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xCcDd262f272Ee6C226266eEa13eE48D4d932Ce66"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xF0eeDDC5e015d4c459590E01Dcc2f2FD1d2baac7"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x4edFEDFf17ab9642F8464D6143900903dD21421a"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x492C973C16E8aeC46f4d71716E91b05B245377C9"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xE5D3ab6883b7e8c35c04675F28BB992Ca1129ee4"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x71F280DEA6FC5a03790941Ad72956f545FeB7a52"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xE77478D9E136D3643cFc6fef578Abf63F9Ab91B1"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x6C8EA11559DFE79Ae3dBDD6A67b47F61b929398f"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x48fA7b63049A6F4E7316EB2D9c5BDdA8933BCA2f"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x16aDfbeFdEfD488C992086D472A4CA577a0e5e54"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x225356FF5d64889D7364Be2c990f93a66298Ee8D"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xcBDc0F9a4C38f1e010bD3B6e43598A55D1868c23"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xBc5BdceE96b1BC47822C74e6f64186fbA7d686be"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x0536896a5e38BbD59F3F369FF3682677965aBD19"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0xFE0f143FcAD5B561b1eD2AC960278A2F23559Ef9"
cast send  $commargs --value "100000000000000000" $market "buy(address)"  "0x98D08079928FcCB30598c6C6382ABfd7dbFaA1cD"

}

setReward(){
  cast send  $commargs $chef "setRewardPerBlock(uint256)" "1200000000000000000000" ;
}



changeAgent(){
  cast send  $commargs $chef "setAgent(address)" "$1";
}

# searchOrder(){
#   loadValue "exchange.proxy" "EXCHANGE"

#   cast call --rpc-url $ETH_RPC_URL  $EXCHANGE "getOrder(bytes32) returns(Order calldata)" "$1"
# }

searchUnclaimed(){
  cast call --rpc-url $ETH_RPC_URL  $chef "unclaimed(address[]) returns(uint256)" "[$1]"
}

searchPower(){
  cast call --rpc-url $ETH_RPC_URL $chef "userInfo(address) returns(address,uint256,uint256,uint256)" "$1"
}

setClaimFee(){
  # 8%,2%
  cast send  $commargs $chef "setFeeBP(uint256 toMiner, uint256 toTreasury)" "800" "200"
}
withdrawPower(){
  cast send  $commargs $chef "withdraw(address,uint256)" "$1" "$2"
}

reportInfo(){
  cast call $commargs $chef "rewardPerBlock() returns(uint256)"
}
claimAll(){

  list="[0x5eb15c0992734b5e77c888d713b4fc67b3d679a2,0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266,0x90f79bf6eb2c4f870365e785982e1f101e93b906,0x70997970c51812dc3a010c7d01b50e0d17dc79c8,0x87bdce72c06c21cd96219bd8521bdf1f42c78b5e,0x8263fce86b1b78f95ab4dae11907d8af88f841e7,0x9dcce783b6464611f38631e6c851bf441907c710,0x7ebb637fd68c523613be51aad27c35c4db199b9c,0x11e8f3ea3c6fcf12ecff2722d75cefc539c51a1c,0xcf2d5b3cbb4d7bf04e3f7bfa8e27081b52191f91,0x7d86687f980a56b832e9378952b738b614a99dc6,0xa0ee7a142d267c1f36714e4a8f75612f20a79720,0x2f4f06d218e426344cfe1a83d53dad806994d325,0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc,0x1bcb8e569eedab4668e55145cfeaf190902d3cf2,0x08a2de6f3528319123b25935c92888b16db8913e,0x15d34aaf54267db7d7c367839aaf71a00a2c6a65,0x9ef6c02fb2ecc446146e05f1ff687a788a8bf76d,0xc004e69c5c04a223463ff32042dd36dabf63a25a,0x23618e81e3f5cdf7f54c3d65f7fbc0abf5b21e8f,0x4b23d303d9e3719d6cdf8d172ea030f80509ea15,0x9eaf5590f2c84912a08de97fa28d0529361deb9e,0x1aac82773cb722166d7da0d5b0fa35b0307dd99d,0x9965507d1a55bcc2695c58ba16fb37d819b0a4dc,0x1003ff39d25f2ab16dbcc18ece05a9b6154f65f4,0xd8da6bf26964af9d7eed9e03e53415d37aa96045,0xfb1f17a3b7d41c8c544bf3f9a6f96266affa07e5,0x40fc963a729c542424cd800349a7e4ecc4896624,0x976ea74026e726554db657fa54763abd0c3a0aa9,0x553bc17a05702530097c3677091c5bb47a3a7931,0x86c53eb85d0b7548fea5c4b4f82b4205c8f6ac18,0x14dc79964da2c08b23698b3d3cc7ca32193d9955,0xe141c82d99d85098e03e1a1cc1cde676556fdde0]"
  cast send  $commargs $chef "claim(address,uint256)" "$1" "$2"
}

minerInfo(){
  #
  cast call  $commargs $market "minerInfo(address)  (address host_, uint256 worth, uint256 giff, uint256 vol, uint256 power)" "$1"
}
fixGift(){
  cast send  $commargs $market "fixGift(address,uint256)" "0x389f62e4d0abfa2d23a55ce4dfe9fcab9277d0ee" "4000000000000000000"
  cast send  $commargs $market "fixGift(address,uint256)" "0xfb1f17a3b7d41c8c544bf3f9a6f96266affa07e3" "2000000000000000000"
}
case $1 in
"initialize") initialize;;
"searchPower")searchPower $2;;
"searchUnclaimed")searchUnclaimed $2;;
"setClaimFee")setClaimFee;;
"changeAgent" ) changeAgent $2;;
"withdrawPower" ) withdrawPower $2 $3;;
"minerInfo" ) minerInfo $2;;
"fixGift" ) fixGift;;
"searchAgent") searchAgent;;
"setReward") setReward;;
"buy") buy $2;;
"batchBuy")batchBuy;;
"reportInfo")reportInfo;;
esac

