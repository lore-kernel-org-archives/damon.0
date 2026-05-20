Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6B434250D
	for <damon@lists.linux.dev>; Wed, 20 May 2026 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779259982; cv=none; b=r7t5SambcVvITc7aNZQDmRQYjWzRbw7AIR+eSP8AZFCe+N3yE4FB+1+tz5dVKRpg+Lil0jX0BrjWtFALuQX/rvGHTWaI/vc+FAO1yciHa3r8cqNUp+T15wPUksfAZtTWXIM+IL2k7+5CO+rRVp2QQ5ZQYoJ1WRlGEKwpncfCNsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779259982; c=relaxed/simple;
	bh=H4FECoEs3UXs7xW4hM3AWUiRKUOdNMTagsgpwpfLo2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aPo3W6Y+ws7DiUCJuX8WEnmv5HB+9q4xrqYL70u+k4ZVU1bf9GT37df5Mm72sCGDKISA0VgfsaVPYklVtzqGkQYNrmnzRoTDKu99sIBY7YSKcuFa1t+8Wr4tZ/w2TB4F57zL7i5oZgERPLi3QYzH1ZL/yYlUdNuxzP5L67U3svM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6ePr5Wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6ePr5Wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51591F00893;
	Wed, 20 May 2026 06:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779259981;
	bh=+frDwQVz2zafo/ujF8eO5NWHCNrZZq8/IBNTSbPpy7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i6ePr5WbDr4HBRXbzio4BbYwY/u4Adg0t/to6kq+lT0Fkvmxxc/QQNTZPRceQaakn
	 agCtkYXyIp+4+LIZ+3EFBvn/dwZL6XmbICRDpJ5E5+98Y7q/ytBHHPrGUGS9dvYbP1
	 F/N3PJdbO9D6q1IbMj8283cvMRIx/07+MnkxnPc+PMVe943ahOONvFwN+GaG01gcQZ
	 85ExxKoj3f8wj+Qzm0wbYYuH6MOq19kgWxsHxf5YDdngMN07g92waSBY08ZeQ0GSE+
	 HmQ88LigW/VqwxBejhI+KRjBsUM4DTSu5LjtWkHp+8QHQkOL8AAtlLiNNQ3yU+24sX
	 QQnj88k273KYg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/14] mm/damon/core: add kdamond_call()
 debug_sanity check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260520062858.167011-9-sj@kernel.org>
References: <20260520062858.167011-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 06:52:52 +0000
Message-Id: <20260520065300.A51591F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The sanity check for region bounds in `damon_verify_ctx` uses an i=
nverted condition, causing it to falsely trigger a kernel warning on all va=
lid regions and fail to catch invalid ones.
--

commit 7d803208aef5bc4f95dd9c37657de5b62618e8e6
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: add kdamond_call() debug_sanity check

This commit introduces a debug sanity check for the DAMON context state
before handling damon_call_control objects in kdamond_call(). The check
verifies region boundaries, overlaps, and the total region count under
CONFIG_DAMON_DEBUG_SANITY.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> @@ -3326,6 +3326,37 @@ static void kdamond_usleep(unsigned long usecs)
>  		usleep_range_idle(usecs, usecs + 1);
>  }
> =20
> +#ifdef CONFIG_DAMON_DEBUG_SANITY
> +static void damon_verify_ctx(struct damon_ctx *c)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +
> +	damon_for_each_target(t, c) {
> +		struct damon_region *prev_r =3D NULL;
> +		unsigned int nr_regions =3D 0;
> +
> +		damon_for_each_region(r, t) {
> +			WARN_ONCE(r->ar.start <=3D r->ar.end,
> +					"region start (%lu) <=3D end (%lu)\n",
> +					r->ar.start, r->ar.end);

[Severity: High]
Should this condition be inverted? WARN_ONCE triggers when the condition
evaluates to true. Since a valid memory region typically has a start address
strictly less than its end address, this evaluates to true for normal
regions.

Could this trigger a spurious warning on the very first valid region
encountered, and because it uses WARN_ONCE, prevent any actual regressions
where start > end from being reported?

> +			WARN_ONCE(prev_r && prev_r->ar.end > r->ar.start,
> +					"region overlap (%lu > %lu)\n",
> +					prev_r->ar.end, r->ar.start);
> +			prev_r =3D r;
> +			nr_regions++;
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520062858.1670=
11-1-sj@kernel.org?part=3D8
