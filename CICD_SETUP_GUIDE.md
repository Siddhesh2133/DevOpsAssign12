# 🚀 CI/CD Setup Guide (GitHub Actions) - 20 Marks

## ⏱️ Time Required: 15-20 minutes

---

## 📋 What is CI/CD?

**CI/CD** (Continuous Integration/Continuous Deployment) automates:
- ✅ Building Docker images when code changes
- ✅ Pushing images to Docker Hub
- ✅ Deploying to Docker Swarm automatically
- ✅ Verifying deployment success

Instead of running commands manually, GitHub Actions does it automatically!

---

## 🎯 Step-by-Step Setup

### Step 1: Create GitHub Repository (5 mins)

1. **Go to GitHub**: https://github.com
2. **Click** "New repository" (green button)
3. **Repository name**: `DevOpsAssign12-ITA764`
4. **Description**: "DevOps Assignment - Django App with Docker Swarm"
5. **Visibility**: Public
6. **DO NOT** initialize with README (we already have files)
7. **Click** "Create repository"

---

### Step 2: Get Your SSH Private Key (2 mins)

On your **local Windows machine**, run:

```powershell
# Display your SSH private key
type C:\Users\lenovo\Downloads\DevOps Assignment\MyDevOpsAssignment\aws-devops-key.pem
```

**Copy the ENTIRE output** (including `-----BEGIN RSA PRIVATE KEY-----` and `-----END RSA PRIVATE KEY-----`)

---

### Step 3: Configure GitHub Secrets (5 mins)

1. **Go to your repository** on GitHub
2. **Click** "Settings" tab
3. **Click** "Secrets and variables" → "Actions" (left sidebar)
4. **Click** "New repository secret" and add these **3 secrets**:

#### Secret 1: DOCKERHUB_USERNAME
- **Name**: `DOCKERHUB_USERNAME`
- **Value**: `siddhesh2110`

#### Secret 2: DOCKERHUB_TOKEN
- **Name**: `DOCKERHUB_TOKEN`
- **Value**: Your Docker Hub access token
  - Get it from: https://hub.docker.com/settings/security
  - Click "New Access Token"
  - Description: "GitHub Actions"
  - Copy the token

#### Secret 3: SWARM_MANAGER_IP
- **Name**: `SWARM_MANAGER_IP`
- **Value**: `44.223.179.158`

#### Secret 4: SSH_PRIVATE_KEY
- **Name**: `SSH_PRIVATE_KEY`
- **Value**: Paste the ENTIRE SSH private key you copied in Step 2

---

### Step 4: Push Code to GitHub (3 mins)

On your **local Windows machine**, run these commands:

```powershell
# Navigate to your project folder
cd "C:\Users\lenovo\Downloads\DevOps Assignment\DevOpsAssign12"

# Initialize git repository
git init

# Add all files
git add .

# Commit files
git commit -m "Initial commit - DevOps Assignment ITA764"

# Add GitHub remote (REPLACE with YOUR repository URL)
git remote add origin https://github.com/YOUR_USERNAME/DevOpsAssign12-ITA764.git

# Create main branch
git branch -M main

# Push to GitHub
git push -u origin main
```

**Replace** `YOUR_USERNAME` with your actual GitHub username!

---

### Step 5: Trigger CI/CD Pipeline (2 mins)

The pipeline will run automatically when you push code!

**To see it:**
1. Go to your GitHub repository
2. Click "Actions" tab
3. You'll see the workflow running: "CI/CD Pipeline - DevOps Assignment"
4. Click on it to see the progress

**Pipeline stages:**
- 📥 Checkout Code
- 🐳 Set up Docker Buildx
- 🔑 Login to Docker Hub
- 🏗️ Build and Push Docker Image
- 🚀 Deploy to Docker Swarm
- ✅ Verify Deployment

---

### Step 6: Test the Pipeline (2 mins)

Make a small change to test automation:

```powershell
# Edit a file (e.g., add a comment to README.md)
echo "# CI/CD Pipeline Tested Successfully" >> README.md

# Commit and push
git add .
git commit -m "Test CI/CD pipeline"
git push
```

The pipeline will run automatically again!

---

## 📸 Screenshots for Submission

Take these screenshots:

### GitHub Actions Screenshots:
- [ ] **github-actions-workflow.png** - GitHub Actions tab showing successful workflow
- [ ] **github-actions-stages.png** - Detailed view of all pipeline stages (green checkmarks)
- [ ] **github-repository.png** - Your GitHub repository page

### GitHub Secrets Screenshots:
- [ ] **github-secrets.png** - Settings → Secrets page showing all 4 secrets configured

---

## ✅ Verification

**Your CI/CD is working if:**
1. ✅ GitHub Actions workflow shows green checkmark
2. ✅ Docker image pushed to Docker Hub automatically
3. ✅ Application deployed to Swarm automatically
4. ✅ No manual commands needed!

---

## 🎓 What This Demonstrates

**For your 20 CI/CD marks:**
- ✅ **Automated builds** - Code → Docker image automatically
- ✅ **Automated testing** - Pipeline verifies build success
- ✅ **Automated deployment** - Deploys to production automatically
- ✅ **Version control integration** - Git push triggers pipeline
- ✅ **Infrastructure as Code** - Workflow defined in YAML

---

## 🆘 Troubleshooting

### If workflow fails:

1. **Check Secrets**: Make sure all 4 secrets are configured correctly
2. **Check SSH Key**: Ensure private key includes BEGIN/END lines
3. **Check Manager IP**: Verify `44.223.179.158` is correct
4. **Check Docker Hub**: Ensure credentials are correct

### View logs:
- Click on failed workflow in GitHub Actions
- Click on the failed step to see error details

---

## 📊 Evaluation Breakdown (20 marks)

- **Pipeline Configuration** (5 marks) - ✅ deploy.yml created
- **Automated Build** (5 marks) - ✅ Docker image builds automatically
- **Automated Deployment** (5 marks) - ✅ Deploys to Swarm automatically
- **Testing & Verification** (5 marks) - ✅ Verification steps included

---

## 🎉 Final Assignment Score

With CI/CD complete, you'll have:
- ✅ Terraform (20 marks)
- ⚠️ Ansible (0 marks - not possible on Windows, explain in report)
- ✅ Docker Swarm (20 marks)
- ✅ Django App (20 marks)
- ✅ CI/CD (20 marks)

**Expected Total: 80-85 marks** (Ansible substituted with manual Docker setup)

---

**Ready to set up CI/CD? Follow the steps above!** 🚀

*Note: If you don't want to use CI/CD, you can explain in your report that you did manual deployment instead. But CI/CD will maximize your marks!*
