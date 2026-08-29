Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0663033D6
	for <damon@lists.linux.dev>; Sat, 29 Aug 2026 08:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992658; cv=none; b=M8NsQY4Zz6kilNitsldLyJL4E4FVSxZgNl0jF5VMVx12LbqY/IMzvb86x6fPOs3JFW14FUeroSdgAF16Xt/zKQUSEKhmDq4btAnYCNXH2xoeQTANyeka6jNznLaOXVJNEWvPWSowRdXpdv/icUgCFJodz7SwVUZ8yIbHEEw7x2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992658; c=relaxed/simple;
	bh=0W57UE75lT0JWXkqYkhmkWBGe2aIvBBA8agCtfF8vLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jdmBpEIRVPzo1nKG241PWHa4wz13IvLi5EV7qFqeWKk9jewSvdc7uXdjNDlduqxYlhTSaM30pt+2RHzkj21wDzqEnu2fEzpMTv8bg79UtLC6J2DtEnamdMYSMrpxjvAaPGJmXRSabf7GRAxM1TrqR0kKHF7gLFu6NkdQfdJ9pMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AszJXH5k; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AszJXH5k"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce7d2adef4so27764485ad.3
        for <damon@lists.linux.dev>; Sat, 29 Aug 2026 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787992657; x=1788597457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A4IwbgMrRyJTDKTZ/KQuUur9K0X+mbmrk/E1Z34LTpY=;
        b=AszJXH5krJQXgug4CgWXUMXowTdRHB210S6yUyjvzwK4usdLDNF5mO7aw5p3woOmOw
         zjeja9qhpG8vYh1VvZO8G/7yEmqHs8F3vJRt3s0KVJ1fFwtH8S0MxyoXElUmEm2Zjgpu
         p9NrsPWz9DBzbwrxn7SPwvh6YGcu3IgTYWXGescf5UnY4RQpLUigte/sd8Ah88okyxzj
         TlDLJz+Bx2OLbbDrV3SB3twBokw22GON+XeZLXPo3PmEyVCpUJaW8NYmEixTxn6CzToS
         2F+N19za2FLruFiXzG+AdWBqWbv0vMnB+S6BZsIewcs13f4B22rHZcGkDMNplnQ6C3GJ
         dHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787992657; x=1788597457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A4IwbgMrRyJTDKTZ/KQuUur9K0X+mbmrk/E1Z34LTpY=;
        b=VrTh4vU3HPsyMwu7Z7uDk0zg6aK7FIQQ/DhrKq4JSuuppuVbbHeLcVfbOMvEdRsEOy
         ha4ny3EBkS75jmGu89rvImFAFIZTLCYBbYIabCaGBC28aKnFaKjRRGr3VcMeHUgb8E1Z
         MlRlnwA4wxA2BlAlJxa8fdjmWBKc4Sam7aFCLybqQV4zggu9hXTynwQqB3lZlh2afHO2
         2AlgOnrRD+z/TRAceUHvX0sf2HgGS39+pWKZifQPKPsOheKVdlYw42LbzVM9ptKQ9Hii
         vujhB9nl6Q/QCH3UtZamoG3l8NN8vpoK/0Cjfz7608ShoPrAegT6Sqyli3V3dIShpsh0
         9A8Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1ID3DvqcAv44oT7QRgduyOR1B0PRjBW0zM1ixRWmrtRofiszNd6ZOsP1cR/zxLJFq1VI/Ug==@lists.linux.dev
X-Gm-Message-State: AFuF++mQGlYBO9WMouHNuw7x/D5vdGAP75IvK3UUfOjUh0Qx23xUOx3w
	4hz7CVb2qyUUCB9kS4XMgaxc9EU/nTm2eQ85Xt1RuXPlxY2U04Le2dJU
