Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815D2E7361
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319489; cv=none; b=M14BkU24r6vjxi31vZgpF2LMOf0ackq3fzb13oRYcAMFozGB7h9MgVH74khXu3CTW5xrmq0vyvwXTW53n3fG6k2ze/zDk5bdHICSZBfOTACpI/hJ1JAFvz1pfbZpCfTVhUrVZZ7fTrJYduyHpZ17LaIAnTynhkuRoInmqUFiqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319489; c=relaxed/simple;
	bh=tBlvgYA8aq7H1YvRi9yRaKZfbkMoK6MTXzIWz9Lz+X0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XfWRDd86vmWa9JjnouL0K+WNZwwY17Y2mjT4NHoT7LupnxeqMEZAHXyusFa5802ogVD5pdk9Ukxrx5kpi5M3UP0y/m0CP5qRgGYpXnvnvODUuImsONAI7D58X0OERsuyVNiZiMEN+c+0brNtnM3tGO0DkHsjzph8TueeOthhqxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkzEPLBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkzEPLBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB99C1F000E9;
	Wed,  2 Sep 2026 03:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788319487;
	bh=HuLhDaqQH96EnVoZuhEBp0KzFuokOhIwDO3P+BFO4Jw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkzEPLBekMucLMwQQmql8s4GPH8SFg3oKuQgqPYLta1MAAq80mkrfqaf1VXsCzh9B
	 Db+PXdZ4vO1RfG6veOtJJ/PdTiboAmHoF92AT9f/AHfZDjeoxpyowsGTTRpGRqC2/R
	 f+BSMrTNBFg2jRa3dmOoqgMJz974T9DH7IXrCCYLoyDmj5x3GHj3jEvy1ouYrrh46l
	 KsAuAkdez9Csdq6r1wEN0iHZPSlhsam47H3iJF4NoHMD+rIHAvSqnIBbe6O2q+V0Ah
	 3zwNx80kNqv4kwgYzFb5PV9hnE5y8S66PIN/0+ykzkKUsI1sEh4pHmnd4yjxIeQels
	 BdqNe63Ff29YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] mm/damon/ops-common: use a page-aligned address in
 damon_ptep_mkold()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Gao" <zcgao@amazon.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902031655.84721-1-zcgao@amazon.com>
References: <20260902031655.84721-1-zcgao@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 03:24:47 +0000
Message-Id: <20260902032447.AB99C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> __damon_va_prepare_access_check() picks a random byte address within the
> region and stores it in r->sampling_addr. damon_va_mkold() passes it into
> a page table walk, which hands it to damon_ptep_mkold() as the address of
> the page to sample:
>=20
>   damon_va_mkold(mm, r->sampling_addr)
>     damon_va_walk_page_range(mm, addr, addr + 1)
>       damon_mkold_pmd_entry()
>         damon_ptep_mkold(pte, vma, addr)
>           ptep_test_and_clear_young(vma, addr, pte)
>           mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE)
>=20
> For arm64, before commit 6f0e1142173a ("arm64: mm: support batch
> clearing of the young flag for large folios"), the contpte helper walked
> exactly CONT_PTES entries from the aligned-down page table pointer and
> [ ... ]
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand (Arm) <david@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Nathan Gao <zcgao@amazon.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902031655.8472=
1-1-zcgao@amazon.com?part=3D1

