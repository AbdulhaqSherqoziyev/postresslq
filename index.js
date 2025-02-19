function lengthOfLastWord(s) {
    return s.trim().split(" ").filter(word => word.length > 0).pop().length;
}

// Test cases
console.log(lengthOfLastWord("Hello World")); // Output: 5
console.log(lengthOfLastWord("   fly me   to   the moon  ")); // Output: 4
console.log(lengthOfLastWord("luffy is still joyboy")); // Output: 6
