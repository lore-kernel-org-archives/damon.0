Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878A15539A
	for <damon@lists.linux.dev>; Wed, 29 Apr 2026 06:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442594; cv=none; b=OGFagjeajgr677rJKFGkye1eqtsrTohR9XMkhpfaaz/ZAXKYdo441mbEtospwz5zKJIHQV63s4n+O8DukpDuM5nUVqt1nNpfRmdqSsImaUSoyfKDgI7ISPJlcPoZvY9pXBJ5RxVL06UzBZj3YG2rf7h9C4tYkpLmMQ0HPLGY6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442594; c=relaxed/simple;
	bh=+QO6yhg/oT5Vm3uFcS5AqyuDmaJMeuRdB48mk/nPA2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ujc0t87kOxeJ3Mc2RdvZc/srbujpK5DchuqrYs+igmLCIyMjzyrZmrCmv8Sh6W+syxqyE8VccRTrKtXV74AUaq4S9F75VM6vpLP/MiUBgHDJh1nofNJYLpRBjFFzUIrTWLJSy6Q3e3HGi0An58E8fPp9myV3ZNWGvFf+4/DmdHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEvo8Nus; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEvo8Nus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EE6C19425;
	Wed, 29 Apr 2026 06:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777442594;
	bh=+QO6yhg/oT5Vm3uFcS5AqyuDmaJMeuRdB48mk/nPA2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=lEvo8NusyrRtrJ1f2zPCMWRwkHZZL7BtXoU2XG7NfmQWkrNOF5nYOVdsnWmF16Qkg
	 CTumPjrHB9qOHzNPFe63/0byin02LJfZBm7h9yHb1B2rOhS3kQDDI+VFRAHqvDVc3Y
	 19+La+SPsrxXVyX6tmlRfxg+65oEx9trh7HMAt+V4dt9sE2hNiYf0WrKgAwlSHghwZ
	 Pzf8eBjDe+bV//aPkHvjoizei1nq4wvNNWhx8yOjno4w7/AfRwO45xvOBIEfmfDlR7
	 HnGnPf62whBf1Q7nvSceL7YI70uX/VqHxAk0vVvKn3CP2iAtNvVasmM/wWYjyZCtv8
	 h4s/1vRWHXNBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] mm/damon/lru_sort: cover all system rams
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260429041232.90257-4-sj@kernel.org>
References: <20260429041232.90257-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 06:03:13 +0000
Message-Id: <20260429060314.49EE6C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Single bounding box for sparse memory layouts causes soft lockups =
and algorithmic failure
--

commit 692650636f4214ec9c2fa1c5d7fd43fe3bf049fe
Author: SeongJae Park <sj@kernel.org>

mm/damon/lru_sort: cover all system rams

This commit changes the default monitoring region from the biggest System R=
AM
resource to a single region that spans all system RAMs. This is intended to
cover the entire physical memory instead of just the largest block.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index 7569e471160a..2eb559d913b6 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c

[ ... ]

> @@ -326,7 +328,7 @@ static int damon_lru_sort_apply_parameters(void)
>  	if (err)
>  		goto out;
> =20
> -	err =3D damon_set_region_biggest_system_ram_default(param_target,
> +	err =3D damon_set_region_system_rams_default(param_target,
>  					&monitor_region_start,
>  					&monitor_region_end,
>  					param_ctx->addr_unit,

Could this lead to a regression on systems with sparse memory layouts?

When creating a single bounding box from the first to the last physical
address, systems with sparse memory like CXL or distant NUMA nodes could end
up with a region containing terabytes of unpopulated physical address space.

Will this cause soft lockups during DAMOS operations?

If a scheme like PAGEOUT iterates linearly over this massive region in
PAGE_SIZE increments, iterating over these large memory holes might stall t=
he
CPU and trigger the watchdog, since cond_resched() is typically placed after
the loop.

Does this also cause an algorithmic regression with the sampling probabilit=
y?

DAMON's adaptive logic merges adjacent regions with identical access
frequencies. Since memory holes report 0 accesses, they might be aggressive=
ly
merged with interspersed RAM into maximum-sized regions. Because sampling
selects a single random address per region, the probability of actually
sampling the populated RAM might drop to near zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429041232.9025=
7-1-sj@kernel.org?part=3D3
