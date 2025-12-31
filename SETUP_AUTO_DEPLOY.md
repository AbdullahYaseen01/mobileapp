# 🚀 Automatic Deployment to Vercel - Setup Guide

## Overview

This guide will help you set up automatic deployment to Vercel using GitHub Actions. Every time you push code to the `main` branch, it will automatically:
1. Build your Flutter web app
2. Deploy to Vercel
3. Give you a live URL

## ✅ Step 1: Get Vercel Credentials

### Option A: Via Vercel Dashboard (Easiest)

1. **Go to Vercel Dashboard:**
   - Visit: https://vercel.com/account/tokens
   - Create a new token
   - Copy the token (you'll need it)

2. **Get Project IDs:**
   - Go to your project settings in Vercel
   - Go to "Settings" → "General"
   - Copy:
     - **Organization ID** (or Team ID)
     - **Project ID**

### Option B: Via Vercel CLI

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Link project (if not already linked)
vercel link

# This will show you the IDs you need
```

## ✅ Step 2: Add GitHub Secrets

1. **Go to your GitHub repository:**
   - https://github.com/AbdullahYaseen01/mobileapp

2. **Go to Settings:**
   - Click "Settings" tab
   - Click "Secrets and variables" → "Actions"

3. **Add these secrets:**

   **VERCEL_TOKEN:**
   - Name: `VERCEL_TOKEN`
   - Value: Your Vercel token (from Step 1)

   **VERCEL_ORG_ID:**
   - Name: `VERCEL_ORG_ID`
   - Value: Your Organization/Team ID

   **VERCEL_PROJECT_ID:**
   - Name: `VERCEL_PROJECT_ID`
   - Value: Your Project ID

## ✅ Step 3: Create Vercel Project (If Not Done)

If you haven't created a Vercel project yet:

1. **Go to Vercel:**
   - https://vercel.com/new

2. **Import Repository:**
   - Select: `AbdullahYaseen01/mobileapp`
   - Framework: **Other**
   - Build Command: `flutter build web --release` (but GitHub Actions will handle this)
   - Output Directory: `build/web`
   - Click "Deploy"

3. **After first deployment:**
   - Get the Project ID from settings
   - Add it to GitHub Secrets

## ✅ Step 4: Verify Workflow

1. **Check GitHub Actions:**
   - Go to your repo → "Actions" tab
   - You should see "Deploy to Vercel" workflow

2. **Trigger Deployment:**
   - Push any change to `main` branch
   - Or manually trigger: Actions → "Deploy to Vercel" → "Run workflow"

3. **Watch the Build:**
   - GitHub Actions will build your Flutter app
   - Then deploy to Vercel
   - You'll get a live URL!

## 🎯 How It Works

### Workflow Steps:

1. **Checkout Code** - Gets your code from GitHub
2. **Setup Flutter** - Installs Flutter SDK
3. **Enable Web** - Enables Flutter web support
4. **Get Dependencies** - Runs `flutter pub get`
5. **Build Web** - Builds your app with `flutter build web --release`
6. **Deploy to Vercel** - Deploys the built app to Vercel

### Automatic Triggers:

- ✅ Push to `main` branch
- ✅ Pull requests to `main`
- ✅ Manual trigger (workflow_dispatch)

## 📋 Quick Setup Checklist

- [ ] Get Vercel token
- [ ] Get Vercel Organization ID
- [ ] Get Vercel Project ID
- [ ] Add secrets to GitHub
- [ ] Push code to trigger workflow
- [ ] Check deployment status
- [ ] Get live URL from Vercel

## 🔧 Troubleshooting

### Workflow Fails

**Check:**
1. Secrets are correctly set in GitHub
2. Vercel project exists
3. Flutter build succeeds locally
4. Check workflow logs in GitHub Actions

### Build Errors

**Common issues:**
- Flutter version mismatch
- Missing dependencies
- Firebase configuration

**Fix:**
- Check workflow logs
- Update Flutter version in workflow if needed
- Ensure all dependencies are in `pubspec.yaml`

### Deployment Errors

**Check:**
- Vercel token is valid
- Project ID is correct
- Organization ID is correct
- Vercel project exists

## 🎉 After Setup

Once configured:
- ✅ Every push to `main` = Automatic deployment
- ✅ Live URL updates automatically
- ✅ No manual deployment needed
- ✅ Build logs in GitHub Actions
- ✅ Deployment status in Vercel

## 📱 Your Live URL

After deployment, your app will be available at:
- `https://mobileapp-xxx.vercel.app` (or your custom domain)

## 🔄 Update Workflow

If you need to modify the workflow:
- Edit: `.github/workflows/deploy-vercel-simple.yml`
- Push changes
- Workflow will run automatically

---

**Need help?** Check the workflow logs in GitHub Actions for detailed error messages.

