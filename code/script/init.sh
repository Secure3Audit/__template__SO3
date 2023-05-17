#!/bin/sh
source .env
echo "chain is: $NETWORK"
echo "loading source: .env.$NETWORK"
source ".env.$NETWORK"


commargs="--private-key $RAW_PRIVATE_KEY --rpc-url $ETH_RPC_URL --from $ETH_FROM "

checkErr(){
  if [ $? -ne 0 ]; then
    echo "failed"
    exit 1
  fi
}

setValue(){
  tmp=$(mktemp)
  jq --arg a $2 ".$NETWORK.$1=\$a" deployInfo.json > "$tmp" && mv "$tmp" deployInfo.json
  checkErr
}

delValue(){
  tmp=$(mktemp)
  jq "del(.$NETWORK.$1)" deployInfo.json > "$tmp" && mv "$tmp" deployInfo.json
  checkErr
}
loadValue(){
  ret_val=$(jq .$NETWORK.$1 deployInfo.json -r)
  checkErr
  export $2="$ret_val"
  # echo "laod $2=$ret_val"
  checkErr
}

deployContract(){
  if is_exsit "$1" ; then
   echo "skip deploy when exist"
  else
    echo -e "run:\n\t$2"
    result=$($2)
    checkErr
    addr=$(echo "$result" | jq ".deployedTo" -r)
    checkErr
    echo "deployedTo: $addr"
    setValue "$1" "$addr"
    checkErr
  fi
}

is_exsit(){
  loadValue "$1" "_TMP"
  if [[ "$ret_val" -eq "null" ]]
  then
    return 1  # false is null
  else
    return 0 # true is not null
  fi
}
