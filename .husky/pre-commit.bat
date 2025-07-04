@echo off
echo Running Terraform pre-commit checks...

echo Checking Terraform formatting...
terraform fmt -check -recursive
if %errorlevel% neq 0 (
    echo Terraform formatting check failed. Please run terraform fmt -recursive to fix.
    exit /b 1
)

echo Running Terraform validation...
terraform validate
if %errorlevel% neq 0 (
    echo Terraform validation failed. Please fix the errors.
    exit /b 1
)

echo Running TFLint...
where tflint >nul 2>nul
if %errorlevel% equ 0 (
    tflint
    if %errorlevel% neq 0 (
        echo TFLint check failed. Please fix the linting errors.
        exit /b 1
    )
) else (
    echo TFLint not installed, skipping...
)

echo All pre-commit checks passed!
