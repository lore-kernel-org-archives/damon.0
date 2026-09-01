Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763A3C5837
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269812; cv=none; b=YYm1YOdGRG42QZ5/4t1OLala27Ri1dy9qRVEfAsriQYDXT8WBg1R8pMK5xWzsAVMlAd+9S4kXIbKEoVj7c+0OXigLh+jyMKestmYEIi2p5Mh1KG0LDN9NxKtLFbOTyHXlyhJSfHHRCjSu/sunrPEXOqBb4qLgLaTbOL7CRDUNxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269812; c=relaxed/simple;
	bh=b9DgMeQl8yHzP0CIfdyXhOTLh/fGwl7vxweqr1khy6o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ce49ByQufH/yA3UenMv/XqFzqc221irjjHB/eVKahqwPcPz3hrTz8RNwPXESbgU3Z4rXI3x3lYS8dk81vd8nlGR6ZTqVBZC+RWSi23NQqED27eXhcwIetcno8uuHW46zk4nJsM4YgoL9HaHw23n8tAlgNoUhfmH3mpJY7pX5K3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY4jXxm5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY4jXxm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4F71F000E9;
	Tue,  1 Sep 2026 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269811;
	bh=mlQu497ApyzOxIIJU+6JnIjFJN2GZgZd8Es7WPEdQQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IY4jXxm5fXFIJ9nRa9RcKfAWl2aKt8OI3RE9vchvLyMxMMU9rKZyRxEKU2k2m0hgn
	 55zdTvxd2BLwJpmgvct5VRfJ8MYLU8rfKtCrFmN8hgmn69Q54+P2SMri4uDkaFw+55
	 qKbz9ptKBA/c9qOUHTXSVs7y9TcUltUitbgkHrU/XEbEvkK6Px9NoxbdFY1NNjN7e/
	 i3FWhgoeKo0b6IZ+BGDZjDAduuWbnAKZfe1sQBBXEBCAMwPQN+iJS5ficJr0RdhYee
	 VwhydfZpnC+Ax9NZ86/eal7pPE/XtiHbbH8vr0oDKYcigZCvZNZWwbjFNiJVDNgCDr
	 f/lPcjPJYX4PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] mm/damon/core: handle extreme memory state in
 get_in_active_mem_bp()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-9-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:36:50 +0000
Message-Id: <20260901133650.EF4F71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in DAMOS metric calculations.
--

commit 4a4658bd5d39473e6ccb07618a88e601987f2acf
Author: SJ Park <sj@kernel.org>

mm/damon/core: handle extreme memory state in get_in_active_mem_bp()

The function damos_get_in_active_mem_bp() uses the sum of active and inacti=
ve
memory as a denominator. In extreme environments where both are zero, this
results in a divide by zero error. This patch avoids the issue by changing
the denominator to one if it is zero.

Link: https://lore.kernel.org/20260721034756.147011-1-sj@kernel.org

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 3060edf5e4fa6..0df785e72438f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -3006,7 +3006,7 @@ static unsigned int damos_get_in_active_mem_bp(bool=
 active_ratio)
>  		global_node_page_state(NR_LRU_BASE + LRU_ACTIVE_FILE);
>  	inactive =3D global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_ANON) +
>  		global_node_page_state(NR_LRU_BASE + LRU_INACTIVE_FILE);
> -	total =3D active + inactive;
> +	total =3D max(active + inactive, 1);
>  	if (active_ratio)
>  		return mult_frac(active, 10000, total);
>  	return mult_frac(inactive, 10000, total);

[Severity: High]
This isn't a bug introduced by this patch, but it's a pre-existing high
severity issue in the exact function modified.

Could this mult_frac() calculation overflow on 32-bit architectures?

When active or inactive memory exceeds approximately 429,496 pages (about
1.7GB) on a 32-bit system, the intermediate product in mult_frac():
(r * n / d) where r is (active % total) and n is 10000

will overflow the 32-bit unsigned long before division. This wraps around
and causes Damon to apply completely wrong quotas, degrading memory goal
reliability.

Does this same 32-bit overflow issue also affect other metric calculations
in mm/damon/core.c, such as damos_get_node_mem_bp() and
damos_get_node_memcg_used_bp() which similarly compute:
mult_frac(numerator, 10000, i.totalram) ?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D8
