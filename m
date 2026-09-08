Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5A4F6463
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877871; cv=none; b=MHiKAqRwbb/biW+ZMzbc5qxRcQkwLtHax2oh5/VWKMpP7XePnkaJ+BVE7EmNwf1cPA2TZwiCl+Z/CdIBlnZTZnGSHi12jY06CXcRtDobpIv8OF3K8PIjixoXsLkANG8KX74fL5iipq3lGxv0S1kZ/3G68U9yjoW+5BBD5QGX7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877871; c=relaxed/simple;
	bh=l6HdjSW+XlolMVIXRD+ISU3kG0CaWOSX4l+l23mObr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mb4o/3oyDO6hWJPFtn/Vfb1gzyPuwNBuZh0AG7jcqwUVScvLFK/LZKqKy5tSU8u4W1bDJjmliJOKtsthBDTEtPVLteOmVhiSDYMm12gb0eAyimzPxN+/zUPWlFlBvi2U7F1aB/cygVS3Swex6H5EVMLN4SFJdweUNStEGhSrteM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7i/Epw1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7i/Epw1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5DC1F00A3A;
	Tue,  8 Sep 2026 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788877862;
	bh=1682i/Su6AKXZ5RB63oTQN3V0HGWIo9JwZW/vKl2UkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7i/Epw1jd5F0uX4JNHwRIj7WlqT2zMUE2WrUGYv0HlI7kPRGigBEQn6ZCp9mUkep
	 9e6h0eAEo8q/9PMvuEkC/bv7++BIBl68zMoWS4Qo5NJTCTyMsv5FgoXbEi83Qah5Xe
	 kquy8XvSiUCZmKiWmSfPTEcftLrzEdwegl9nItvMnJABxyxm8e02Z5pCgeL1lwUVwQ
	 AqJrmxkjWLwA44lBH6xm05S3Dou9Ya+ElUkxdZ8jo+dV8eBVuVlJnf+d2cj2uuFGlE
	 v1x6FBaAZBs+LPULK5TUErU5kFH+btC0UlmIKAHzunEdUCg2lYjb0OjaO7VGHgGl2w
	 fSi+0m/Vehd1w==
From: SJ Park <sj@kernel.org>
To: sashiko-bot@kernel.org
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH v4] mm/damon/core: allow esz to be set to zero
Date: Tue,  8 Sep 2026 07:30:52 -0700
Message-ID: <20260908143053.102690-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260908140446.EB63F1F00A3A@smtp.kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 14:04:45 +0000 sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Integer overflow in temporal goal tuner calculating `esz_bp` and `ULONG_MAX` capping severely limits DAMOS effective size quota on 32-bit systems.
> - [High] Integer overflow when calculating time quota constraints (`throughput * quota->ms`) on 32-bit systems limits time-based quota.
> --
> 
> commit 05338618157ff96b3145359ae173701a5ed4f699
> Author: Liew Rui Yan <aethernet65535@gmail.com>
> 
> mm/damon/core: allow esz to be set to zero
> 
> When the temporal quota goal tuner achieves its goal, it sets esz_bp to
> zero, but damos_set_effective_quota() previously clamped this to
> min_region_sz. This patch fixes this by keeping the effective size quota
> (esz) as minimum as possible when the goal is achieved.
> 
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index ce8c6f99106ed..3e9c9b6385d4e 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -3239,6 +3239,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
> >  	struct damos_quota *quota = &s->quota;
> >  	unsigned long throughput;
> >  	unsigned long esz = ULONG_MAX;
> > +	unsigned long esz_time;
> >  
> >  	if (!quota->ms && list_empty(&quota->goals)) {
> >  		quota->esz = quota->sz;
> 
> [ ... ]
> 
> > @@ -3259,8 +3260,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
> >  					1000000, quota->total_charged_ns);
> >  		else
> >  			throughput = PAGE_SIZE * 1024;
> > -		esz = min(throughput * quota->ms, esz);
> > -		esz = max(ctx->min_region_sz, esz);
> > +		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this inline multiplication
> wrap around on 32-bit systems?
> 
> Both throughput (calculated as bytes per millisecond) and quota->ms are
> unsigned long. On a 32-bit architecture, a realistic throughput like 2 MB/ms
> combined with a quota limit of 3000 ms yields a product of 6,000,000,000. 
> 
> Since this exceeds the 32-bit unsigned long limit of 4.29 billion, it silently
> wraps around to a significantly smaller size limit, which unintentionally bounds
> the effective quota and breaks the intended time-based logic.

We provide addr_unit for this kind of issues on 32 bit systems.  I will
separately work on this with low priority.

> 
> [Severity: High]
> This is a pre-existing issue, but I also noticed a similar overflow problem
> regarding the quota->esz_bp calculation in this same path.
> 
> When a user configures quota->sz via sysfs, it is scaled here:
> 
> mm/damon/core.c:damos_goal_tune_esz_bp_temporal() {
>     ...
> 		quota->esz_bp = quota->sz * 10000;
> 	else
> 		quota->esz_bp = ULONG_MAX;
>     ...
> }
> 
> If quota->sz is unset (0), esz_bp defaults to ULONG_MAX (4,294,967,295 on
> 32-bit systems). When this is later scaled down:
> 
> mm/damon/core.c:damos_set_effective_quota() {
>     ...
> 		esz = quota->esz_bp / 10000;
>     ...
> }
> 
> The resulting esz becomes 429,496 bytes (~419 KB). Does this artificially
> throttle DAMOS region actions on 32-bit platforms?
> 
> Additionally, if quota->sz is set larger than ~429 KB, quota->sz * 10000
> silently overflows the 32-bit unsigned long, creating a much smaller wrapped
> quota. Could we address this ULONG_MAX limitation and multiplication overflow
> on 32-bit architectures?

We provide addr_unit for this kind of issues on 32 bit systems.  I will
separately work on this with low priority.


Thanks,
SJ

[...]
