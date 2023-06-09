1. Create one GitHub issue for one bug finding submission ONLY, please do not submit more than one finding in one issue.
2. Use the template provided. Format that does not follow the template format may fail to be processed by the system and lead to submission failure.
3. The issue subject should be concise and descriptive. A good issue subject should have the key function name and concise description. The rule of thumb is that the reader should be able to grasp at high level what is the issue and where is it. 
    - Good examples are:
      - `RewardVault` has reentrancy risk for `ERC777` token
      - Weak source of randomness in `NftManager::mintNFT()`
      - Should use `safeTransferFrom()` function in `PaymentPool::pay()` 
    - Bad examples are:
      - Reentrancy risk
      - Logical issues
4. For the **severity** and **category** fields, please only choose one from the provided list.
4. For the `Informational` severity submissions, please bundle all the issues of **one category into one single submission**. For exmaple, if you find `Gas Optimization` category issues for 4 contracts in the project, please submit all of them in one GitHub issue with category `Gas Optimization`. Similarly, if there are 6 important setter functions changing the contract state variable without event emission or missing `indexed` keyword, please submit all of them in one GitHub issue with category `Logical`. This aims to make the audit report more concise and informative for reading. To be clear, this rule does not apply to severity of Low, Medium or Critical. 
5. Our system uses the `locations` value to programmatically get the code snippet from the code base and display the code in the `code` section in the audit report (see more in https://secure3.io/reports). Hence please follow the format required in the template and be pricise and concise on the code locations. If the location range is too large, try only select the core isssue locations or selectively list few for demostration purpose. locations such as "all the contarcts" or lacking line number will be automatically rejected.
6. Please write in English only, and have grammer and spelling check is always a nice to have.
