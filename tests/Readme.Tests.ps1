BeforeDiscovery {
    $script:RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
    $script:ReadmePath = Join-Path $script:RepoRoot "README.md"
}

Describe "README.md" {
    BeforeAll {
        $RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
        $ReadmePath = Join-Path $RepoRoot "README.md"
        $ReadmeLines = Get-Content -Path $ReadmePath
        $FirstLine = $ReadmeLines | Select-Object -First 1
    }

    Context "File presence" {
        It "Exists at the repository root" {
            Test-Path -Path $ReadmePath -PathType Leaf | Should -BeTrue
        }

        It "Is not empty" {
            $ReadmeLines.Count | Should -BeGreaterThan 0
        }
    }

    Context "Title heading" {
        It "Starts with a top-level Markdown heading ('# ')" {
            $FirstLine | Should -Match '^# '
        }

        It "Does not contain any leading characters before the '#' marker" {
            $FirstLine | Should -Not -Match '^\s'
            $FirstLine.Substring(0, 1) | Should -Be '#'
        }

        It "Has the exact expected title text" {
            $FirstLine | Should -Be "# GitHub Actions Runner Images"
        }

        It "Uses a single '#' (H1), not a nested heading level" {
            ($FirstLine -match '^(#+)') | Should -BeTrue
            $matches[1] | Should -Be "#"
        }

        It "Is followed by a blank line before the next section" {
            $ReadmeLines[1] | Should -Be ""
        }
    }
}