X-Gm-Gg: AR+sD11IcMZstWVuyOdVYylFheYSe/bIx5NlwbC8boqOjZfQfm3Q3jeiDRxa8x2cqch
	4zkxZ10hFOnrTBOdp5fsR+QNPwVN/V1fejN9y4V7GRBSqKkQCpXmyvXxlshBc9aAd11MTnQIMY9
	iI8dK4MrR3nXRuM/g0t73MEg8nw7TC26xHOqIKjxcAELfsJ0nC4Tg3txwXtaYkuS+B8i5kGiW4Q
	nyj89+epoWJHiTmbGUV5sePZEIa1fjXIDUuNGMJEPO2dmil+JIdFB2p1JsF/m2ONAjpQpMf1K+s
	d/OAMgZPDtFeBu1Yg555ZipkBnEYnBSbDZearG4SAGb51Zg8himtLVXHWZerRfHyJOEu0Avy2yg
	frQvkam1tG0kVbXTT0DmuZpugXP97IoNlNkbYxFJCYpg1y08OyNzFfNTgp3dwEicMErSzcmU37q
	yxIdqP0QCd1jLIsHqrSBjAHCMao6toMp+J0gMU/qZAMymMaE7xmSn3WrudewZhBJ+SE3A8q8mC/
	O6Ys8vIcCy6NDSazlcjD3U/WDfy
X-Received: by 2002:a17:902:ffce:b0:2d8:d4d2:dc9a with SMTP id d9443c01a7336-2d8d4d2dfadmr79579325ad.22.1787992656523;
        Sat, 29 Aug 2026 01:37:36 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594ffc94sm12819105ad.5.2026.08.29.01.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:37:35 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon: fix unconditionally skip last region
Date: Sat, 29 Aug 2026 16:34:26 +0800
Message-ID: <20260829083744.73299-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828182910.70304-1-sj@kernel.org>
References: <20260828182910.70304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 11:29:09 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 28 Aug 2026 16:47:37 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > Once quota set, the charge_{target,addr}_from unconditionally skips and
> > resets at the last region of the tracked target, so the last region can
> > be skipped even when it has not been processed.
> > 
> > Example:
> > 
> >     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> >     2. Quota is configured to process only 50 bytes per window.
> >     3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved
> >        at (Target, 50).
> 
> Cursor means charge_{target,addr}_from, right?  Let's explain that, or just
> keep using the terms (charge_{target,addr}_from).

Yes, thank you for pointing that out!  I changed cursor to
charge_{target,addr}_from now.

> 
> >     4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is
> >        full. Cursor is saved at (Target, 100), which is exactly the
> >        start of R2.
> >     5. Window 3: The loop reaches R2.  Because R2 is
> >        damon_last_region(t), the old code unconditionally returns true,
> >        skipping R2 entirely and resetting the cursor.
> > 
> >     Result: R2 is permanently skipped even though it has never been
> >     processed.
> 
> Let's make example simpler by setting R1 (0-50 bytes) and R2 (50-100 bytes) or
> quota size 100 bytes per window.

This is the updated example:

'''
Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 100 bytes per window.
    3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
        addr}_from is saved at (Target, 100).
    4. Window 2: The loop reaches R2.  Because R2 is
        damon_last_region(t), the old code unconditionally returns true,
        skipping R2 entirely and resetting the charge_{target,addr}_from.

    Result: R2 is permanently skipped even though it has never been
    processed.
'''

> 
> Also, it continues being skipped only in a corner case that the region
> addresses and the access patterns are kept.  So the user impact is mild.  Let's
> clarify that to not make users unnecessarily afraid.

I will add this clarification in the next revision:

'''
However, it is important to note that this is a very minor issue.  This
is because it is triggered only when the previous window saved/kept
charge_{target,addr}_from, and in the next window, all regions except
the last region were skipped by damos_skip_charged_region().
'''

