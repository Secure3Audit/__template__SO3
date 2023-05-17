---
name: READ IssueSubmissionGuidelines first -> Secure3 Audit Finding Submission
about: Issue template submitting audit findings
title: Change this subject - Reentrancy risk in `sample` contract `test` function
labels: ''
assignees: tedsecure3

---

### description: 
// PLEASE write more details here and clearly explain the reason, callstack and impact. As the issue will be passed directly to the client devs (not security engineers), most of the security related knowledge you take for granted and deem as easy will not be obvious to them.

Because the value deduction is executed after the `transfer()` call, which with ERC777 hook function there can be callback to this test function ... 

The impact is that the malicious contract can ...


Consider below POC contract
```solidity
contract ERC777Hack {
    function reenter() external {
        helper.transfer(address(baseToken), msg.sender, amount);
    }
    ...
}
```

### recommendation: 
Use the Checks-Effects-Interactions best practice and make all state changes before calling external contracts. Also, consider using function modifiers such as `nonReentrant` from Reentrancy Guard to prevent re-entrancy at the contract level.

Consider below fix in the `sample.test()` function
```solidity
val = newVal;
transfer call...
```

### locations: 
- code/contracts/sample.sol#L9-L18 (Please use relative path from repo root, NOT code link url)
- code/contracts/sample.sol#L36 (Two format accepted: single line or line ranges, NOT comma seperated lines) 

### severity: 
Informational / Low / Medium / Critical (Choose one only)

### category: 
Logical / Privilege Related / Language Specific / Code Style / Gas Optimization / Governance Manipulation / Reentrancy / Signature Forgery or Replay / DOS / Oracle Manipulation / Flash Loan Attacks / Integer Overflow and Underflow / Weak Sources of Randomness / Write to Arbitrary Storage Location / Race condition (Choose one only)
