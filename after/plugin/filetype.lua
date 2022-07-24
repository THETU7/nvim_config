require('filetype').setup{
	overrides = {
		literal = {
			["xmake.lua"] = "xmake",
			WORKSPACE = "bzl",
			[".bazelrc"] = "bzl"
		}
	}
}
