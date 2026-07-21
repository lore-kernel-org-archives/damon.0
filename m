Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E7A2DECCB
	for <damon@lists.linux.dev>; Tue, 21 Jul 2026 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613053; cv=none; b=ncxya/1b3+yj9l6xHW2uSHkHV6HHHIjW/imqeq1c3m51oRvu/I7WYSo1gSm4m7mxwhkjQWco/5XoUdtGnb+HpFYT0jgYfJ3wQNKPXI22AV2387fuiypmGBST7F7lXojEsEtDkmi2Rpt6iFF3VA+rXGBqfjZPhaHvjSM2Qyw+Mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613053; c=relaxed/simple;
	bh=arUgLobA45w/bVjYORMEJ9yonKOKahNngQquFKHoZfw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s8CvUXJp1xSSjjxYhKK07HFoQOs4sn32WIym6BYejgZsBhft3BTlXgq7dgUfEB03FIN2KXc1/h2TUzA7R64QK7u5hMkL846UTKWtgJRzTtiy1PFp03hEF5sGMYAfekmhWSh33locmUpRg2FhleqVJ2cjqVbKMUwny9ZCQiLDBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbBuwGVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbBuwGVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A6A1F000E9;
	Tue, 21 Jul 2026 05:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784613052;
	bh=CUXDWMhAR73sk6LcI5VBc2eMkj6UFCiMaDHcgEMPy3g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbBuwGVTa7Yy8O3jZmPSwpKXTLHyPK1h8c9jVSfuFx0uY67eIg1WDJpSt0+6XoNQ+
	 FRGZuVx53tH1r0UPrJAEhCkf+J8SiTFo4NVFGopqNfaC2UhtTjSzg12Uh9+r+ECZha
	 ZL836VEUxnD+gRZlQa3txK7Ol3p9jRJOatMPPlbcQcRdYGgMinfaYqF775M6Y9ztc9
	 zIKppFEBAdusJAGVPgbcdk9JYXt4U4NMzjxpBdn1t30DEAl3lw1LdqsR4hCOazqQ8h
	 vOs6ceC1Q0+yQU10htk3FxutisJRbk9lNbsnzhCLyoqeTqUCpBtEkZk+MAKR85UoaG
	 iOe3iqj0KcM7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.18.y] samples/damon/mtier: fail early if address range
 parameters are invalid
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260721053718.177006-1-sj@kernel.org>
References: <2026072008-humongous-quintuple-a2a9@gregkh>
 <20260721053718.177006-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:50:50 +0000
Message-Id: <20260721055051.23A6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation in DAMON mtier module leading to division by ze=
ro
- [Medium] Memory leak of damon_ctx on damon_start() failure in sample modu=
les
--

--- Patch [1]: [PATCH 6.18.y] samples/damon/mtier: fail early if address ra=
nge parameters are invalid ---
commit 5cd52e0f168fe2427f3477f7a3e8f97bec2d9dca
Author: Zenghui Yu <yuzenghui@huawei.com>

samples/damon/mtier: fail early if address range parameters are invalid

This commit adds a sanity check to damon_sample_mtier_build_ctx() to ensure
the starting address is less than the ending address. If the range is
invalid, it fails early to prevent triggering a WARN_ONCE inside
damon_new_region() when the module is enabled with uninitialized or
memoryless node addresses.

Link: https://lore.kernel.org/20260629144432.133962-1-sj@kernel.org

> diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
> index 775838a23d935..dab8fb10b617a 100644
> --- a/samples/damon/mtier.c
> +++ b/samples/damon/mtier.c
> @@ -120,6 +120,8 @@ static struct damon_ctx *damon_sample_mtier_build_ctx=
(bool promote)
>  		addr.end =3D promote ? node1_end_addr : node0_end_addr;
>  	}
> =20
> +	if (addr.start >=3D addr.end)
> +		goto free_out;
>  	region =3D damon_new_region(addr.start, addr.end);
>  	if (!region)
>  		goto free_out;

[Severity: High]
This is a pre-existing issue, but since we are adding parameter validation
here to prevent panics, should we also validate node0_mem_used_bp and
node0_mem_free_bp later in this function?

If a user writes 0 to these sysfs parameters, they are passed directly to
damos_new_quota_goal() as target values:

    quota_goal =3D damos_new_quota_goal(
            promote ? DAMOS_QUOTA_NODE_MEM_USED_BP :
            DAMOS_QUOTA_NODE_MEM_FREE_BP,
            promote ? node0_mem_used_bp : node0_mem_free_bp);

When kdamond evaluates the quota score, does this zero target_value
cause a divide-by-zero kernel panic in mm/damon/core.c:damos_quota_score()?

    highest_score =3D max(highest_score,
            goal->current_value * 10000 /
            goal->target_value);

[Severity: Medium]
This is a pre-existing issue, but I noticed a potential resource leak
in the error handling path for the contexts built by this function.

When the contexts are started in damon_sample_mtier_start():

    ctxs[1] =3D ctx;
    return damon_start(ctxs, 2, true);

If another exclusive DAMON context is already running, damon_start()
can fail and return -EBUSY. Does returning this error directly leave
the newly allocated struct damon_ctx structures leaked, along with
their associated targets, regions, and schemes?

It looks like the same pattern might exist in damon_sample_prcl_start()
and damon_sample_wsse_start(). Should there be cleanup logic when
damon_start() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721053718.1770=
06-1-sj@kernel.org?part=3D1
