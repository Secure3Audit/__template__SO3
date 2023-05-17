#!/bin/sh
source ./script/init.sh

ret_val=""

ZERO_ADDRESS="0x0000000000000000000000000000000000000000"

deploySO3(){
  echo "deploy SO3"
  if  is_exsit  "so3" ; then
    echo "skip deploy when exist"
  else
    cmd="forge create src/SO3.sol:SO3 $commargs --json"
    deployContract "so3" "$cmd"
  fi
}


deployChef(){
  echo "deploy config contract"
  if  is_exsit  "chef" ; then
    echo "skip deploy when exist"
  else
    # deploy implement
    cmd="forge create src/SO3Chef.sol:SO3Chef $commargs --json"
    deployContract "chefImpl" "$cmd"
    # load var
    loadValue "chefImpl" "IMPL"
    loadValue "so3" "SO3"
    loadValue "treasury" "treasury"
    loadValue "config.rewardPerBlock" "rewardPerBlock"

    # deploy proxy
    initializeData="$(cast calldata "initialize(address so3Miner_, address agent_, address treasury_, uint256 rewardPerBlock_)" \
                  "$SO3" "$ZERO_ADDRESS" "$treasury" "$rewardPerBlock" )"
    checkErr
    cmd="forge create lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol:ERC1967Proxy $commargs  --json --constructor-args $IMPL $initializeData"
    deployContract "chef" "$cmd"
  fi
}

deploySO3Market(){
  echo "deploy config contract"
  if  is_exsit  "market" ; then
    echo "skip deploy when exist"
  else
      # deploy implement
    cmd="forge create src/SO3Market.sol:SO3Market $commargs --json"
    deployContract "marketImpl" "$cmd"
    # load var
    loadValue "marketImpl" "IMPL"
    loadValue "so3" "SO3"
    loadValue "treasury" "treasury"
    loadValue "chef" "chef"

    # deploy proxy
    initializeData="$(cast calldata "initialize(address treasury_, address so3, address chef)" \
                  "$treasury"  "$SO3" "$chef")"
    checkErr
    cmd="forge create lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol:ERC1967Proxy $commargs  --json --constructor-args $IMPL $initializeData"
    deployContract "market" "$cmd"
  fi
}



case $1 in
"deploySO3")
    deploySO3
    ;;
"deployChef")
    deployChef
    ;;
"deploySO3Market")
  deploySO3Market
  ;;
esac