void main() {
    string tmpString = "My {pet} has {ailment}.";
    auto dic = ["pet" : "dog",
                "ailment" : "fleas"];
    
    import std.stdio : writeln;

    writeln(tmpString.replaceTokens(dic));

// from off Learn Forum https://forum.dlang.org/post/ocveh5$17v$1@digitalmars.com fast answer too
   // Arrange
    const string templateString = "My {pet} has {number} {ailment}.";
    auto pairs = [
        "pet": "dog",
        "number": "5",
        "ailment": "fleas",
    ];

    // Act
    import std.regex: regex, replaceAll;
    auto result = templateString
        .replaceAll!(m => pairs[m[1]])(regex(`\{([^}]+)\}`));

    // Assert
    writeln(result);
    assert(result == "My dog has 5 fleas.");
}

string replaceTokens(in string tmpString, in string[string] aa) {
    import std.array : replace;

    string result = tmpString;

    foreach(key, value; aa) {
        string addBits(in string root) {
            return "{" ~ root ~ "}";
        }
        result = result.replace(addBits(key), value);
    }

    return result;
}

/+
//here's an actual test for some code I wrote for Statistics NZ a few weeks ago if you can read C#

using System.Collections.Generic;
using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using StatsNZ.Epl.MI.Core.Services;

namespace StatsNZ.Epl.MI.Test.Core.Services
{
    [TestClass]
    public class TemplateStringInterpolatorTests
    {
        [TestMethod]
        public void ReplaceTokens_NoTokens_ShouldReturnOriginalTemplate()
        {
            // Arrange
            const string templateString = "mystring";

            // Act
            var result = TemplateStringInterpolator.ReplaceTokens(templateString, new Dictionary<string, string>());

            // Assert
            result.Should().Be(templateString);
        }

        [TestMethod]
        public void ReplaceTokens_AllTokensMatch_ShouldReplaceTokens()
        {
            // Arrange
            const string templateString = "My {pet} has {ailment}.";
            var pairs = new Dictionary<string, string>()
            {
                { "pet", "dog" },
                { "ailment", "fleas" },
            };

            // Act
            var result = TemplateStringInterpolator.ReplaceTokens(templateString, pairs);

            // Assert
            result.Should().Be("My dog has fleas.");
        }

        [TestMethod]
        public void ReplaceTokens_SomeTokensMatch_ShouldReplaceTokens()
        {
            // Arrange
            const string templateString = "I love my {pet}.";
            var pairs = new Dictionary<string, string>
            {
                { "pet", "dog" },
                { "ailment", "fleas" },
            };

            // Act
            var result = TemplateStringInterpolator.ReplaceTokens(templateString, pairs);

            // Assert
            result.Should().Be("I love my dog.");
        }

        [TestMethod]
        public void ReplaceTokens_DynamicApiWithTokens_ShouldReplaceTokens()
        {
            // Arrange
            const string templateString = "My {pet} has {number} {ailment}.";
            var pairs = new
            {
                pet = "dog",
                number = 5,
                ailment = "fleas",
            };

            // Act
            var result = TemplateStringInterpolator.ReplaceTokens(templateString, pairs);

            // Assert
            result.Should().Be("My dog has 5 fleas.");
        }
    }
}
+/