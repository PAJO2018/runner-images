Describe "README" {
    BeforeAll {
        $readmePath = Join-Path $PSScriptRoot "README.md"
        $readmeLines = Get-Content -Path $readmePath
        $readmeContent = Get-Content -Path $readmePath -Raw
    }

    It "exists at the repository root" {
        Test-Path -Path $readmePath -PathType Leaf | Should -BeTrue
    }

    It "starts with a level-1 markdown heading" {
        $readmeLines[0] | Should -Match '^# \S'
    }

    It "has the expected repository title as its first heading" {
        $readmeLines[0] | Should -Be "# GitHub Actions Runner Images"
    }

    It "does not have stray characters preceding the heading marker" {
        # Regression test: a leading character (e.g. ".") before "#" breaks
        # Markdown heading rendering, e.g. ".# GitHub Actions Runner Images"
        $readmeLines[0] | Should -Not -Match '^[^#]'
    }

    It "does not render the title as a nested heading" {
        $readmeLines[0] | Should -Not -Match '^##'
    }

    It "still contains the Table of Contents immediately after the title" {
        $readmeContent | Should -Match '^# GitHub Actions Runner Images\r?\n\r?\n\*\*Table of Contents\*\*'
    }
}