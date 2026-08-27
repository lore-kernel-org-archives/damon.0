Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA8303A37
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 05:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810060; cv=none; b=oHxWklJ1VXEAz+r5USc2CKgyTb7GVewpO+6t+4V4906iFSMlFU85JgMwD45P6E0HcAFSfczf6wZDzt8RgsjAZ3t3uO/b25bOwJAqwpX3U/GWnFlgVhojyjBGOr19JSfg7G34as/4C2n/2wbFz6Y55zct0KPnzB/PROakKZfOfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810060; c=relaxed/simple;
	bh=fez0YwzSVBn5tO9zzq6eY6fAetQpiAth7VVLFi/VlxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZJpQEmOMtrDDmc+YqYjrIupBAOt4e8K6o7ZG1IH0poyTLXPp8ETg0hmt+wWf+LuYMJOGBzx+9xc7Ttn4XZzQbEkFJ7DNgzrtG4mWGAKxiO+V1OyUG92XXQsjOUgnRLCktt6ruOu0jitz8q5X2uGs3Wh7ViE542kAy6487TAKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEowsWl+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEowsWl+"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caea3f742bso5824435ad.0
        for <damon@lists.linux.dev>; Wed, 26 Aug 2026 22:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787810058; x=1788414858; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=plMv1alWLSmRUs996GTzyKVxl/InS+Hvvr87SnLX3mc=;
        b=KEowsWl+J8/T7whnywNiQiDAjohOM90qNtbQu8HMdZ9uP1eJCrG7qkJ9JfP+4pQQHT
         ybl6j4MYH2j5x8nKRVaIRwMTvPqt+4795wGdJMtc13AAzCUjS5SFSYUQlYYQvmgr4lOd
         RIPRcphVy7UDq54pIqtTqi6eoL2ehkcUdHV1uyuUgFr1+xf+3ztla28fzhWTjmdHLC1P
         M+yJnKGIaQlI+pGfAhaNlUS+nxHDJdXXpOlYMOoYRRUQIfTZIqSMA16gnifTekviHAiK
         u+MQwM2HafphMnPJugqdvAPFJ4JKhMp4RZJyb/1mgXbKctBJrjKWCwpcGhSKY1IDCusX
         JJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810058; x=1788414858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plMv1alWLSmRUs996GTzyKVxl/InS+Hvvr87SnLX3mc=;
        b=PHUpsN8CxLL5co4vlovEtysv3ffZuTrLJ9d5JZ2IeDrfBOC3kE4NWZGbas/wzZa16W
         iIkcuQIDhAcdItMq2L6XVFb11nKhTihwtzlyABbIzNs7DljPyJURXL5my5W074r5nHex
         3pncyxqsLV8UDlHfgWl22Yt4MqD9S4y1EEZi3pCkEeCcB2aWvg4oBYuiQupjGWBxd/Lt
         ayuSH/KX3c4hEHRr9YLd3sP1NiC1CffYM7fHL2yFqIi4gcxi56kk+1QTlJXaoSGklBL0
         9VU/LmNA4nLOXTMo0ykqwP4ci0SaCX3Koa2uBa4GsLoS6e0SJEv/4t8B29A0SuPuPlnX
         CWCg==
X-Forwarded-Encrypted: i=1; AHgh+RpRIZjW1PDcF586Fbrw2oaliH6BnyBzCAe4NZxK3ddtaZsg0vztIccL4I1OJ0qwGv61HcSgaw==@lists.linux.dev
X-Gm-Message-State: AFuF++muYc1XdgIeylIFNUfX6F99mLZTm+e4vpGsUSj3vJ2S8BE3G+bL
	Ph4IF1QBMiWlBOiqQmppm1DPb6IHwX+pAEFHjd45PDD1oRCgqJvQmm3v
X-Gm-Gg: AR+sD13v02uZveVG+JhOO+pZhVTM1GqLnfz5AHvRN9Ea38IbJYfmsp38j+YiIhp7zfx
	bqPWvsS+7KWis8NWbGb/Kf4kfUgyaLOcRVPHl0twWwvORwXucZBZYBUdNsseAogmWcKhGw7vi/j
	bQ/4iNbVBSSceaKETv0liC39XEmcvHSq+7+VFUIYnn/jMpSgtd02R4nt3zN6bJRcy5SZblCdNqY
	aNaRzd5PatDmKFZnZxiOQOsU3AWr329v9JFt//1qsYAh0XIrP6DZhq8h+1XKa8MQ+B8eFt6Ik3S
	sP5ec/K4e6ppr27z8aMX1PAKMn+Hf5dSQQ1DnfqXaduaAabRIRO4hSPx1FDhcK/V6MEgr1aqiM+
	C+4xCE26L+Ez6DFFwKBHY7AT9tXYJ8rmPV8Lwi3lNmmwuLkWXUaDp1ppdw+GALzYSLhjvRcE4Tf
	nKZDSub0CPjzJCkRP5vTk/G1XDdjU97kymRJ1E5C6PuMEIl0XVAuzOXx80nF5V9kSm0rc9LCCrb
	uOZ
X-Received: by 2002:a17:90b:17d1:b0:38e:8300:af51 with SMTP id 98e67ed59e1d1-3966d20b09fmr23255966a91.8.1787810057653;
        Wed, 26 Aug 2026 22:54:17 -0700 (PDT)
Received: from celestia ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b112b57bsm1361107a91.17.2026.08.26.22.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 22:54:17 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Thu, 27 Aug 2026 13:54:26 +0800
Message-ID: <20260827055426.16874-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 26 Aug 2026 17:44:38 -0700 SJ Park <sj@kernel.org> wrote:

