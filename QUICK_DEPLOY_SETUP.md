# ⚡ Quick Setup - Auto Deploy to Vercel

## 3 Steps to Automatic Deployment

### Step 1: Get Vercel Info (2 minutes)

1. **Go to:** https://vercel.com/account/tokens
2. **Create token** → Copy it
3. **Go to your Vercel project** → Settings → General
4. **Copy:**
   - Organization ID
   - Project ID

### Step 2: Add to GitHub Secrets (1 minute)

1. **Go to:** https://github.com/AbdullahYaseen01/mobileapp/settings/secrets/actions
2. **Add 3 secrets:**
   - `VERCEL_TOKEN` = Your token
   - `VERCEL_ORG_ID` = Your org ID
   - `VERCEL_PROJECT_ID` = Your project ID

### Step 3: Push Code (Automatic!)

```bash
git add .
git commit -m "Setup auto deploy"
git push
```

**That's it!** GitHub Actions will automatically:
- ✅ Build your Flutter app
- ✅ Deploy to Vercel
- ✅ Give you a live URL

---

## 🎯 What Happens Next

1. **GitHub Actions runs** (check Actions tab)
2. **Builds Flutter web app**
3. **Deploys to Vercel**
4. **You get a live URL!**

---

## 📍 Where to Check

- **GitHub Actions:** https://github.com/AbdullahYaseen01/mobileapp/actions
- **Vercel Dashboard:** https://vercel.com/dashboard
- **Live App:** Your Vercel URL

---

**Need detailed instructions?** See `SETUP_AUTO_DEPLOY.md`

