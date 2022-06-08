# flycheck-openapi-spectral

Support for flycheck in Swagger 2/OpenAPI 3 buffers using [Spectral](https://github.com/stoplightio/spectral).

This flycheck checker tries to find `swagger: 2.0` or `openapi: 3.*` in a YAML buffer to determine whether the file is (probably) a Swagger or OpenAPI spec. If it is, it will run the spectral linter on the file contents and report errors, warnings, and info-level messages to the flycheck buffer.
