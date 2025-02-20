// function lengthOfLastWord(s) {
//     return s.trim().split(" ").filter(word => word.length > 0).pop().length;
// }

// // Test cases
// console.log(lengthOfLastWord("Hello World")); // Output: 5
// console.log(lengthOfLastWord("   fly me   to   the moon  ")); // Output: 4
// console.log(lengthOfLastWord("luffy is still joyboy")); // Output: 6



// function addBinary(a,b) {
//     let result = ""
//     let carry = 0 
//     let i = a.lenth - 1, j=b.length - 1;

//     while (i>=0 ||  j >=0 || carry) {
//         let sum = carry
//         if(i>=0) sum += a[i--] - '0'
//         if(j>=0) sum += b[j--] - '0'

//         result = (sum % 2) + result;
//         carry = Math.floor(sum/2)
//     }
//     return result
// }

// console.log(addBinary("11","1"))  // output: "100"



// function mySqrt(x){
//     if(x===0 || x===1) return x;

//     let left = 1, right = x, ans = 0;

//     while(left <= right) {
//         let mid = Math.floor((left + right) /2);
//         if(mid * mid ===x) return mid;

//         if(mid * mid < x){
//             ans = mid;
//             left = mid + 1;
//         } else {
//             right = mid - 1
//         }
//     } return ans;
// }

// console.log(mySqrt(4))  // output: 2


