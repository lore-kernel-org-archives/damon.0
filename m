Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFE334681
	for <damon@lists.linux.dev>; Fri, 10 Apr 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775814004; cv=none; b=PGzoNOueAEyMYDmxr+F0RNZX9zGvCk7PwABvZcWg8DsJ3259HCD7M1vqxLltaX6YR4Xz186OAEPcuj2CwhPxK4R0MqAnPiN4FhX3ENQlxh7lEpoLz9rvF8CTZrBdMs1VTxTRaO9GHuhV5BQu4iURJqg2fZ/0VWv0hiWcu9ppEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775814004; c=relaxed/simple;
	bh=PZsYwVjpKpX1Li0FeNPyCO9E3yVRuH5bIaQ1sC0jH+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG1cmO/kRErpTmPjD8q2pBzZX+/p9xEjzfxA2X8j2AKQ54+FUbV2AKCV2nGLFt5TidzvuUt6GwlK8xTZjzuaZseO1yI3xQKqw96uNrgqb8K3YhEJyDAiLxRAews7wr7MKAVe/S6rgRvCGK1et673txptxIzQxrsEw7lGiGKPYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oIIO6wkb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIIO6wkb"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so942737b3a.1
        for <damon@lists.linux.dev>; Fri, 10 Apr 2026 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775814002; x=1776418802; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99FMaXvDwUdtqA4Kvo6xXkRxUDamAjmOyuXrrlPWqrM=;
        b=oIIO6wkb/K418S9U18vYkII4DWBJpi/h796P4UqoygqXVXHYLDnLb8pbB/LsJVeioP
         PQaFgKMdwAzdvmFBBiptwnx6xS9/k95hVOndogppYP7RKbiopZqIq6gCe+1zQJoTO/ue
         ADPVZlDeRYwRI+B3XRdlFnZO2zF0LAbNwqGmpr2Ls6yXLfg7Fd8CUqP2ApgmBgqflbV1
         5Pcv2ZiE9+ofUzlYPvy4JRmuUpgkYOv+zWi94L8x1wg74W+UZFnCk1tMy9O420cpSv08
         pDkusi/B6rBCMfxLQ6dbBH94NbuFezaCNNOskUFsY4Dkcu9hdKIy/jWT9TiPOprjAg/N
         VedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775814002; x=1776418802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=99FMaXvDwUdtqA4Kvo6xXkRxUDamAjmOyuXrrlPWqrM=;
        b=n+bi9INRHzDLWTOwFEikhHTQ8VHTpAGGPPJ1l203tO8a59VQjsibnORDDnFTva6lfr
         AjzkHytlFQxWg+T51olunWMblVswlfGUNJS4Fn9fx9rYZ1DtuLJ9N/4IKcwrvUzac0bQ
         B3Y0yDFWu7d1KxUCnoiZ8omoj/ccFetOEyWRxnXQTmOsP4/3AOVS3xxIaFBUvpSMLEoc
         eJqD6GI8BWK2I3vrrNvIh3geYMORtiiS7qHexTpPxkb1tv1gdjXhb7+ok4i1cDkMI8Kz
         VCaEzoU74Pw5+ntM8nAQtEIIeiqe2hTNPpOhwsI2XMdnZLQLTNtfYecKLQJeZ2eOXknr
         AEqw==
X-Gm-Message-State: AOJu0YzkwkgBzOUSG5g/gm+jgg55hSInbdMHDze+pZ2+T3HDamMUapWe
	kmCVMKiN1C7Kxc6cNt/DWrlnqQmVVFnnNtf2JHpUREHUG6fytZD7z2uH
X-Gm-Gg: AeBDievtIZdXw1CcwoqKQuW4zvdb4VGAN3jyAXjc2wkiug3+yrSh2TN3iCu2MXi7hlF
	d6vr408rLwT2D7DsDnzTThdhSzwLw4lTDt7Gj5JVHlTGVtdQHzzRM5rxfm9w7qE65h1olXR8FTY
	LYzzJQt3yrM84PHyosk+FCJHuo0Ra6wG9LxZYq8aClveNrre5gQ508zkPW+07bs3UrvpjZfbjaU
	yfBAEh6yIhoZwjOp3XJ4NZc55XTk1d/giPW7p1PNXoKw7E2UP/YKDPewIgAGG6IyYvQoZ/gU+PY
	PAevjBsdyUbe80EuHuUTaodRi3GrW+IxsYSvSDo4kQ5xB4Kwlt7B4N2/576FBNU2VK//cd+1kIa
	lhka2FPOLNDRAyT0BFx/m/zQqgoy4GUqhwDCjxPoqx5vMYLpSiQmsHjt+v9hHAadvwiq823hyhe
	w/S4PrWdjeElUwMG1DZpRvnSQ+pUk=
