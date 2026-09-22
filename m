Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC772481647;
	Tue, 22 Sep 2026 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098213; cv=none; b=Y3bb3vjs3TNZnSo2mYktlOSNPx8u3rKORJ94eeJv6SJg7jAqkH8G8M493L881eMTRR9+tE7xn1F7zNb2NQiPc12RrJaAiFOmHkxMqdKITxk/nxqrFI8HgzO5/3fRhqxlKMJJRaE3NKFrDwoJQyGyfI7Bp+zVYL1346X0JB2Ic3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098213; c=relaxed/simple;
	bh=Amn7S2wVmj3QJRmq0UsbGZV26fdIhNmQ7f5wGdYGUlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mR3HrCuzVvs+C5Xurv0etGaQQM/PQLDQxKgEw06EsilBbS/eqcsNSyFBG6V9g/wz9FueaIVaZ5/PcS27dj2cD4TPrUgQ+U6qe1/XLBmu9uQR7WTyp0n/On5DRgxQTfprhqb1fjcJG7Cele1TaD9V0m91SJEcV05At01R1M3oS24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYFLiP7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYFLiP7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F491F000FF;
	Tue, 22 Sep 2026 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790098209;
	bh=PUIY0VUwtt8q//5KqqAzZD675vyrsCDrTUtmXjojNAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nYFLiP7QJ3YwusjDrEQ226c9cUOVmszwG8BdQBKh0rdZbLio1QEj4e0NyP4lCTeOI
	 jG2WPC5CXYtCbHCAHwgQzB3IvfPY1vdVrBmdjDUlgYS5wWCaUXxclycKozTFcB08OY
	 fc4IKF3MMwcO3UUP3m3bErb5bIaL4IBlFZxFdNvm4eksI3if4//vnCq0Uegs3Np1qM
	 YNdIA9RmjNFE3rVzWdB+QjjAWtYZ4+j+jrsN7mc1ZKl8XgFS0wQuPyr++W4zbTmsUD
	 ZmPx0DDOp2WlJoQ4hv+gAU111BOWxtHTl2pL2zQmKRmtT9I/vVexJaLGkOdTa8H7ev
	 hCIFhoYXihn8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] xen: use hw_pte_t for PTE range callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Usama Anjum" <usama.anjum@arm.com>
Cc: intel-gfx@lists.freedesktop.org, bpf@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260922-pte0-v3-9-5670b8cb9059@arm.com>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-9-5670b8cb9059@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 17:30:09 +0000
Message-Id: <20260922173009.52F491F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] xen: missing hw_pte_t conversion for x86 Xen callbacks
--

commit cf1ba61f002ea6950852250dfd8d5d0a5b979c23
Author: Muhammad Usama Anjum <usama.anjum@arm.com>

xen: use hw_pte_t for PTE range callbacks

This commit updates Xen callbacks to use the hw_pte_t pointer type, matching
the updated generic PTE range and remapping helpers. It maintains software
PTE values as pte_t to support architectures that select the distinct
hw_pte_t wrapper.

>     Generic PTE range and remapping helpers now pass pointers to PTE table
>     storage as hw_pte_t *. Update the Xen callbacks to match those interf=
aces.
>    =20
>     Keep software PTE values as pte_t and continue to access them through=
 the
>     existing PTE helpers. This is required when Xen is built for an
>     architecture that selects the distinct hw_pte_t wrapper.
>    =20
>     Reviewed-by: Juergen Gross <jgross@suse.com>
>     Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>

[Severity: Low]
Were some x86-specific Xen callbacks missed in this conversion?

Looking at the source, these two callbacks appear to still use the old
pte_t * type signature instead of hw_pte_t *:

arch/x86/xen/grant-table.c:gnttab_apply()
arch/x86/xen/mmu_pv.c:remap_area_pfn_pte_fn()

While this currently compiles because x86 aliases hw_pte_t to pte_t, it loo=
ks
like it violates the generic API contract since they are passed to
apply_to_page_range(). Could this cause a build or CFI failure if x86
ever opts into ARCH_HAS_HW_PTE_T?

> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index 1dcc4675580ed..b013bcad99b5b 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -301,7 +301,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct =
gntdev_grant_map *map)
> =20
>  /* ------------------------------------------------------------------ */
> =20
> -static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
> +static int find_grant_ptes(hw_pte_t *pte, unsigned long addr, void *data)
>  {
>  	struct gntdev_grant_map *map =3D data;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-pte0-v3-0-=
5670b8cb9059@arm.com?part=3D9