> On Wed, 26 Aug 2026 07:05:08 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Wed, 26 Aug 2026 18:24:13 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > On Tue, 25 Aug 2026 06:54:57 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > On Tue, 25 Aug 2026 20:46:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > 
> > > > > DAMOS uses charge_target_from/charge_addr_from to remember how far a
> > > > > quota-limited walk has progressed.  The current implementation has two
> > > > > problems:
> > > > > 
> > > > > 1. Once set, the cursor unconditionally skips and resets at the last
> > > > >    region of the tracked target, so the last region can be skipped even
> > > > >    when it has not been processed.
> > > > 
> > > > I don't fully understand this.  Could you please clarify more?  Maybe adding a
> > > > realistic example scenario would be helpful.
> > > > 
> > > 
> > > Problem: Unconditional skip of the last region
> > > 
> > > In the current damos_skip_charged_region(), there is this logic:
> > > 
> > >     if (r == damon_last_region(t)) {
> > >         quota->charge_target_from = NULL;
> > >         quota->charge_addr_from = 0;
> > >         return true; /* Skip */
> > >     }
> > > 
> > > Scenario:
> > > 1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> > > 
> > > 2. Quota is configured to process only 50 bytes per window.
> > > 
> > > 3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved at
> > >    (Target, 50).
> > > 
> > > 4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is full.
> > >    Cursor is saved at (Target, 100), which is exactly the start of R2.
> > > 
> > > 5. Window 3: The loop reaches R2.  Because R2 is damon_last_region(t),
> > >    the old code unconditionally returns true, skipping R2 entirely and
> > >    resetting the cursor.
> > > 
> > > Result: R2 is permanently skipped even though it has never been
> > > processed.
> > 
> > Ok, makes sense.  The user impact should be not that big, though.
> > 
> > > 
> > > To fix this, the patch advances the cursor every time a region is
> > > walked, regardless of whether it is applied or filtered out.  This
> > > allows DAMON to accurately track whether the last region has already
> > > been visited, eliminating the need for the unconditional reset.
> > 
> > Sounds like a big change compared to the problem.  Why we cannot modify the
> > last region case?  Have you also considered other possible simpler approaches?
> 
> For example,
> 
> '''
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2686,14 +2686,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
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
> +                               r->ar.end <= quota->charge_addr_from) {
> +                       if (r->ar.end == quota->charge_addr_from ||
> +                                       r == damon_last_region(t)) {
> +                               quota->charge_target_from = NULL;
> +                               quota->charge_addr_from = 0;
> +                       }
>                         return true;
> +               }
> 
>                 if (quota->charge_addr_from && r->ar.start <
>                                 quota->charge_addr_from) {
> '''
> 

Thank you for the example!

While your approach works, I am curious, why should the cursor be reset
every time the function returns false (does not skip)?

In my opinion, a cleaner and more deterministic approach is to reset the
cursor only after the target has been fully iterated through.  This
separates "skip" logic from the "state reset" logic, making the flow
easier to reason about.

Here is my proposed minimal change:

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2347,11 +2347,6 @@ static bool damos_skip_charged_region(struct damon_target *t,
        if (quota->charge_target_from) {
                if (t != quota->charge_target_from)
                        return true;
-               if (r == damon_last_region(t)) {
-                       quota->charge_target_from = NULL;
-                       quota->charge_addr_from = 0;
-                       return true;
-               }
                if (quota->charge_addr_from &&
                                r->ar.end <= quota->charge_addr_from)
                        return true;
@@ -2368,8 +2363,6 @@ static bool damos_skip_charged_region(struct damon_target *t,
                        damon_split_region_at(t, r, sz_to_skip);
                        return true;
                }
-               quota->charge_target_from = NULL;
-               quota->charge_addr_from = 0;
        }
        return false;
 }
@@ -2658,18 +2651,26 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
                if (damos_quota_is_full(quota, c->min_region_sz))
                        continue;
 
-               if (damos_skip_charged_region(t, r, s, c->min_region_sz))
-                       continue;
-
                if (s->max_nr_snapshots &&
                                s->max_nr_snapshots <= s->stat.nr_snapshots)
                        continue;
 
+               if (damos_skip_charged_region(t, r, s, c->min_region_sz)) {
+                       if (damon_is_last_region(r, t)) {
+                               quota->charge_target_from = NULL;
+                               quota->charge_addr_from = 0;
+                       }
+                       continue;
+               }
+
                if (damos_valid_target(c, r, s))
                        damos_apply_scheme(c, t, r, s);
 
-               if (damon_is_last_region(r, t))
+               if (damon_is_last_region(r, t)) {
                        s->stat.nr_snapshots++;
+                       quota->charge_target_from = NULL;
+                       quota->charge_addr_from = 0;
+               }
        }
 }
'''

> > > This patch ensures that every target is traversed sequentially and
> > > deterministically, even when the quota is set very low.  I omitted this
> > > benefit in the initial problem description.  If you think it is okay, I
> > > will add it in the next revision.
> > 
> > What's the problem and benefit?  I still don't get it.  More clarification
> > would be nice.

My original idea was to ensure that every target would be checked
sequentially, which seemed like a fairer approach.  However, upon
further reflection, I realize this might not offer tangible benefits and
could introduce unnecessary complexity.

Since the DAMOS Quota min_score mechanism already ensures that regions
truly needing action are prioritized, the current behavior (eventually
resetting at the last region and moving on) is functionally sufficient
for typical workloads.  Therefore, I do not see a strong justification
for this change at this stage.

Thank you for pointing this out and pushing me to clarify.  In the next
revision, I will drop this changes and focus  on the minimal fix for
Problem 1.

Best regards,
Rui Yan