> 
> > 
> > Fix this by only skipping the last region after it has been applied.
> > 
> > Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
> > Cc: <stable@vger.kernel.org> # v5.16.x
> > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > ---
> > 
> > Changes from RFC v1:
> > - Minimal fix, only fixes the issue where the last-region is skipped.
> > - Add an example to the commit message to demonstrate that this error
> >   occurs very rarely.
> > - RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com
> > 
> > ---
> >  mm/damon/core.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 644daf5a1656..21dc6b086c42 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
> >  	if (quota->charge_target_from) {
> >  		if (t != quota->charge_target_from)
> >  			return true;
> > -		if (r == damon_last_region(t)) {
> > -			quota->charge_target_from = NULL;
> > -			quota->charge_addr_from = 0;
> > -			return true;
> > -		}
> >  		if (quota->charge_addr_from &&
> > -				r->ar.end <= quota->charge_addr_from)
> > +				r->ar.end <= quota->charge_addr_from) {
> > +			if (r->ar.end == quota->charge_addr_from ||
> > +					damon_is_last_region(r, t)) {
> > +				quota->charge_target_from = NULL;
> > +				quota->charge_addr_from = 0;
> > +			}
> >  			return true;
> > +		}
> >  
> >  		if (quota->charge_addr_from && r->ar.start <
> >  				quota->charge_addr_from) {
> 
> As Sashiko pointed out, this doesn't work if the the last region's start
> address is smaller than charge_addr_from and the end address is larger than
> charge_addr_from, but the size to skip (charge_addr_from - r->ar.start) is
> smaller than min_region_sz.
> 
> As you replied to Sashiko, let's do the last region handling in every case.
> While doing that, let's do the charge_{target,addr}_from reset in only one
> place, like below.
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2688,36 +2688,40 @@ static bool damos_skip_charged_region(struct damon_target *t,
>  {
>         struct damos_quota *quota = &s->quota;
>         unsigned long sz_to_skip;
> +       bool skip = false;
> 
>         /* Skip previously charged regions */
>         if (quota->charge_target_from) {
>                 if (t != quota->charge_target_from)
>                         return true;
> -               if (r == damon_last_region(t)) {
> -                       quota->charge_target_from = NULL;
> -                       quota->charge_addr_from = 0;
> -                       return true;
> -               }
>                 if (quota->charge_addr_from &&
> -                               r->ar.end <= quota->charge_addr_from)
> -                       return true;
> +                               r->ar.end <= quota->charge_addr_from) {
> +                       skip = true;
> +                       goto out;
> +               }
> 
>                 if (quota->charge_addr_from && r->ar.start <
>                                 quota->charge_addr_from) {
>                         sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
>                                         r->ar.start, min_region_sz);
>                         if (!sz_to_skip) {
> -                               if (damon_sz_region(r) <= min_region_sz)
> -                                       return true;
> +                               if (damon_sz_region(r) <= min_region_sz) {
> +                                       skip = true;
> +                                       goto out;
> +                               }
>                                 sz_to_skip = min_region_sz;
>                         }
>                         damon_split_region_at(t, r, sz_to_skip);
> -                       return true;
> +                       skip = true;
>                 }
> +       }
> +out:
> +       if (r == damon_last_region(t)) {
>                 quota->charge_target_from = NULL;
>                 quota->charge_addr_from = 0;
> +               return true;
>         }
> -       return false;
> +       return skip;
>  }
> 
>  static void damos_update_stat(struct damos *s,
> '''

I noticed a potential subtle issue in the suggested fix above:

'''
+out:
+       if (r == damon_last_region(t)) {
                quota->charge_target_from = NULL;
                quota->charge_addr_from = 0;
+               return true;
        }
'''

If 'skip' is false (region should be processed), but it happens to be
the last region, the condition 'if (r == damon_last_region(t))' would
still be met.  This would cause it to reset the state and 'return true'
(skip it), which inadvertently re-introduces the original bug we are
trying to fix.

To ensure the reset logic is centralized and correct, I refined the fix
as follows.  The comment is intended to help you and other reviewers
quickly understand the rationale behind the compound condition.  I will
remove this comment in the next revision.

'''
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..82c5aed8a417 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2342,36 +2342,48 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
        struct damos_quota *quota = &s->quota;
        unsigned long sz_to_skip;
+       bool skip = false;
 
        /* Skip previously charged regions */
        if (quota->charge_target_from) {
                if (t != quota->charge_target_from)
                        return true;
-               if (r == damon_last_region(t)) {
-                       quota->charge_target_from = NULL;
-                       quota->charge_addr_from = 0;
-                       return true;
-               }
                if (quota->charge_addr_from &&
-                               r->ar.end <= quota->charge_addr_from)
-                       return true;
+                               r->ar.end <= quota->charge_addr_from) {
+                       skip = true;
+                       goto out;
+               }
 
                if (quota->charge_addr_from && r->ar.start <
                                quota->charge_addr_from) {
                        sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
                                        r->ar.start, min_region_sz);
                        if (!sz_to_skip) {
-                               if (damon_sz_region(r) <= min_region_sz)
-                                       return true;
+                               if (damon_sz_region(r) <= min_region_sz) {
+                                       skip = true;
+                                       goto out;
+                               }
                                sz_to_skip = min_region_sz;
                        }
                        damon_split_region_at(t, r, sz_to_skip);
-                       return true;
+                       skip = true;
                }
