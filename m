Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809F349AF6
	for <damon@lists.linux.dev>; Thu,  2 Jul 2026 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013529; cv=none; b=bcC8fQZBdVklUjCfQnE5T22eOcmfU/DfhFyQVc0aYQEJ1+/nJQBaX6FNGY3qkysiLZybWU71AYa4yAe5DMp2IL8FPvRC7PB7eZ5EZPUn2nbl7UumFoUa2u3AzsgTYcnRCoTH7uxFEamdmsGna//9ZTFx0iH6Qx5fVqp+Oca0Sbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013529; c=relaxed/simple;
	bh=AG7fIQ//ue1wL4yI1upLAaqXe/oaQ5fozCBo7rMzC34=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W2g7TFBxQoUG0nFz2Dp8Y4dTB/ggbPp+Gi65mXZ4OfWJHcviZwN+qjwU0zPjyKU5+c23cdpsp8nUgQHUhfx+yBgsVmfQ2B6vZGupZK3dfjbSaBMYRUk3YUoLhPOw+HPLAHWmxXuKqPCpxwKxKtRwNuV3bkBWGe7R3ySwP/t0U3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os/u5IMz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os/u5IMz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADACA1F000E9;
	Thu,  2 Jul 2026 17:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783013528;
	bh=IQyzjLrY1BgJ4UtXmVzAVunvmbKo5qJ3kv6eO1cw+rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Os/u5IMzcF64xza3NEPWcnaJvUoexDCCJRFnKEM4DY9D9gWRt1PI8BDrtc9nbCZc4
	 cSmA3l0T9qO6KmFgCkVGyQ7UscIaidJs3iPfDz4Sjfe0IhjFB5DsBJ5rqXy83nnVLM
	 0Jd9QcI+bMW9xG6k8zz76i5hbtebqmNX67XOIGxcz00BxToceqypSurb6EiIzHYz8z
	 WO5lJbIeknaD2m2kJ671wwpRFzVbkwPUoyxJrRHGoApB8NCzoexbFQXD6ATp/mMKUB
	 baP5+AkZ0O3aHWMALof8Wc+YP1mC1d9zrQvRfePYofBMmtHqp6drJLMtdrnFI1AJdI
	 rTY1C5xIhb0BA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 3/3] mm/damon/sysfs-schemes: set probe hits as
 pseudo moving sums
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260702171714.88278-4-sj@kernel.org>
References: <20260702171714.88278-1-sj@kernel.org>
 <20260702171714.88278-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 17:32:07 +0000
Message-Id: <20260702173207.ADACA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] damon_probe_hits_mvsum() returns an artificially inflated moving=
 sum when left_window_bp =3D=3D 10000 after an attribute update.
--

commit aa52db4de056d7c850beaa9ef06ec63a3befcbf2
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: set probe hits as pseudo moving sums

This commit updates the DAMON sysfs interface to expose probe hits using
a pseudo moving sum instead of incomplete counters. It uses
damon_probe_hits_mvsum() to calculate the value, similar to the logic
used for nr_accesses.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index dbf2b0515d582..32f495a96b17a 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -110,7 +110,8 @@ static int damos_sysfs_probes_add_dirs(struct damos_s=
ysfs_probes *probes,
>  		struct damos_sysfs_probe *sys_probe;
>  		int err;
> =20
> -		sys_probe =3D damos_sysfs_probe_alloc(region->probe_hits[i]);
> +		sys_probe =3D damos_sysfs_probe_alloc(
> +				damon_probe_hits_mvsum(i, region, ctx));

[Severity: Medium]
Can this result in an artificially inflated moving sum being exposed to
userspace?

Looking at damon_probe_hits_mvsum() in mm/damon/core.c:

mm/damon/core.c:damon_probe_hits_mvsum() {
    ...
	return damon_mvsum(r->probe_hits[probe_idx],
			r->last_probe_hits[probe_idx], left_window_bp);
}

When left_window_bp =3D=3D 10000 after an attribute update, this calculates
current + last.

Because r->probe_hits is not cleared during attribute updates, the
un-cleared partial hits might be erroneously added to the previous
interval's hits. This function seems to lack the safeguard for this
condition that is present in damon_nr_accesses_mvsum().

If users query the stats immediately after an update, could this
silently overflow the unsigned char and expose incorrect statistics?

>  		if (!sys_probe) {
>  			damos_sysfs_probes_rm_dirs(probes);
>  			return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702171714.8827=
8-1-sj@kernel.org?part=3D3