X-Received: by 2002:a05:6a00:3a19:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-82f0c288c6bmr2738256b3a.50.1775814002219;
        Fri, 10 Apr 2026 02:40:02 -0700 (PDT)
Received: from celestia ([2402:1980:898b:301c:d085:a35:99e7:ffec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c52cf05sm2278831b3a.61.2026.04.10.02.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 02:40:01 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: aethernet65535@gmail.com
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org
Subject: Re: (sashiko review) [PATCH v4 1/2] mm/damon/lru_sort: validate min_region_size to be power of 2
Date: Fri, 10 Apr 2026 17:40:04 +0800
Message-ID: <20260410094004.193555-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410044259.95877-2-aethernet65535@gmail.com>
References: <20260410044259.95877-2-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found some issues.

Forwarding full sashiko review in a reply format with my 
inline comments below, for sharing details of my view and
doing followup discussions via mails if needed.

> # review url: https://sashiko.dev/#/patchset/20260410044259.95877-2-aethernet65535@gmail.com
> # start of sashiko.dev inline review
> commit bc048f9325d07815d621e80f3c40408c0210af75
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/lru_sort: validate min_region_size to be power of 2
> 
> This commit adds early validation for min_region_sz in
> damon_lru_sort_apply_parameters(). If the user configures an addr_unit that
> produces a non-power-of-2 min_region_sz, it immediately returns -EINVAL to
> avoid setting maybe_corrupted and unexpectedly terminating kdamond.
> 
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index 554559d729760..3fd176ef9d9c1 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -294,6 +294,11 @@ static int damon_lru_sort_apply_parameters(void)
> >  	param_ctx->addr_unit = addr_unit;
> >  	param_ctx->min_region_sz = max(DAMON_MIN_REGION_SZ / addr_unit, 1);
> >  
> > +	if (!is_power_of_2(param_ctx->min_region_sz)) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> Is the DAMON sysfs interface also susceptible to this regression?
> 
> When a user configures addr_unit via sysfs and writes 'on' to the state file,
> damon_sysfs_turn_damon_on() builds the context. The min_region_sz is
> calculated directly from addr_unit without a power-of-two check, and then
> damon_start() is called, bypassing the damon_commit_ctx() safeguard.
> 
> Since the DAMON core uses min_region_sz as an alignment mask in macros like
> ALIGN() and ALIGN_DOWN(), can this cause memory corruption or infinite loops
> in functions like damon_fill_regions_holes() if a non-power-of-2 value is
> provided via sysfs?

This issue has been discussed before [1]. While it's a valid concern,
it's outside the scope of this backport patch. SeongJae Park has
indicated he will work on this.

> 
> This patch works around damon_commit_ctx() failing due to !is_power_of_2()
> by performing the check early, but does damon_commit_ctx() still have a
> regression leading to unexpected termination if other allocations fail?

Yes, unexpected termination still exists.

This patch provides a minimal workaround for the specific case of
non-power-of-2 'min_region_sz', which is suitable for backport.

> 
> If damon_commit_ctx() fails midway, for example returning -ENOMEM from
> damon_commit_schemes(), it leaves dst->maybe_corrupted = true and bails
> out without rolling back the partial updates.
> 
> Even the DAMON sysfs interface, which attempts to mitigate this using a
> test_ctx dry-run, could experience a time-of-check to time-of-use race
> where the test allocation succeeds but the final commit allocation fails.
> 
> Since these modules operate under memory pressure, if an -ENOMEM occurs
> during parameter updates, will the running reclaim daemon permanently
> observe maybe_corrupted = true and unexpectedly terminate itself?

You're correct. If damon_commit_ctx() fails midway, it leaves
'maybe_corrupted=true', causing kdamond to terminate permanently. This
is a core error handling issue that needs to be fixed, but it's outside
the scope of this backport patch.

> 
> >  	if (!damon_lru_sort_mon_attrs.sample_interval) {
> >  		err = -EINVAL;
> >  		goto out;
> 
> 
> # end of sashiko.dev inline review
> # review url: https://sashiko.dev/#/patchset/20260410044259.95877-2-aethernet65535@gmail.com

# hkml [1] generated a draft of this mail.  You can regenerate
# this using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260410044259.95877-2-aethernet65535@gmail.com
#
# [1] https://github.com/sjp38/hackermail

[1] https://lore.kernel.org/20260403155530.64647-1-sj@kernel.org

Best regards,
Rui Yan