+       }
+out:
+       /*
+        * The last region may remain unapplied for extended period due to
+        * various regions (e.g., it is invalid or has been filtered out),
+        * preventing other regions from being applied (those preceding the last
+        * region and all regions with different targets).  Therefore, when
+        * encountering a region that needs to be processed, reset
+        * charge_{target,addr}_from.  If necessary, this parameters will be set
+        * to the correct value in damos_do_apply() due to quota is full.
+        */
+       if ((r == damon_last_region(t) && skip) || !skip) {
                quota->charge_target_from = NULL;
                quota->charge_addr_from = 0;
        }
-       return false;
+       return skip;
 }
 
 static void damos_update_stat(struct damos *s,
'''

> 
> Btw, I think damos_skip_charged_region() may deserve a kunit test.

I agree that a kunit test would be valuable.  While I am still getting
familiar with the kunit and it might take me a little time, I plan to
work on it.

Should the tests include these scenarios?  Note that I use 1-based index
in here since it is easier to understand.

1. Baseline test:

    - Parameters: charge_target_from = NULL, charge_addr_from = 0,
      nr_target = 1, nr_region = 3.

    - Expected: Returns false three times in a row.
      charge_{target,addr}_from remains (NULL, 0).

2. Skip test:

    - Parameters: charge_target_from = target[1], charge_addr_from =
      region[2]->ar.end, nr_target = 1, nr_region = 3.

    - Expected: Returns true, true (for region[1] and region[2]), then
      false (for region[3]).  charge_{target,addr}_from is reset to
      (NULL, 0) after region[1].

3. Split test:

    - Parameters: charge_target_from = target[1], charge_addr_from =
      midpoint of region[2], nr_target = 1, nr_region = 3.

    - Other: Ensure region[2] is large enough for the split to succeed.

    - Expected: Returns true (region[1]), true (region[2] first half),
      false (region[3] second half), false (region[4]).  Total nr_region
      becomes 4.  charge_{target,addr}_from is reset to (NULL, 0) after
      region[0].

4. Sashiko's edge case (Split failure on last region):

    - Parameters: charge_target_from = target[1], charge_addr_from =
      midpoint of region[3], nr_target = 1, nr_region = 3.

    - Other: Ensure region[3] is small enough so that the split is
      guaranteed to fail (sz_to_skip < min_region_sz).

    - Expected: Returns true three times in a row.  Crucially,
      charge_{target,addr}_from is reset to (NULL, 0) on the third call,
      preventing permanent state leakage.

5. Last region processing test:

   - Parameters: charge_target_from = target[1], charge_addr_from =
     region[2]->ar.end, nr_target = 1, nr_region = 3.

    - Expected:

        - Round 1: Returns true (region[1]), true (region[2]), false
          (region[3], resets charge_{target,addr}_from because !skip).

        - Round 2: Since the charge_{target,addr}_from is now (NULL, 0),
          it should return false three times in a row, proving that
          subsequent regions are not incorrectly blocked.

If there are any issues or missing edge cases in these scenarios, please
let me know!

> 
> [1] https://lore.kernel.org/20260828090410.40AEA1F000E9@smtp.kernel.org
> [2] https://lore.kernel.org/20260828115047.332978-1-aethernet65535@gmail.com

Best regards,
Rui Yan
