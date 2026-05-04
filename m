Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E512E1E9
	for <damon@lists.linux.dev>; Mon,  4 May 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918249; cv=none; b=eSMH8uB1zQbFWbhWFV+wXsthfTG6sp4nWDVmhFzjULKBm6keZrLm1K5EeKGDm156YrkTyd7rw6awzQvg7swWzMJH4wGz1HKE+drELms6dyafHs2vDg/oV1JtWOk0/CvsgCVza5v3TqHM3GjHY16zG0+S+PKJvFTIis75VXA/QtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918249; c=relaxed/simple;
	bh=8jlNdHMjLPDIKeQEGQykyQPTXLiol++Gk1HTncgfU5M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ldE47hgR60P5uivvVv8aJoQjZebmKQ5ENbXpZ4M6pC6EjwFoo02vqA5m78K4S27kQz+1KhUaTvuA+gaz2OmhwpBy0c7IeL3viW6j94O0Ct2mYdpQWWb6NTBV8w1cK6Zr0gIM9jZhHZBynKfbp4/Cjg+zPYEhxfuY8nMDuHCoZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJMrut20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJMrut20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BE2C2BCB8;
	Mon,  4 May 2026 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777918249;
	bh=8jlNdHMjLPDIKeQEGQykyQPTXLiol++Gk1HTncgfU5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aJMrut20pu4RBZNyV7mnYWLVO0Ip1/AFxWi3UOChAQi2GxLU5MWr/fObJtB47gy5T
	 w4+xnAx1jpUejnb17t5TiSawvo9bQFoaq9xZyqpsNbviAgW8wQaH581/GY57ihwVev
	 9up7sb1WqM2g0eGP34pW2fHUVlwmypWWyuFNUZ+r0uhGB/JQfaiTEzi+NBn5GcI8RP
	 EKsD49AGiNWyfbXujM1DU0yt0eKYlyu3cGedmtgwZAXUvLLq/H+68EaInD6Lipdsn9
	 mK8xHle2XG+nDXXtsAYNUajUWsP7Q+3nHCgLpJ/UDA4oewlXAoJNhixEmloC4onmn0
	 nGB0CoyHE2CJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: disallow time-quota setting zero
 esz
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260504125808.22145-1-sj@kernel.org>
References: <20260504125808.22145-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 18:10:48 +0000
Message-Id: <20260504181048.E3BE2C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unmitigated integer overflow in the `throughput` calculation perma=
nently breaks time quotas.
- [High] Incorrect initialization of `charged_from` completely bypasses quo=
tas for the first 5 minutes of system boot.
--

commit 558d8bfd17c7ba00954bbbf18a4eb2783d713b59
Author: SeongJae Park <sj@kernel.org>
mm/damon/core: disallow time-quota setting zero esz

This commit addresses an issue where DAMOS time quotas could make the
effective size quota smaller than the minimum region size. By forcing
the effective size quota to be at least DAMON_MIN_REGION, it prevents
schemes from being unexpectedly deactivated.

Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ab5c351b276ce..94f8450f6e843 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -802,6 +802,7 @@ static void damos_set_effective_quota(struct damos_qu=
ota *quota)
>  	else
>  		throughput =3D PAGE_SIZE * 1024;
>  	esz =3D throughput * quota->ms;
> +	esz =3D max(DAMON_MIN_REGION, esz);

Can the throughput calculation overflow here?

Looking at damos_set_effective_quota() before this change, throughput is
calculated using:

    throughput =3D quota->total_charged_sz * 1000000 / quota->total_charged=
_ns;

Both total_charged_sz and total_charged_ns accumulate indefinitely over the
scheme's lifetime. The intermediate multiplication by 1000000 is performed
in unsigned long precision.

Could this overflow after a large amount of memory is processed? For
instance, it could wrap around after around 18.4 TB on 64-bit systems, or
just 4KB on 32-bit systems where unsigned long is 32-bit.

When the multiplication wraps around, the numerator becomes artificially
small, causing the computed throughput to collapse to near-zero. While
clamping esz to DAMON_MIN_REGION prevents total deactivation, does the
overflow permanently trap the scheme into processing exactly one minimal
region per charge window?

Also related to the effective size quota updates, is there a regression
during early system boot?

Looking at damos_quota_init_priv(), quota->charged_from is initialized
to 0 rather than the current jiffies.

In kdamond_apply_schemes(), the charge window only starts when:

    time_after_eq(jiffies, quota->charged_from + interval)

Because jiffies starts at INITIAL_JIFFIES (which casts to a negative long,
typically -300*HZ), does time_after_eq() fail for the first 5 minutes of
system uptime?

During this 5-minute period, damos_set_effective_quota() would never be
invoked, leaving quota->esz at its default initialized value of 0.

Because quota->esz =3D=3D 0 is treated as no limit by the scheme application
checks, do early-boot schemes (like damon_reclaim) run entirely
unthrottled for the first 5 minutes, completely ignoring user-configured
CPU and size quotas?

> =20
>  	if (quota->sz && quota->sz < esz)
>  		esz =3D quota->sz;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504125808.2214=
5-1-sj@kernel.org?part=3D1
