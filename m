Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AC3E024B
	for <damon@lists.linux.dev>; Mon,  4 May 2026 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917736; cv=none; b=aAO9YQiml8/kjG8H2J4+nIOGfkJOAmDzapSmWgWSkd2K2nQb2J0YpeibWV3mqZSmJfbU2gY8y1oeXwCztM24STrBRvneBBPzSfwWOeLnEeveYVowDndHklNOgLnRKtQce81ZeXCk/Cu4GchmeWdUmBgEkNubjfzMbsCjuUs0/nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917736; c=relaxed/simple;
	bh=J5yRr3N/nGo9P3WNITQ1ttjRHXI9fDtug9B29qbisB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mJ2WBQnWZo6pVjOzEjEoShc9wv++gyyU3ZGiFhAZYbTyEfJeDXqph8Hd9gUMmj6VtA6MoeBmVE0Bo+7wXH9sUpOjwDMcHNFPv9hpM2HaHxQ/0Ku2BaUPlGuZw3lp71ZY/GOdKuDsu5Fhe5jWy7ReW+l6S1h/kAVfGeoTdvkLoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqFSwrCM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqFSwrCM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E4AC2BCB8;
	Mon,  4 May 2026 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777917736;
	bh=J5yRr3N/nGo9P3WNITQ1ttjRHXI9fDtug9B29qbisB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SqFSwrCMfGk+wypMczGW1rltvEaNj+lkhrUKmsiVtnNnifMueRwy/EHXLA1lCLPHz
	 MtHMzb3S4MgxksFNKCzjx/ZYuDGl8JpcqSV3e34S53Bwb+IngHA7SQ640zlM9Q9T+9
	 ULtzlBsfehXS4Zjt7g5eBUlvoF+EORCCxXLko0yhZrPk6lSgL2zobe4R3/0EtDELtZ
	 cHZc5qDEynIcPIj9TzK0FEo3kn1rjf/aQbop3pqky7zsqguyCoXpVfms3NbiCgAff7
	 7gTxlNi2ZOSHtleOQ1+ZX92hs7zptxhf76pcEwJOR/u1Tn6g9/YDLm8d1YxE/wmr7q
	 09HSWAXfWbzPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: disallow time-quota setting zero
 esz
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260504125220.15509-1-sj@kernel.org>
References: <20260504125220.15509-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 18:02:15 +0000
Message-Id: <20260504180216.17E4AC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch masks a severe pre-existing integer overflow in the time=
 quota throughput calculation, which permanently throttles the scheme inste=
ad of fixing the root cause.
- [Medium] The patch forces the effective size quota to be at least DAMON_M=
IN_REGION when a time quota is configured, breaking the ability of quota go=
als to intentionally pause the scheme.
--

commit 648433abd4b11fd3f4a77018e7e47105abac1ce7
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: disallow time-quota setting zero esz

When the throughput of a DAMOS scheme is very slow, the DAMOS time quota can
make the effective size quota smaller than the minimum region size, prevent=
ing
actions from being applied. This commit fixes the issue by setting the time
quota-modified effective size quota to at least DAMON_MIN_REGION.

Link: https://lore.kernel.org/20260407003153.79589-1-sj@kernel.org
Link: https://lore.kernel.org/20260405192504.110014-1-sj@kernel.org [1]

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index ed2b750231810..69f8244324b36 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -1577,6 +1577,7 @@ static void damos_set_effective_quota(struct damos_=
quota *quota)
>  			esz =3D min(throughput * quota->ms, esz);
>  		else
>  			esz =3D throughput * quota->ms;
> +		esz =3D max(DAMON_MIN_REGION, esz);

Does this cause a regression by breaking the ability of quota goals to
intentionally pause the scheme?

If a dynamic quota goal determines that actions should be paused and reques=
ts
an esz smaller than DAMON_MIN_REGION, this max() macro forcibly overrides it
and bumps the quota back to DAMON_MIN_REGION.

This causes the scheme to process at least 1 page per charge window instead
of fully pausing.

Could the max() boundary be applied exclusively to the throughput-derived q=
uota
before it is min()'ed with the goal-derived quota?

Additionally, does this code mask a pre-existing integer overflow regression
in the throughput calculation?

Looking earlier in damos_set_effective_quota():

	if (quota->total_charged_ns)
		throughput =3D quota->total_charged_sz * 1000000 /
			quota->total_charged_ns;

Because total_charged_sz and total_charged_ns are continuously accumulated
over the scheme's lifetime, total_charged_sz * 1000000 will overflow an
unsigned long on 64-bit systems after processing around 18.4 TB of memory.

When the numerator overflows, it wraps modulo 2^64 while total_charged_ns
continues to grow. This causes the calculated throughput to collapse to
near-zero.

Also, on 32-bit systems, total_charged_ns stores nanoseconds and overflows
a 32-bit unsigned long after 4.29 seconds of accumulated action time, causi=
ng
erratic throughput calculations.

By clamping the output to DAMON_MIN_REGION here, the patch seems to permane=
ntly
throttle the scheme to process exactly 1 page per charge window once the
overflow occurs, rather than fixing the underlying throughput collapse.

>  	}
> =20
>  	if (quota->sz && quota->sz < esz)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504125220.1550=
9-1-sj@kernel.org?part=3D1
