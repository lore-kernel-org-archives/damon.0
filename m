Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B13F6C28
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179315; cv=none; b=mP0AVeTFd23kzwCV5MKdwpYZi5hHKT8P5U/DQmEdhsuNsHFHnCHaXtjXFnqOw74TM9Pcq+O34+NRiH3GqCn7Lkv++RKnQsk97/rF7nTwFdjeOM91BjgPG5RkZFN0ekqfJ7uZ8R4FvFqIWjlFutOE6EDUqYHfB9v7E67ZRSO6pHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179315; c=relaxed/simple;
	bh=ZKp4/QBeYSAV2k9bPiW/sTkKtSRTNNMONHn+AGg4GEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMKfjFVeCah71AThGw4/Ge2NN0ZiR6uX+5tWIK2moagbQAEJ3O+aatlFSKPoxUFj9xFXqGHdBzx48JLzNr1jd4Ny6EPRRwLL6CsJq7Edygia9nO4VJVOPA30juQ2tdYXTITGJrRra0mepOfu4K6Rsha9hbiTC0k/FckczTzLDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OESiEI3Z; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OESiEI3Z"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d6efd73032so36611175ad.0
        for <damon@lists.linux.dev>; Mon, 31 Aug 2026 05:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179314; x=1788784114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2jyu9EWq7gK0JjEZiz+ImWml7ed1HDT5ZIEVxolEFw4=;
        b=OESiEI3ZB8xgY3FbC+yzVD1agEkuO8Kcxq8/M0kFJwBlcDkZ48yPl11dqjZFlpUKob
         qDpziCXmcuE9lD/mkmZ5I+3BOwaQI/WW4FIfoshHwsPx137eov61LK+wU/bdmcR5jjYq
         FPVAyvVisyQp0sHRkKYnIMNWvX7wbw5RPb5F7yFwdbm6agUpt9tKNuiTKHY/t52NtiGu
         37kPDK5xai3J3Bh1LJBtmVU7U5R2O4TL40y3W5W0xz5X11R9D862JbeH19CFIGHwN0fP
         i4hQtqHlejc4hrKtKq/qtyk7Cm7OkSQv3PI+1XYo1wytZsIMmom4hN2Brg69ds/KoWBR
         MiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179314; x=1788784114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2jyu9EWq7gK0JjEZiz+ImWml7ed1HDT5ZIEVxolEFw4=;
        b=l3k7PAwED0+fnw8eS0T1EiPZ5yV6UWheMx5QVz/5zzpIeMp06zpyilg7Co7+LOobd7
         DEBiKrBvjrYNZAmml2QyN/tiVQ7VV7OaTVU8r9E2xKYvOt4QLPK/JeMvlhikjCHey2OD
         j+oJnxY8WfJJR9pC7ZK7rdbyPVq4UDHAxiYbVXZcqVr/NRtkfNtJnjGsTeIwGUpSFIFD
         ZnkM7jWWkLCPel5Aftha3clrwLmh9xW/+oGErX4b1uReNz/4kykUznCETh6gxL0nrduM
         UXFDC6k66RaVjvxRsdhvKO9w2JUjzqPea+3jjcCpWYxCr+K6LF9r05FFhsivIdXOZNtq
         tH7A==
X-Forwarded-Encrypted: i=1; AKwUvBxwmpVpkTCY7EjQGmOm/y1Hv2oqQf40I7DfbzUOWnKkBKahjKNV8562wJ6S/VgueOkBkEv/jg==@lists.linux.dev
X-Gm-Message-State: AFuF++n9O5Bh9XGBIIfB/UaaUQ6V3ggg/TbSHRxeSMTFQlrvt3lSlftW
	ty6aD0Ucr2niVmUQ2mCsdTEckMFzgyY9xaNqLJB7Vfs+5CeWC1KWP6sY
