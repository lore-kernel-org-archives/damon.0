Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9C4279FC
	for <damon@lists.linux.dev>; Wed, 12 Aug 2026 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531641; cv=none; b=aObWTF5XSDPnnhM794d+bmPyoLJz9tJBJD32lcB6fb9tMFaUZeXDngJYk7Mgs5Bam6lpdqp2UmZWFoXTAN2s+V7REAbdnkvgZntKQQVXg3VuUzae3Y5rMDdiwZYzaI6q01uhEZJg4/dVPjdoUJLn5xeAihMnvF3U2HKePdI+JcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531641; c=relaxed/simple;
	bh=e8cbq5JJVCpRKMGLltyoRPTXxtdsCDOEOeFsNxYdGJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k5F+y0AQr8CrNA4DETAjW91HVCY1KWSPj0XN3lH9GV7drUuf1wLaFvUUQFn6iyT3IqR7EE5tMQlHbrcrn1fDA+KYorwhBYYO7Jyy/v+ZS8uYfFLQ7Rs0fB/S2JamrBlGCCZKkJPzWu99heuQ/0ZKpU3movPhUlLHCyCcBlVv504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMC/Jmy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMC/Jmy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72F81F000E9;
	Wed, 12 Aug 2026 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786531640;
	bh=8DCCZILYQv5IkG5bO/1dNCgAuaZmQFg+fumWFZOaSE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EMC/Jmy6ZVxziK86HJhpLog7M4xjbrTr5et72rLLOBGyJRL2uLoJ4rMZwPtCs07k8
	 TVGDDBpcu2T1FIoWFvCa0exMpxUzvF9wRgIyotvxv782vMV0jRJCx2+28/dh3She4N
	 j2Vv1SBRrx0gM72fEGKw2K3OsdAKW97b0tFhU6Rt5IfkWS77x0/WT610lHJlhenp05
	 cK3JIeWcuBAiO/xNoGCjNVmMWu2BnSt0CSyOF86doEFclMamaS2pA2x8soWeozFhYg
	 r9plKjt7vc39ScHrQg6xWx83aTvY1AnsX1g/iRXsvWd6CTVB6OFWY1ewsy5HRYxPEv
	 iuaWTqHQtDb3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] docs/mm/damon/design: accurate semantics of
 nr_snapshots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260812104002.15225-2-aethernet65535@gmail.com>
References: <20260812104002.15225-1-aethernet65535@gmail.com>
 <20260812104002.15225-2-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:47:19 +0000
Message-Id: <20260812104719.D72F81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The commit updates documentation to match buggy code behavior rath=
er than fixing the underlying logical flaws in the `nr_snapshots` counter. =
`nr_snapshots` incorrectly increments per target instead of per snapshot, a=
nd skips entirely when quotas are full.
--

--- Patch [1]: [PATCH v2 1/3] docs/mm/damon/design: accurate semantics of n=
r_snapshots ---
commit 11b4a9c760b881c063ff5e1eec0248b087d6a31f
Author: Liew Rui Yan <aethernet65535@gmail.com>

docs/mm/damon/design: accurate semantics of nr_snapshots

This commit updates the DAMON design documentation and header comments
to align the description of nr_snapshots with the current behavior
implemented in the code.

> diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/d=
esign.rst
> index aed6cb1cf4831..1739aeec6eb95 100644
> --- a/Documentation/mm/damon/design.rst
> +++ b/Documentation/mm/damon/design.rst
> @@ -846,8 +846,8 @@ scheme's execution.
[ ... ]
>  - ``qt_exceeds``: Total number of times the quota of the scheme has exce=
eded.
> -- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is t=
ried to
> -  be applied.
> +- ``nr_snapshots``: Total number of DAMON snapshots that the scheme is
> +  completely tried to be applied.
>  - ``max_nr_snapshots``: Upper limit of ``nr_snapshots``.

[Severity: High]
This is a pre-existing issue, but does updating the documentation to match
the code behavior paper over an underlying logical flaw in the nr_snapshots
counter?

Looking at damon_do_apply_schemes() in mm/damon/core.c, the counter updates
like this:

mm/damon/core.c:damon_do_apply_schemes() {
    ...
        /* Check the quota */
        if (damos_quota_is_full(quota, c->min_region_sz))
            continue;
    ...
        if (damon_is_last_region(r, t))
            s->stat.nr_snapshots++;
    ...
}

Because this increments at the last region of a target, if multiple targets
are present, does the counter incorrectly increment per target instead of
per snapshot?

Additionally, if a restrictive quota fills up before the last region of a
target is processed, the early continue skips the counter increment entirel=
y.
This could mean a scheme configured with a max_nr_snapshots limit might
never reach its limit.

Should the underlying code be fixed to increment once per snapshot regardle=
ss
of quotas and targets, rather than updating the documentation to reflect th=
is
behavior?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104002.1522=
5-1-aethernet65535@gmail.com?part=3D1
