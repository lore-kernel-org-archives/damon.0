Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC314326930
	for <damon@lists.linux.dev>; Thu, 28 May 2026 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953398; cv=none; b=CTIa5yhpsrFDzRMBRVzG/o0tX9W2Bdoeo6a6RjMafEctil+xpyZPeEmRFalC0WliDHYazaS3WIFZxD3W9+/RQnYsdFHAcw84cqPeEDrO1YD26mJXpIPrerXa92qIRhGXrFBK5beC5bs4gHjaKelR2PBnWLMvthRtQUbcelHy7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953398; c=relaxed/simple;
	bh=HD+bWRulkaOq8NTAndCd6/aOk+aOBiQgU4ZZbsdz4o8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljmfUePH7B4Yg8PfgWzw+u+myIKdsL0vAS+Zl0p1DQsnBhYpJtAhAmOxykSQB0Ew0uu8iIbKOsOmNQGCNzGm1zmxn4NKEqIRvPWF1M9X2wTBwBZSJO/UUIYC1s7JyGy2tBV1BFgQitpd9hQ4q9ZV7e88RIwEUhGDJFSkLWm2cuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz99VIc1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz99VIc1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650801F000E9;
	Thu, 28 May 2026 07:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779953396;
	bh=aDOa8kh/Id+1yuDi77fqzhOjDq3kNO9XuXfLigL6hNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hz99VIc1l3Jn1sXc02Ki72tIThOo/pCimcBbb35iGZ2QcWvJtPLhQk++gOQq9FRsY
	 nVi7WJcFouW1ulvxoXhVAyM7VkVAZYHsP0U24BuRm0w76z+bKGWDfjB8zUl8JpvBtC
	 jTwNn60qBLG/VM5VHNMHYdCdZOs1Z6+NY6aK2E/PcGxcb2D5dpNZxF1QiwH0X9MVUo
	 eWl5rbtmUhgWibZpXQCwWzg/1E09ta6DISs+T0oAdbQk709UPPTPcFGD1XRqCTEnwZ
	 ZreyVBHdq5YeQ3triCNjmQdFkzprKMZ1hmMetRJ3lnCaN0LtIguiZZJMK34R48NcFH
	 QbfidBv5WSjXA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/2] mm/damonn/lru_sort: handle ctx allocation
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260528061110.2172-3-sj@kernel.org>
References: <20260528061110.2172-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 07:29:55 +0000
Message-Id: <20260528072956.650801F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Module load parameter 'enabled' causes unconditional module load f=
ailure.

Pre-existing issues:
- [High] TOCTOU race condition between sysfs store and module initializatio=
n leading to data corruption.
--

commit 98350211104d3088f79c58844d29a85c013ac178
Author: SeongJae Park <sj@kernel.org>

mm/damonn/lru_sort: handle ctx allocation failure

This commit attempts to fix a NULL pointer dereference in
damon_lru_sort_enabled_store() by returning -ENOMEM if the damon_ctx object
failed to allocate during initialization.

> diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> index eca88ed941b32..8298c6001fd09 100644
> --- a/mm/damon/lru_sort.c
> +++ b/mm/damon/lru_sort.c
> @@ -476,6 +476,10 @@ static int damon_lru_sort_enabled_store(const char *=
val,
>  	if (!damon_initialized())
>  		return 0;
> =20
> +	/* damon_modules_new_paddr_ctx_target() in the init function failed. */
> +	if (!ctx)
> +		return -ENOMEM;
> +

[Severity: High]
Will this cause an unconditional module load failure when passing the
enabled parameter at load time?

When loading the module with modprobe damon_lru_sort enabled=3DY, the kernel
calls parse_args() before the module's init function damon_lru_sort_init()
is executed.

At this point, damon_initialized() returns true because the damon_core
dependency is already initialized, but ctx is still NULL since the module
init function hasn't run yet.

Could this evaluate to true and return -ENOMEM, causing the entire module
loading process to fail and abort?

>  	return damon_lru_sort_turn(enabled);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but is there a TOCTOU race
condition here between the sysfs store and module initialization?

The kernel exposes module parameter sysfs files via mod_sysfs_setup()
before executing the module's initcall do_init_module().

If a userspace process writes to this sysfs file concurrently while
damon_lru_sort_init() is executing, could it trigger the following sequence?

Userspace sysfs write happens right after damon_lru_sort_init() allocates
ctx. This callback sees ctx !=3D NULL and calls damon_lru_sort_turn(true).

Concurrently, damon_lru_sort_init() continues, reads enabled =3D=3D true
(updated by the sysfs store), and also calls damon_lru_sort_turn(true).

Does this concurrent execution of damon_lru_sort_apply_parameters() and
damon_commit_ctx() on the same ctx without locks lead to list corruption
or double frees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528061110.2172=
-1-sj@kernel.org?part=3D2
