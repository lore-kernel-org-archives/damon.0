Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC325353A66
	for <damon@lists.linux.dev>; Sat,  1 Aug 2026 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785613191; cv=none; b=OMDpW0JcoBq26P9En8bg8T80WOEcCpfnTwUDZrELAdA/NWM71CUoEEXv0tJr8L6RBf2qUrbaAJFgVNx0pcSpHacsSH5b5bUOBU5rk7Ofduu3QCzGCw/OHaqzHfFKfk45Fx2kkf2mhEQ6zrXE9XSOOFCwd++RMbCJRa4o26jEuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785613191; c=relaxed/simple;
	bh=rJcU0Tu7qPfKg2L1idRJyvc7QZ0DaGQHSIxzpxF/rzI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N+ffLTEio91Z8mER+6R84a4WeiGVr74MPlOC6nLY/NxBKwHm4gBnBlGIvsd2x4DaYfYt2n5UfYPpMQyafh/u8K4a3nJgPcishu0WAy8Ck+N3+/BhviFwcdiuqcM/LM1rgFYHkUwNXMe/J5m7he+mWMeDyX81Z2MWcyNlL5MJ30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpApH3Z+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpApH3Z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4270A1F00AC4;
	Sat,  1 Aug 2026 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785613189;
	bh=bo4Tl2G42vBlgi6DQ3JQbMEMtR54twt9vNymF9jn4gw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpApH3Z+Lvu4sx70/aHQR+MFqH79JFh5qBiTqWFr2fLmJrnV5rdz2RWr7h0vD12aH
	 Md/UFqLKctxDJxMlUgIrnr6EmW1mk1p7+4iGWmV5u8dOnJJS0s9KGh/TqaGIesxpKY
	 RXtA7hWgUsieby3pyZ53+P8RXYy8IHyGfnuttFAWHV4v95C0u+ahMuNp6kbkMbDrgr
	 o476zczOZrJAFR4Kiy0EEdHAdZH+EGS2z/3epJvEeuDImVxrAduDeRuZgEyhd6GqF9
	 zNAmN/KH9KLqXjOL+WSsbxjbIA9zUzjQS7c0llpcQKD/mYhEmmJYA9yiU/O5+MyRq1
	 LV2jDE/sCZsNA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 9/9] mm/damon/core: handle extreme memory state in
 get_in_active_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260801173554.94710-10-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
 <20260801173554.94710-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 19:39:48 +0000
Message-Id: <20260801193949.4270A1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message incorrectly identifies the function being mod=
ified, failing to align its claims with the code changes.

Pre-existing issues:
- [High] Multiplication overflow in `mult_frac()` and other basis point sca=
ling calculations on 32-bit architectures leads to incorrect memory ratio c=
alculations and scaling.
--

--- Patch [9]: [RFC PATCH 9/9] mm/damon/core: handle extreme memory state i=
n get_in_active_mem_bp() ---
commit fee9e9f299e48399ca370c1f9725936302eaeb8c
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/core: handle extreme memory state in get_in_active_mem_bp=
()

This patch prevents a divide-by-zero risk in DAMON's active memory ratio
calculations. In extreme environments where active and inactive memory
both amount to zero, the patch clamps the total memory denominator to a
minimum of 1 to avoid a crash.

Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

> damon_get_intervals_adaptation_bp() uses the sum of the active and
> inactive memory amount as a denominator.  In an extreme and unlikely
> environment, active and inactive memory might be zero.

[Severity: Medium]
Is the function name referenced in the commit message correct?

The commit message explicitly states that damon_get_intervals_adaptation_bp=
()
is being modified to fix a divide-by-zero bug, but the patch actually
modifies damos_get_in_active_mem_bp().

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 76764a2056f7c..4944cf2c5afae 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3010,7 +3010,7 @@ static unsigned int damos_get_in_active_mem_bp(bool=
 active_ratio)
>  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
>  	inactive =3D global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
>  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> -	total =3D active + inactive;
> +	total =3D max(active + inactive, 1);
>  	if (active_ratio)
>  		return mult_frac(active, 10000, total);

[Severity: High]
This is a pre-existing issue, but does this calculation overflow on 32-bit
architectures?

In damos_get_in_active_mem_bp(), if active memory exceeds approximately
429,496 pages (~1.75 GB), multiplying the active page count by 10000 inside
mult_frac() will overflow an unsigned long on 32-bit systems before the
division by total. This could result in artificially low active/inactive
memory ratios and break DAMON's adaptive tuning.

Does this same overflow affect damon_feed_loop_next_input()?

That function returns last_input * score_cg / goal. When last_input is
passed as 100,000,000 and score_cg can be up to 10,000, that multiplication
would similarly wrap around 32-bit boundaries.

>  	return mult_frac(inactive, 10000, total);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801173554.9471=
0-1-sj@kernel.org?part=3D9
