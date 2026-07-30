Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889613A244
	for <damon@lists.linux.dev>; Thu, 30 Jul 2026 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374309; cv=none; b=Sp249Lgh7MRc4pBQTlauytZPB88kykPYzIOWh5cMbukMBt6uCDneMAOA2LJSoTiPoKYlZaB0V87s8FRp3qSTuuK+d8qOiZB4am4MknMzZDnAbbtNN+EcZLsrsDee9QR1Crs0Xxw2XSg2G8VP+Se9AgGS17zXdAFFwJYrAN/pZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374309; c=relaxed/simple;
	bh=9s578Kp7y7TfiB4A3JvSiFi9WqeQpfcn/n4SLM9qwNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q6iwt8tOeOtsq0Bu1z3aWA+L9v4fwEIJ4egCTUpQOms1fgoi8rYHkKoP6HDSVGlG0rMN7ZhIqSAP1irh6YnF55VuTrMqgEduyhSTG583ovTJ5rEYiWtDzwvCwyNJKs1gUuZ01AaAEjgUig8/Hbx+9m/dKvIGwY5Y8Nt3cJCNIeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ahwce4sQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ahwce4sQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CE11F000E9;
	Thu, 30 Jul 2026 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374307;
	bh=epyQK5MnWo3PVsbMkcgX0rDvp2TO1pp3Bw6Fwbg1F5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ahwce4sQtFnPImoCE5FWMUnpEGUZF0M/NsH0e21DguNuNrrenSvv+mtwWs2pAqJz8
	 79+qMINyGIKTYSvz+zG1eLjUeWKZRVmxZwu2v2eGgiSIWtIfg3HZpRydnzRTSequD1
	 bDiq3hDNs5aFFGK+lfkdslgTcNkPMhPGbL3AkxnYrKesATXjcEhwiAYmtaLteJUm9d
	 uiOrG3aw88myDM+8sQ7zTyUUdGuyTJ7c1A2EKGIZ3DaNt7aeZhZYDtiZ5iYcCNd4gU
	 ubrZLo2FUIacMITsoqdT39KpK+aRmzYZ0yv06Y3K6UDWNQFYaLcALaJOf9WHQSpYu7
	 VOApo02NZGYOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/core: validate ranges in
 damon_set_regions()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260730010151.119009-1-sj@kernel.org>
References: <2026072901-stapling-parkway-4887@gregkh>
 <20260730010151.119009-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:18:26 +0000
Message-Id: <20260730011827.71CE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The validation check fails to consistently reject unaligned zero-l=
ength regions, allowing them to bypass validation and silently expand.
- [High] The ALIGN() macro overflows to 0 when evaluating regions near the =
end of the 32-bit address space, causing valid regions to be erroneously re=
jected.

Pre-existing issues:
- [High] Pre-existing leak of `struct pid` references if target addition or=
 context setup fails during sysfs input application.
--

--- Patch [1]: [PATCH 6.1.y] mm/damon/core: validate ranges in damon_set_re=
gions() ---
commit a1c890d67da57c98800fdd95b91daeac6ab475ab
Author: SJ Park <sj@kernel.org>

mm/damon/core: validate ranges in damon_set_regions()

This commit adds a validation check in damon_set_regions() to ensure that t=
he
provided region ranges are valid. It aims to prevent empty or negative leng=
th
regions from causing warnings and divide-by-zero errors in the core logic.

Link: https://lore.kernel.org/20260630035221.146458-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 4b434ebd37c53..0a0bb033f28a4 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -212,6 +212,12 @@ int damon_set_regions(struct damon_target *t, struct=
 damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
> =20
> +	for (i =3D 0; i < nr_ranges; i++) {
> +		if (ALIGN_DOWN(ranges[i].start, DAMON_MIN_REGION) >=3D
> +				ALIGN(ranges[i].end, DAMON_MIN_REGION))

[Severity: High]
Does this logic successfully catch unaligned zero-length regions?

If a user configures a region with start and end both at an unaligned addre=
ss
like 4097, ALIGN_DOWN(4097) evaluates to 4096, and ALIGN(4097) evaluates to
8192. The check 4096 >=3D 8192 is false, which allows the invalid empty reg=
ion
to bypass validation and silently expand into a full page.

[Severity: High]
Will this ALIGN() check overflow on 32-bit systems when evaluating regions
near the end of the address space?

If the end address of the physical memory resource is ULONG_MAX (0xFFFFFFFF=
),
ALIGN(0xFFFFFFFF, 4096) overflows the 32-bit unsigned integer and evaluates
to 0. This makes the check ALIGN_DOWN(start) >=3D 0 unconditionally true, w=
hich
erroneously rejects valid memory regions and prevents DAMON initialization.

> +			return -EINVAL;
> +	}
> +
>  	/* Remove regions which are not in the new ranges */

[Severity: High]
This is a pre-existing issue, but does damon_destroy_ctx() leak struct pid
references if context setup fails?

Looking at damon_sysfs_build_ctx() in mm/damon/sysfs.c:

	err =3D damon_sysfs_apply_inputs(ctx, sys_ctx);
	if (err) {
		damon_destroy_ctx(ctx);
		return ERR_PTR(err);
	}

If damon_sysfs_apply_inputs() successfully adds targets (incrementing struct
pid refcounts) but a subsequent step fails, damon_destroy_ctx() is called.

Since vaddr ops do not define a .cleanup callback and the before_terminate
callback is never executed, the damon_target structures are freed without
calling put_pid(), permanently leaking the PID references.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730010151.1190=
09-1-sj@kernel.org?part=3D1
