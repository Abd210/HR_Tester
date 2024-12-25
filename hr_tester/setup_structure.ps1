# setup_structure.ps1
# Script to create directories and files for HR Flutter Web project

# List of directories to create
$directories = @(
    "lib\routes",
    "lib\models",
    "lib\services",
    "lib\providers",
    "lib\screens\auth",
    "lib\screens\admin",
    "lib\screens\tests",
    "lib\screens\user",
    "lib\screens\common",
    "lib\widgets\common",
    "lib\widgets\forms",
    "lib\widgets\tests",
    "lib\widgets\dialogs",
    "lib\localization",
    "lib\utils",
    "lib\themes",
    "lib\assets\images",
    "lib\assets\icons",
    "lib\assets\translations"
)

# Create directories
foreach ($dir in $directories) {
    if (-not (Test-Path -Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null
        Write-Host "Created directory: $dir"
    } else {
        Write-Host "Directory already exists: $dir"
    }
}

# List of files to create
$files = @(
    "lib\main.dart",
    "lib\app.dart",
    "lib\routes\app_routes.dart",

    "lib\models\user.dart",
    "lib\models\role.dart",
    "lib\models\permission.dart",
    "lib\models\test.dart",
    "lib\models\test_domain.dart",
    "lib\models\test_question.dart",
    "lib\models\test_option.dart",
    "lib\models\test_result.dart",
    "lib\models\organization.dart",
    "lib\models\job.dart",

    "lib\services\api_service.dart",
    "lib\services\auth_service.dart",
    "lib\services\user_service.dart",
    "lib\services\role_service.dart",
    "lib\services\test_service.dart",
    "lib\services\organization_service.dart",

    "lib\providers\auth_provider.dart",
    "lib\providers\user_provider.dart",
    "lib\providers\role_provider.dart",
    "lib\providers\test_provider.dart",
    "lib\providers\organization_provider.dart",

    "lib\screens\auth\login_screen.dart",
    "lib\screens\auth\register_screen.dart",
    "lib\screens\admin\dashboard_screen.dart",
    "lib\screens\admin\manage_users_screen.dart",
    "lib\screens\admin\manage_roles_screen.dart",
    "lib\screens\admin\manage_tests_screen.dart",
    "lib\screens\admin\manage_domains_screen.dart",
    "lib\screens\tests\take_test_screen.dart",
    "lib\screens\tests\test_results_screen.dart",
    "lib\screens\tests\test_summary_screen.dart",
    "lib\screens\user\profile_screen.dart",
    "lib\screens\user\evaluations_screen.dart",
    "lib\screens\user\salary_suggestions_screen.dart",
    "lib\screens\common\loading_screen.dart",
    "lib\screens\common\error_screen.dart",

    "lib\widgets\common\header.dart",
    "lib\widgets\common\footer.dart",
    "lib\widgets\common\sidebar.dart",
    "lib\widgets\common\notification_widget.dart",
    "lib\widgets\forms\login_form.dart",
    "lib\widgets\forms\register_form.dart",
    "lib\widgets\forms\user_form.dart",
    "lib\widgets\forms\test_form.dart",
    "lib\widgets\tests\question_widget.dart",
    "lib\widgets\tests\option_widget.dart",
    "lib\widgets\tests\webcam_widget.dart",
    "lib\widgets\tests\timer_widget.dart",
    "lib\widgets\dialogs\confirm_dialog.dart",
    "lib\widgets\dialogs\alert_dialog.dart",

    "lib\localization\en.json",
    "lib\localization\fr.json",
    "lib\localization\es.json",

    "lib\utils\constants.dart",
    "lib\utils\validators.dart",
    "lib\utils\helpers.dart",
    "lib\utils\enums.dart",

    "lib\themes\light_theme.dart",
    "lib\themes\dark_theme.dart"
)

# Create files
foreach ($file in $files) {
    if (-not (Test-Path -Path $file)) {
        New-Item -Path $file -ItemType File -Force | Out-Null
        Write-Host "Created file: $file"
    } else {
        Write-Host "File already exists: $file"
    }
}

Write-Host "Project structure has been successfully set up!"
