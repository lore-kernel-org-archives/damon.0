Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EAB4307B0
	for <damon@lists.linux.dev>; Thu, 24 Sep 2026 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236664; cv=none; b=F7VTyjivOTGlCYXcu+cynl7t+SQVrpnlEBxz7csMtUgJ3Evscw5fmrPqeWPWIacoCs2UZy2Mqch2n/aDPOHKRv4rQ+JnqWvnj2LfNIrO9tYKWQresLCSHhbP6YKSM9mY2A+TtkwwzGYKhRGpKxl81KOMqR4tbbP1Mj9UJiqoiBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236664; c=relaxed/simple;
	bh=H6mEPlYC/Zx2xm0YxomK8IB64DpKShzG1ZNf7mFzOLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvGgMrEDW2RUZG13nGFeEwuFfLKBCbRhsXG81PMlpRMIexixsuHUqwiejlv/W6M7+jRu37Etk9NO3ONVLtZc9SPBMWN8xxskHITbw9DluNZ8tPBAT2YoF6RtUlDobnhXjZocipLdvBzwjWLRYwLKta11m0Jno4zsJOKGNESyONU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qeMrHrD+; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qeMrHrD+"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso976448a91.1
        for <damon@lists.linux.dev>; Thu, 24 Sep 2026 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790236658; x=1790841458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxnh7K5pul4WrdHHRSoLszYKzHojdYKXEO6rx1LCqCE=;
        b=qeMrHrD+kyEK0ccnoGT3iEZ90tKIc8qW1owRrBrGAUMG7VReD/3Aslk+MV6nPEDZlT
         S5gyXJQLCR7EOqMIKvNoos8t4SfeqSDp6Jj99tvFUXTbHjuAARPrxs+Sj57+fJEBgW70
         cVCRcifoZTvFWTqCF19ns1HimZ/dqa7cq6k1ysAUSIHCGjiDXPw5Yh3iiHxWgVvD6A7z
         AcA3coWWy+Wo5J1gJNrI5v9Q+P9Ve4B9zuriivQutcxLOOiPnQ4MhEBbZFbUbS4USaX6
         Lk1aifVczwMSwrvkrTOFFw62Wbeseazv+Njk4i4KzaxJFSnea7ZQoevyuE1CVr/9cw/f
         lyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790236658; x=1790841458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hxnh7K5pul4WrdHHRSoLszYKzHojdYKXEO6rx1LCqCE=;
        b=SB2+A04jyMjCFFELJPDxg9G3l5PdT00u/Ho9CUrO+HGcfBomMwCv/PTPWB2WRQUwgZ
         t9PSCdrCs2KIkE47ltmKf6OOX6ks+TMFfLo480vnSiN2bfhcRwGWzD88HqKGdYL4yQPa
         p+iosPe2b+bCPP0PFuueqzFZmoTtULcfgELUS2H1joCoivXNpefAsDLrEtVGuolyDzXK
         QS8052qL4VKx/ShA5E6QUeFaz0uVdya1Fry6425Lr9iTQPk1T5EV2ZB7xJQZCcmXMP3h
         LsEjRav6Cl/HUJtvJX9RCG22AgEoYmiqF5gUzRSWLb/MSeFelEKT9iCp0KpLQtSmGRQA
         D/OQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW8dqyFZZGWR5cQsDZQk2TXn9o2NX6ENdc5W8Kn4WXcMZYmjsLMscooE3WdUAZ8akMuNpc2Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mLaXqeXeH+plZPsLED8iyKjiSX1WeZwSp8UBM391YDlgtLn4/Q
	VE+3JGcpTxUUKJOgHu+O2MPYV4Jmva4eH+Jfm2PWO8oUhL71j3qHPUVx
X-Gm-Gg: AYBFou1kxoVX89uhn25LzcyGiAuvjgRVqgsXhPS1o2daUDCoALPW4Fqk4/N08x+eqyP
	sNdA8NCRXfsucHKV0U7q2t5PbJqF4Lowsmq/bZvLzTgg2MBCzb8b7YxZuzxHrdqlvu+8wQihBJa
	EEA5TS0gtJzlfVyy3K+cF17IGDrgfeTq0yIG1f2xQyTbSUqCL8p3EZ+QmDpRIc2olaLOxgW8eRs
	sqeWcDjZl3HVBCgwhrecOusqhx42Smirdir3d7E9E7tUSl+whmGjzWBqRV3nUGG3hFQt+C/KYqm
	9h98CJ5ysclLTypHTX7Nnx0udhT1CPQhUPqs96YTX+YEN37fCQY1r68eF1G3geSGs2bWzvcli8d
	Nwh+xyHSg+7Fk1KpTlac+nEHENl6szpPJH6+AznnmSa8MrygiGlQXrvyXa05IIBxbk9WtV4ljut
	mASaWl+tpUrR4Z9Ea8T/kCgVdIaUjq7kZmaiVuECbt6/gd3EFTue/wbL2bOMJlQvWezRabo9vT
X-Received: by 2002:a17:90a:2ce6:b0:3a0:a055:1741 with SMTP id 98e67ed59e1d1-3a0a0552127mr323462a91.27.1790236658340;
        Thu, 24 Sep 2026 00:57:38 -0700 (PDT)
Received: from celestia ([2402:1980:867:387a:70b:38f1:a1dd:9303])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972eec92sm3573872a91.7.2026.09.24.00.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:57:37 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sj@kernel.org
Cc: aethernet65535@gmail.com,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RESEND PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Thu, 24 Sep 2026 15:57:42 +0800
Message-ID: <20260924075754.6839-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919190953.86705-1-aethernet65535@gmail.com>
References: <20260919190953.86705-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi SJ,

Just a reminder, I think you might have missed the question I asked.

On Sun, 20 Sep 2026 03:09:10 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Sat, 19 Sep 2026 09:07:25 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Sat, 19 Sep 2026 16:01:58 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > Commit 50585192bc2e ("mm/damon/schemes: skip already charged targets and
> > > regions") introduced a minor issue that causes the last region to be
> > > skipped before it is processed.
> > > 
> > > Example:
> > > 
> > >     1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
> > >     2. Quota is configured to process only 100 bytes per window.
> > >     3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
> > >        addr}_from is saved at (Target, 100).
> > >     4. Window 2: The loop reaches R2.  Because R2 is
> > >        damon_last_region(t), the old code unconditionally returns true,
> > >        skipping R2 entirely and resetting the charge_{target,addr}_from.
> > > 
> > >     Result: R2 is permanently skipped even though it has never been
> > >     processed.
> > > 
> > > Add a test to prevent this regression in the future.
> > > 
> > > Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
> > 
> > Other than a trivial style that I commented below,
> > 
> > Reviewed-by: SJ Park <sj@kernel.org>
> > 
> > [...]
> > > +static void damon_test_last_region_quota_reset(struct kunit *test)
> > > +{
> > [...]
> > > +	t = damon_new_target();
> > > +	if (!t) {
> > > +		kunit_skip(test, "target alloc fail");
> > > +	}
> > 
> > Let's drop braces for single line, as suggested [1] in coding-style.
> 
> I will change this in next revision.
> 
> By the way, Sashiko reported an issue [1]: min_region_sz is not
> power-of-2.  While this do not cause any real issue in this test,
> non-power-of-2's min_region_sz is not legal.  Should min_region_sz
> initial value set to power-of-2 value (e.g., PAGE_SIZE) in the next
> revision?
> 

[...]

> [1] https://lore.kernel.org/damon/20260919081239.8A3D91F000FF@smtp.kernel.org

[...]

Best regards,
Rui Yan
