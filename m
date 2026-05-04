Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1750B3E0226
	for <damon@lists.linux.dev>; Mon,  4 May 2026 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904783; cv=none; b=F+oty9katv8rycG3peeS9J+qVLR7DMEpHEJbO7JyHi3+K+pP3riHUsXFHKjpkjLEus3AVb4m2g82xHisTkxqTyBv9vUqrCbkKwbLb4CWaoLCILxtmpI36SzAjsIRCpi9vXJ4dBb49Rw/ebLYO5UGefeiAcUsAQlhKo1t8PyuwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904783; c=relaxed/simple;
	bh=IO15xRHhh5QR2YXjA8m0k36nn8eifXXXsWl6h9FQJPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TRNDA190A+3NH2n3Zpdf+lkR1/dT1nmDO5UFiVo0n50ekxV90Ya9+4frBOZkbUT4P85jsnpz8kTL65C7vHC2T7iF2YgpET4rSnY9eiMJ9KKKT/Mn0wrLuiP8m0wD4Oqez2SA3qMWxFjRh42uEXBiaYQ7teBY4rbtkyv3boxydF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCf5dJmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCf5dJmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36A0C2BCC4;
	Mon,  4 May 2026 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777904782;
	bh=IO15xRHhh5QR2YXjA8m0k36nn8eifXXXsWl6h9FQJPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JCf5dJmMjg3AofIhsv3mMWkkp+tY49zHL74aETDApy+IB91RVAz53QwLxl+Bj2OLH
	 tjuqHK/1hTIIO+fLRF5LCqIrddVlD9ZzRlwXttWCuDz8FtBbMBYTqqZv0V4xjOZskv
	 C0T5twtlpBcacOLuAz1jNz/VZw5KPZiaa0+Dd1mFyHtBh5OM31wO0oE9kPQc0kt6YP
	 JQZTEhYNRcQ8j9NXhtkJFoTmtbFaF2aU6u8rNDo2KJclKXp33AV0W6LrkNrb+HZ9H+
	 vEOb1I8W5A+VtZnHNAgl/3IQy/fheZO8ju8rSiNdjKHIkJoJVQfLDm6Y2EJtG+LKXu
	 vAnW3hSdr42eA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] mm/damon/core: disallow time-quota setting zero
 esz
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260504125529.18220-1-sj@kernel.org>
References: <20260504125529.18220-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 14:26:22 +0000
Message-Id: <20260504142622.B36A0C2BCC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Integer overflow in throughput estimation permanently breaks DAMOS=
 time quota mechanism.
--

commit 352051c643d14056b79b910e005f54b4d071e250
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: disallow time-quota setting zero esz

This patch fixes an issue where a slow DAMOS scheme causes the effective si=
ze
quota to fall below the minimum region size, which prevents actions from be=
ing
applied. Because no actions are applied, the charge statistics stop updating
and the scheme is unexpectedly deactivated. The fix ensures the effective s=
ize
quota is always clamped to at least the minimum region size.

Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 48747236c21c..12c2e584659a 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1026,6 +1026,7 @@ static void damos_set_effective_quota(struct damos_=
quota *quota)
>  	else
>  		throughput =3D PAGE_SIZE * 1024;
>  	esz =3D throughput * quota->ms;

Since total_charged_sz accumulates lifetime processed bytes without being
reset, can the throughput calculation that precedes this line cause a
regression by overflowing?

In damos_set_effective_quota(), throughput is calculated as:
throughput =3D quota->total_charged_sz * 1000000 / quota->total_charged_ns;

On 32-bit architectures, total_charged_sz * 1000000 would overflow when
total_charged_sz reaches just 4295 bytes. On 64-bit architectures, it would
overflow after about 18.44 TB of memory processed.

Once total_charged_sz * 1000000 wraps around, the numerator becomes extreme=
ly
small compared to the denominator (which on 64-bit takes 584 years to wrap),
causing the computed throughput to instantly drop to near zero.

> +	esz =3D max(DAMON_MIN_REGION, esz);

Although this clamping ensures esz never drops below DAMON_MIN_REGION, would
the scheme become permanently throttled down to this minimum region size
until the numerator catches up again after another 18 TB of processing?

> =20
>  	if (quota->sz && quota->sz < esz)
>  		esz =3D quota->sz;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504125529.1822=
0-1-sj@kernel.org?part=3D1