X-Gm-Gg: AYBFou2RhJqRAjoBOebwdbSqRtAHT9HCsGGcFNnooBv9OyHEX24Xb7WDbgs6s9MBzMa
	qJuGxcN+iPMxlVNvKFOBfIjTaamj4cydUbJLthbay1ub6G/BP8YWcCZDti1vgCO91qLgsbC5133
	uN7G07MSBb6VvMU/kWlxFs79sv2tW5+Vo2m0q1PB4vGpvpPKO3DFb+chfSNBR/cak0557geSHkx
	Y/fOjTZMsKpjWXoiDfogzHG+BeZuIGWqWCZjxdH8qHK6WstS4COcf4hlQold131Mma29LEvpEsI
	LbXEH4EjnDXw/FOeCNKYRN4Qh+QBiF5qh2yXF2YWkUMOIFycalHX/14TDD9pJIhqTiABB7NGgYf
	G+5gfORq3dguvaRZri90T7qxQIWDAFBqtfzucd2N8HSB8p4n99p51tDtVZNKTPezSMRSIn8IzTQ
	EqSn4/XTOuIGo0he9f1eggbVgxW8IXloK12SE2sNVoT6gRxa+1IH6HxKHMGeMnIHmv
X-Received: by 2002:a17:902:988b:b0:2d9:2b1b:878a with SMTP id d9443c01a7336-2d92b1b8824mr24362505ad.10.1788179313600;
        Mon, 31 Aug 2026 05:28:33 -0700 (PDT)
Received: from celestia ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d7594fc0a6sm34514055ad.15.2026.08.31.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:28:33 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: sashiko-bot@kernel.org
Cc: aethernet65535@gmail.com,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Mon, 31 Aug 2026 20:28:15 +0800
Message-ID: <20260831122842.9091-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831115015.3A53C1F000E9@smtp.kernel.org>
References: <20260831115015.3A53C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 11:50:14 +0000 sashiko-bot@kernel.org wrote:

> commit 7f67629ee782b9649498afa3088f50459bfb8f3b
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
> 
> This commit introduces a KUnit test to verify that the last region is not
> skipped before being processed.
> 
> > diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
> > index 4a536d41cdb2d..90b0fda34fba2 100644
> > --- a/mm/damon/tests/core-kunit.h
> > +++ b/mm/damon/tests/core-kunit.h
> [ ... ]
> > @@ -1632,6 +1632,48 @@ static void damon_test_rand(struct kunit *test)
> >  	}
> >  }
> >  
> > +static void damon_test_last_region_quota_reset(struct kunit *test)
> > +{
> > +	struct damos s = {0};
> > +	struct damon_target *t;
> > +	struct damon_region *r1, *r2;
> > +	unsigned long min_region_sz = 10;
> > +	bool skipped;
> [ ... ]
> > +	s.quota.charge_target_from = t;
> > +	s.quota.charge_addr_from = r1->ar.end;
> > +
> > +	skipped = damos_skip_charged_region(t, r2, &s, min_region_sz);
> > +
> > +	/* 'r2' is not processed, it should not skip */
> > +	KUNIT_EXPECT_EQ(test, skipped, false);
> 
> [Severity: Medium]
> Does this patch omit the fix for the core logic?
> 
> Without an accompanying fix for damos_skip_charged_region() in
> mm/damon/core.c, won't this new test unconditionally fail and break CI?
> 
> Because the underlying bug is not fixed in this patch, the old logic still
> triggers and returns true when it processes the last region:
> 
> mm/damon/core.c:damos_skip_charged_region() {
> 	...
> 	if (quota->charge_target_from) {
> 		if (t != quota->charge_target_from)
> 			return true;
> 		if (r == damon_last_region(t)) {
> 			quota->charge_target_from = NULL;
> 			quota->charge_addr_from = 0;
> 			return true;
> 		}
> 	...
> }

This test is add for [1].  Therefore, this patch can only be merged
after [1] is merged.

[1] https://lore.kernel.org/damon/20260830063159.6347-1-aethernet65535@gmail.com

Best regards,
Rui Yan
