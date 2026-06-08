Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01C2F5A13
	for <damon@lists.linux.dev>; Mon,  8 Jun 2026 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917896; cv=none; b=uIF684ZfEBecOz/4jtCgTfAPqJYdjXTmWVnBm7AOaZWSyWbWSlfgLumf8uT89Olnve0eWW2D4PUG0nI6GQiUG2W4rThgxVAXhmtmLtHFpm4S5/peCOhyhCzUu0wV7+A5YK26p/zIl3kaBdA2XvfXO+4Tnuro+HMeSX0Jv1NljX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917896; c=relaxed/simple;
	bh=nSqa8ulaSJ8ivkiEVgSO2Y9u8yzyddjY6DeebhQANdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TcJAAFBtrwT7y5NGVeX84avPaJQSzPHxIhsNzjbDsO/+plibxENnLdWFQpAgMofay6Nl+M8NHarlvcYIWseuwkJmVT0VhlkPOJ5IIYdAKLyr2W+GhcWmoFMwoMcjc1/+bGXOynk8FSTIpG9PIUGJXzixBhDPIgyxtlzCAmVXGvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/OWHAmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/OWHAmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274231F00893;
	Mon,  8 Jun 2026 11:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917895;
	bh=f/Df36jJgVBbiXUbl2np4wWdhV42M71ZUWY5OMz5J9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P/OWHAmdCgNl2ZWhIOaVdoa95VXKfJwUvJNtcpuWKt32DjccAi378vjKEZX/Xkq7I
	 0b2sUndSmrNgdO9svxNFzF3Pd/SYxZta9szelR1RkE3H4MHo2nMh624V4f2hcmC0eZ
	 dVXyE0j1UkPj+KqPIzrahwt7Js6vXOUkFF0gCSdsv85iVWuKt3lAKwlA+rb0+tZH6S
	 XrUaijQv6BfTz1HBRRYFY2eCTH4u62lQed+lhjZMI4FcoM1BqLClMGwSBZ71YLq6gU
	 1qau9fZpniTgX4AKs3/0UkCIf1SKRC7Ct+4mHsVQUQGyINpR3VCFyUB7ltnJ+xXQgN
	 pbqnfeQUENxlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] samples/damon/mtier: fail early if address range
 parameters are invalid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zenghui Yu" <yuzenghui@huawei.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260608111534.264-1-yuzenghui@huawei.com>
References: <20260608111534.264-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 11:24:54 +0000
Message-Id: <20260608112455.274231F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The newly added validation for invalid address ranges bypasses t=
he `detect_node_addresses` auto-detection path, leaving it vulnerable to th=
e exact same `WARN_ONCE`.

Pre-existing issues:
- [High] Memory leak and potentially orphaned threads if `damon_start()` fa=
ils.
--

commit 08cd6a6fdfc8b3e6b6d9d4a3a29b99f99163573b
Author: Zenghui Yu <yuzenghui@huawei.com>

samples/damon/mtier: fail early if address range parameters are invalid

This commit adds a validation check in damon_sample_mtier_build_ctx() to
fail early if the start address is greater than or equal to the end address.
This prevents a warning from triggering when damon_new_region() is called
with invalid parameters before node addresses are properly initialized.

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 775838a23d935..4a5d3fb12e1b3 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -118,6 +118,9 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  	} else {
>  		addr.start =3D promote ? node1_start_addr : node0_start_addr;
>  		addr.end =3D promote ? node1_end_addr : node0_end_addr;
> +
> +		if (addr.start >=3D addr.end)
> +			goto free_out;
>  	}
> =20
>  	region =3D damon_new_region(addr.start, addr.end);

[Severity: Medium]
Does this leave the detect_node_addresses auto-detection path vulnerable to
the same warning?

If detect_node_addresses is true, nid_to_phys() is used to compute the
address ranges. For online memoryless nodes (like CPU-only NUMA nodes),
node_start_pfn equals node_end_pfn, which means addr.start =3D=3D addr.end.

Since the new check is restricted to the else block, would the auto-detecti=
on
path bypass validation and still pass identical start and end values to
damon_new_region()?

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory leak and
thread handling problem in damon_sample_mtier_start() when damon_start()
fails.

Looking at damon_sample_mtier_start():

    ctxs[1] =3D ctx;
    return damon_start(ctxs, 2, true);

If damon_start() fails (for example, returning -EBUSY because another
exclusive context is running), it returns an error code immediately without
calling damon_destroy_ctx(). Does this permanently leak the dynamically
allocated contexts?

Additionally, in mm/damon/core.c:damon_start():

    for (i =3D 0; i < nr_ctxs; i++) {
        err =3D __damon_start(ctxs[i]);
        if (err)
            break;
        nr_running_ctxs++;
    }

If damon_start() succeeds on ctxs[0] but fails on ctxs[1], it breaks out
and returns an error without stopping the already started ctxs[0]. Will
this leave ctxs[0] running indefinitely as an orphaned thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608111534.264-=
1-yuzenghui@huawei.com?part=3D1
