Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D6490C1D
	for <damon@lists.linux.dev>; Thu, 27 Aug 2026 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854099; cv=none; b=dcuRaEiHBLNRfr7Y2FPif6ZiqK+1Z0rVojRop6PfCJwC71QTsQR5HuoquHQTJm0IL7MpuDrYfu+hcIfWUmCmCOnyGDmZYMSimwECyVbKL3Ukxp4LWoYudj3sScRXrvCJrdKbqm5wz7kLCzrHwaT6Grrg/3SsBBShlRdb+qcJQ+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854099; c=relaxed/simple;
	bh=ArT4A9LnLuUwhgr/cxAD+B5AibwuMzq9queyu1Qs/hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0hLY1DL5uLSEEvpxLRxXLFbNazeI/q1RRbsTziAEhhtHmXtYrm1v9EUUdcwNA2mCFr33FTaaNwV4sl/aQj4DCrqvWZlPO3qAcQTzoGumIx1+G0YTPi4eoKd0A81Qs7GsYWQUvf+fX0jpYvlJ21jSC3CRdjSGidr/KOtaSSZr+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvs92ic8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvs92ic8"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so265317a91.3
        for <damon@lists.linux.dev>; Thu, 27 Aug 2026 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787854093; x=1788458893; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plMv1alWLSmRUs996GTzyKVxl/InS+Hvvr87SnLX3mc=;
        b=qvs92ic86uLFSkxYDTQNVw1fGkF/48yO2yDAi0JiHk8qdCj9Sz2bSSOVR7rSXaPdOY
         uRotmVCUZ8pJ/u2zlQhHp5JRqeAqw5KsfCiwF4hl0tooCH24Hd++bWm97xUoxolWoEKP
         eISyrb5gHOSplBM8txuGEZhx+f8pks1l/8/tdL3PJ15tFdcvqBG+20VPXvxmBZsM7dcX
         e5sTsE1d6VC/tFeNSc7fPO5rpL4RBDDXPq+Mji6YeL+6mu6dgsZWRJQM1b2I6TbSqV/b
         RDuFc1RRt77S0hlZxxqNl+4weJlfQbrI9ATOMav0zN03KB7ofrMpuAiUddQ2OeKGjaeF
         cB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787854093; x=1788458893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=plMv1alWLSmRUs996GTzyKVxl/InS+Hvvr87SnLX3mc=;
        b=jFRPPBDTd5IALVWIDHKNQHSHsbtonuf4RhIS79CTTHnCuqsoP6/xLuG8psHCTNGuGu
         WbvoLrjiaL2kwpI0Vsz+yAdKeJFXtAoDEs1XmpRQjfBGq0tROsJN9smTtkgaV0vjoQh2
         jNAp34d920L6qJQ3KV7OJZ++yfTQ8BA0M+E73vUolUUW5MyxI08hF4R1Yy4jxoNxY9JD
         hoExgjmooxrQ2lF08Me2q74SVms9YqYgAQSx97K59OgoAeIET6fhmcWIu1wRKeb1XyYk
         By6NzQ0vHDUmJ3leQAWWTpXfToF7urcSstcXc6OFq815paFupRmewchGgYiz8ZhUK6Oc
         OZKw==
X-Forwarded-Encrypted: i=1; AHgh+Rq0M/UqJS5H1ptMDKcKwJdLOWoCsoC1oshN7J1oYcKx/A2bwqoZ5lf8lvL0ItPBmGLptvpBhw==@lists.linux.dev
X-Gm-Message-State: AFuF++nxooK447I50SzChuP5Pe+zoaKGG4aDFIEox+DTd0GNm5mQ4j5w
	WsN+edYQIcBE5vtTvM8eIOtDtI9uLh1umpgNIG6jAIDmQK5gK7jrf+Y1ffF9Mg==
X-Gm-Gg: AR+sD107UWsiLFIfG28X87k33IsT23HUhUree7gAES0B+W6dSkTeG5/0+GHi0gtIcJi
	QJ1iKvMMd4sg7cQLnwygu8UGuyD7S0EaByjal9J3CW/OlhVibUol4PNMCMm4VLjghtVOpoqzbNJ
	oed9Li+paEpk/bgpy8UDUQH3dFR6JKQt5UZzhiYl1gMbjbk7vha+Rp9s4aYoJJqvUjSNhXKHarV
	BisBv04kVwGqqZ9T60RZlfwtFbU1RiBIdpl5IrMUTKjUVlyDkeENz3zxlVp4god+T3yL6zoBPW5
	4k3S8bSmZFkCqBM4stfqN5vFHAnwP7gyEm0AXcl2VRTvGPv922oG914awPHI8MwZOpwxSIj425r
	yVlljxZnKJP7RgEYBdSDbrZCdMzguk22PeQac6UjhTOqkuOAPktB0mlR24wjHJE7y4gufzy4Bi7
	nDcBGps9w+idbK3g4Ad6pEr4xxImmGSg5WIChvBAiS1QJtf/dlrQ1MmxtMup+n8tMhJXyz3rXQK
	TRVlxJBav5NRamebes=
X-Received: by 2002:a17:90b:440d:b0:38f:bbc:6a0f with SMTP id 98e67ed59e1d1-396d0e5f35fmr1346864a91.1.1787854092659;
        Thu, 27 Aug 2026 11:08:12 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d80008sm3682194a91.6.2026.08.27.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:08:11 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Fri, 28 Aug 2026 02:08:22 +0800
Message-ID: <20260827180822.4037-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827004438.82746-1-sj@kernel.org>
References: <20260827004438.82746-1-sj@kernel.org>
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
revision, I will drop this changes and focus on the minimal fix for
Problem 1.

Best regards,
Rui Yan
