Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFD2628D
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882064; cv=none; b=GemcuXmbvyiPBWXQIwpHSEb/GgqnbWl31Z/hkfFwkl9FTKi2KSv2FceqLcXEG8HPM5pq+fdlVhJytwZig03UahfemLvLSvZgNUxpJI0s4sSzeW+Gl9ZNwBcvaN+tkubQyAg5/UOGdthIYr6cx0jI0OTlJ8sqXFl80p6HH2xAc08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882064; c=relaxed/simple;
	bh=WgDaZMAxyleJ8NRjkYHlGR996RTyM8XrdfZXTCw4nn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtckIghj1ADDcRgooQ8P8u717VfxASEwm2V+2sELO6ohoOKACqNx35LQ6+2rHBYBLItg1IRxeLHlKK+Zz6KCkYhE7aSG7cYjYgmTNwctq3Ksoa4FwIuNXZ7miQ2Ow8kLAhpS1urNlF0CzxgD4IjHIsznSi1MUZPX+6iPJhncnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoUSXvDN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoUSXvDN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-854f8068301so396418b3a.0
        for <damon@lists.linux.dev>; Thu, 27 Aug 2026 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787882062; x=1788486862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vd9OkwVydrqNipxeyj51CTYPIro5FcNJ7G6Zlk0IYLY=;
        b=PoUSXvDNnKEohv+QvY/qNPxmO35QexIhhaK6LzTKZ4NeXwwEXN4fjEs4cxEdLDyEFb
         Wic1VHPkhaEfSeLdCeTPAX3p1+VUdDdHMSDSTHFhFBZhNckaCm+Yj86/LkizNUaaNaXs
         QYNkJ3pathytgatoPzPZJA3Mz168NNUQMkGZbG6LFR66NOXwF1QRW69XvyPbmLXyUYfD
         TqC+vWlruiJpD55RK4d764obKJuK36/Z2/kSZKOK6bp++qXI0wp809oKZzKh8H55D21R
         fcjJ98DnVOSFLeoWLkzz018MGmK8TLLXGFm0gJpcfy231bbP5mqUtPALE4Z1bF9koloF
         sHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787882062; x=1788486862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vd9OkwVydrqNipxeyj51CTYPIro5FcNJ7G6Zlk0IYLY=;
        b=KyXYOQ74Mw1FXaXYllKg+ZoZrl9h1+Ci2QtMyOfImHhMCETcm0gCTSIvROJnRyaaji
         ES1Mw1xvuJbZ3iy87woJB7a1TWne/a9N2crEqGL8bzbFTYQJNlC/AGSkc6nqSVMx44sF
         tKkX77XxleU+vCiNkYAaoP/iHf671E8H3F2lrx/ihvuV7seCcBpFTrDN6ZObVzfXs+VN
         4GDQCEzkUOP2hDeSzsQUIcSDNHVdKaohuwo3um1iB97ubjvn8aF2x0aXvF7KemjVoaEJ
         BDsjnVgOg6W6E0ibCkvXIRs1eZktvZs0huampQJybSHuP1mcAobaasjZWs5E6lrmanqF
         Qokg==
X-Forwarded-Encrypted: i=1; AHgh+RpOxY0o+4WVlVvVypPVUg6YAxKCfZYU2WIfmgYwCTXGQUVbM7zlMsp/FUQPtFA/r01NMffpww==@lists.linux.dev
X-Gm-Message-State: AFuF++nvS0icQ0NO46y35uemSfybIphj9MDXBf4u+AaVfn/YHTyvDRFc
	u9MtFJww7cZrTJoYEMZxjqwCw98I7iouf6p3cKBCuloweVrGC83ow9Tc
X-Gm-Gg: AR+sD12Ajmk+oC58ZKb1h2G+LN8vsoJa6WIV/w/zSsOJOv6BkgiLq2o/eip5iZ0awuv
	p66h86yrnUjEMApvB51Zm9FsExv7q5QxwSqfg9cfgLcSQvzZXwaBa6HaCy8dSbHy8RRp9YSRc+n
	meHldO1kCc2vhx+V+ihHIfImIG1aysnZgF2gFQ2SHt6o6liyQVhrw0jodEJEZ2a2ELuTX+Xo4qj
	S0z+WsdqUhkQbhmRB0PEhb+batsTJzfITSlHWdXIgAzPXux3We0VHQr5sh9huIxEA/wZM/nozi/
	K/7eg8ZcbnPxd2tLvno3yXYBLPsUKQtcYcRSOskjYuRDh6FtmumtaZhnzaR2fsJ6UTVLhxaL/t2
	eHlpMP/Uzl09OKqchLTpfi40rNricaaSXO3AYaFAEOeLsT0ABJzB0wsdDm/Lg6MYkrOjC2j0n9C
	cbmvfvrSYcL9Duizewpa8xlLfYHISQ4cI6zfWO5GekuzrNCUVzdGPiwNd/nacb1AMLnA==
X-Received: by 2002:a05:6a20:158d:b0:3c8:d3a4:7b40 with SMTP id adf61e73a8af0-3d266ebcbb6mr5931228637.2.1787882061816;
        Thu, 27 Aug 2026 18:54:21 -0700 (PDT)
