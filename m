Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45315560AD0
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876307; cv=none; b=jbwAqGq08GN2+1NFCgyRVCT6Dw4/28DqfyJEsq+2lTwFpdOWtjwDRX0JQPyIhGDNpxplDtMKy15NaqeRSauM7y9WFAZWaqq6YBezTfTMEbMu4XquLzOwrP2d/j+zHoqGjbt6QBF/EWpnjZ8ave+roWOCViSCQbnJ8DLbc6ToaSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876307; c=relaxed/simple;
	bh=9iL9F8JcBxcT4U69Y6VHm1ObzJ3ri3W7jNldE5W9rog=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KKxJq5+AhFLfk30sRTHXvNp4AQtsvs/KGA/cdZrCyAhjwgzPnolugg5VAFHVjopn7mA5GAdaTqL/qTVP6RYC1C9nClf3ZQSHFcrv1VjK+O2FG0W5paPrGy393MHzSM03eJCn4RB4XKeznBZQhnA/OW8IoHdGRf2YOPVg1afmswg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB63F1F00A3A;
	Tue,  8 Sep 2026 14:04:46 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mm/damon/core: allow esz to be set to zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908135413.97570-1-sj@kernel.org>
References: <20260908135413.97570-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:04:45 +0000
Message-Id: <20260908140446.EB63F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in temporal goal tuner calculating `esz_bp` and `=
ULONG_MAX` capping severely limits DAMOS effective size quota on 32-bit sys=
tems.
- [High] Integer overflow when calculating time quota constraints (`through=
put * quota->ms`) on 32-bit systems limits time-based quota.
--

commit 05338618157ff96b3145359ae173701a5ed4f699
Author: Liew Rui Yan <aethernet65535@gmail.com>

mm/damon/core: allow esz to be set to zero

When the temporal quota goal tuner achieves its goal, it sets esz_bp to
zero, but damos_set_effective_quota() previously clamped this to
min_region_sz. This patch fixes this by keeping the effective size quota
(esz) as minimum as possible when the goal is achieved.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ce8c6f99106ed..3e9c9b6385d4e 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3239,6 +3239,7 @@ static void damos_set_effective_quota(struct damon_=
ctx *ctx, struct damos *s)
>  	struct damos_quota *quota =3D &s->quota;
>  	unsigned long throughput;
>  	unsigned long esz =3D ULONG_MAX;
> +	unsigned long esz_time;
> =20
>  	if (!quota->ms && list_empty(&quota->goals)) {
>  		quota->esz =3D quota->sz;

[ ... ]

> @@ -3259,8 +3260,8 @@ static void damos_set_effective_quota(struct damon_=
ctx *ctx, struct damos *s)
>  					1000000, quota->total_charged_ns);
>  		else
>  			throughput =3D PAGE_SIZE * 1024;
> -		esz =3D min(throughput * quota->ms, esz);
> -		esz =3D max(ctx->min_region_sz, esz);
> +		esz_time =3D max(throughput * quota->ms, ctx->min_region_sz);

[Severity: High]
This isn't a bug introduced by this patch, but does this inline multiplicat=
ion
wrap around on 32-bit systems?

Both throughput (calculated as bytes per millisecond) and quota->ms are
unsigned long. On a 32-bit architecture, a realistic throughput like 2 MB/ms
combined with a quota limit of 3000 ms yields a product of 6,000,000,000.=20

Since this exceeds the 32-bit unsigned long limit of 4.29 billion, it silen=
tly
wraps around to a significantly smaller size limit, which unintentionally b=
ounds
the effective quota and breaks the intended time-based logic.

[Severity: High]
This is a pre-existing issue, but I also noticed a similar overflow problem
regarding the quota->esz_bp calculation in this same path.

When a user configures quota->sz via sysfs, it is scaled here:

mm/damon/core.c:damos_goal_tune_esz_bp_temporal() {
    ...
		quota->esz_bp =3D quota->sz * 10000;
	else
		quota->esz_bp =3D ULONG_MAX;
    ...
}

If quota->sz is unset (0), esz_bp defaults to ULONG_MAX (4,294,967,295 on
32-bit systems). When this is later scaled down:

mm/damon/core.c:damos_set_effective_quota() {
    ...
		esz =3D quota->esz_bp / 10000;
    ...
}

The resulting esz becomes 429,496 bytes (~419 KB). Does this artificially
throttle DAMOS region actions on 32-bit platforms?

Additionally, if quota->sz is set larger than ~429 KB, quota->sz * 10000
silently overflows the 32-bit unsigned long, creating a much smaller wrapped
quota. Could we address this ULONG_MAX limitation and multiplication overfl=
ow
on 32-bit architectures?

> +		esz =3D min(esz_time, esz);
>  	}
> =20
>  	if (quota->sz && quota->sz < esz)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908135413.9757=
0-1-sj@kernel.org?part=3D1