Received: from celestia ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f3312146sm58242a12.8.2026.08.27.18.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:54:21 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon: fix damos quota walk-position tracking
Date: Fri, 28 Aug 2026 09:54:29 +0800
Message-ID: <20260828015429.131338-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828004049.62386-1-sj@kernel.org>
References: <20260828004049.62386-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 27 Aug 2026 17:40:48 -0700 SJ Park <sj@kernel.org> wrote:

> On Fri, 28 Aug 2026 02:08:22 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> 
> > On Wed, 26 Aug 2026 17:44:38 -0700 SJ Park <sj@kernel.org> wrote:
> > 
> > > On Wed, 26 Aug 2026 07:05:08 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > On Wed, 26 Aug 2026 18:24:13 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > 
> > > > > On Tue, 25 Aug 2026 06:54:57 -0700 SJ Park <sj@kernel.org> wrote:
> > > > > 
> > > > > > On Tue, 25 Aug 2026 20:46:16 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > > > > > 
> > > > > > > DAMOS uses charge_target_from/charge_addr_from to remember how far a
> > > > > > > quota-limited walk has progressed.  The current implementation has two
> > > > > > > problems:
> > > > > > > 
> > > > > > > 1. Once set, the cursor unconditionally skips and resets at the last
> > > > > > >    region of the tracked target, so the last region can be skipped even
> > > > > > >    when it has not been processed.
> > > > > > 
> > > > > > I don't fully understand this.  Could you please clarify more?  Maybe adding a
> > > > > > realistic example scenario would be helpful.
> > > > > > 
> > > > > 
> > > > > Problem: Unconditional skip of the last region
> > > > > 
> > > > > In the current damos_skip_charged_region(), there is this logic:
> > > > > 
> > > > >     if (r == damon_last_region(t)) {
> > > > >         quota->charge_target_from = NULL;
> > > > >         quota->charge_addr_from = 0;
> > > > >         return true; /* Skip */
> > > > >     }
> > > > > 
> > > > > Scenario:
> > > > > 1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> > > > > 
> > > > > 2. Quota is configured to process only 50 bytes per window.
> > > > > 
> > > > > 3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved at
> > > > >    (Target, 50).
> > > > > 
> > > > > 4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is full.
> > > > >    Cursor is saved at (Target, 100), which is exactly the start of R2.
> > > > > 
> > > > > 5. Window 3: The loop reaches R2.  Because R2 is damon_last_region(t),
> > > > >    the old code unconditionally returns true, skipping R2 entirely and
> > > > >    resetting the cursor.
> > > > > 
> > > > > Result: R2 is permanently skipped even though it has never been
> > > > > processed.
> > > > 
> > > > Ok, makes sense.  The user impact should be not that big, though.
> > > > 
> > > > > 
> > > > > To fix this, the patch advances the cursor every time a region is
> > > > > walked, regardless of whether it is applied or filtered out.  This
> > > > > allows DAMON to accurately track whether the last region has already
> > > > > been visited, eliminating the need for the unconditional reset.
> > > > 
> > > > Sounds like a big change compared to the problem.  Why we cannot modify the
> > > > last region case?  Have you also considered other possible simpler approaches?
> > > 
> > > For example,
> > > 
> > > '''
> > > --- a/mm/damon/core.c
> > > +++ b/mm/damon/core.c
> > > @@ -2686,14 +2686,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
> > >         if (quota->charge_target_from) {
> > >                 if (t != quota->charge_target_from)
> > >                         return true;
> > > -               if (r == damon_last_region(t)) {
> > > -                       quota->charge_target_from = NULL;
> > > -                       quota->charge_addr_from = 0;
> > > -                       return true;
> > > -               }
> > >                 if (quota->charge_addr_from &&
> > > -                               r->ar.end <= quota->charge_addr_from)
> > > +                               r->ar.end <= quota->charge_addr_from) {
> > > +                       if (r->ar.end == quota->charge_addr_from ||
> > > +                                       r == damon_last_region(t)) {
> > > +                               quota->charge_target_from = NULL;
> > > +                               quota->charge_addr_from = 0;
> > > +                       }
> > >                         return true;
> > > +               }
> > > 
> > >                 if (quota->charge_addr_from && r->ar.start <
> > >                                 quota->charge_addr_from) {
> > > '''
> > > 
> > 
> > Thank you for the example!
> > 
> > While your approach works, I am curious, why should the cursor be reset
> > every time the function returns false (does not skip)?
> 
> It doesn't.  It resets charge_{target,addr}_from only once after the regions to
> skip are all skipped.  Am I missing something?

You are right.

My concern was that the current
'return false == reset charge_{target, addr}_from' might be a bit hard
to understand.  However, I realize that my change was quite significant.

To make the existing logic clearer for future readers, I think adding a
brief comment would be helpful.  For example:

'''
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2368,6 +2368,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
                        damon_split_region_at(t, r, sz_to_skip);
                        return true;
                }
+               /*
+                * Reset the charge_{target,addr}_from so that the remaining
+                * regions in this/next target can be processed normally.  If
+                * the quota becomes full later during the walk,
+                * damos_apply_scheme() will update the
+                * charge_{target,addr}_from to the correct position.
+                * Otherwise, it implies that all applicable regions in this
+                * target have been processed.
+                */
                quota->charge_target_from = NULL;
                quota->charge_addr_from = 0;
        }
'''

If this is not necessary or redundant, I am perfectly fine with dropping
it and just applying your minimal fix for the last-region issue in the
next revision.

Best regards,
Rui Yan
