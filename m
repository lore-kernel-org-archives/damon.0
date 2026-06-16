Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3724C37DEBF
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623673; cv=none; b=V4OTm+oIq3sz6Y2UJ81ZT5DOxhBP9qbHuOZC0mJr/GeXzCndLuxJAIqzAvsXQHvyyRNOLr+ENcOQeoz+Jg0uwvYkXK/ad8GPbalkmftP4xDL6ClIZAscAEm4OBWds1PZZAL8LD/384ZudNW1STCTDv7JOBENxZP3qgysICZqt/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623673; c=relaxed/simple;
	bh=pe+Tc6+VE0zf4A6GTajCjuzvI3lQLzqUEzgXBoAlyzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1BkbWoDb2xQLKUsN0/IZ+Mg5Ehax+wBImZPyV2wWHDIl8YNktRALsxqfhfV2ItyihnirvQBOlvdo0ZmC/GuI8gZ/WQXDxow4ENJwx/f0Ib5mvw4SI9aSpmgX/6P9sGhlBBBeazX8qLloGW7tfIbRtkTRMbiL4V6KNNNqOPv2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+6w0pUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+6w0pUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DA01F00A3A;
	Tue, 16 Jun 2026 15:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623672;
	bh=mG9kDFZNKOmx3yXarcip+nOird/eLv+pc+T/CsU4TKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W+6w0pUULNy3nzSBHjHijrzFlrxTrQHPFbjtAlFG/r37g8wonmSelq5LYWxlhlW81
	 1zlwF9ZXtLjh6BNCTnODhiUcU/EI9xW01r1UXELnuocWh/EWWT8EcGvkMV3TRUSPBU
	 YsgVUEh7A+9wXM06/ONKMPbIrWWEi8iPgllVeZF+mlFyuck1hEcsv1vkf8Onz02m08
	 lwMMb8umjAzpIjOxZsaWpHJkZMHvrGk5F+JGfQDz1uAYTn9QcCLyg1Mwf+Vbdj/GFl
	 ReMrW3JW7746YOP4ujBSNIB7ZII2bVLFHcxsgx9GLsIMJA/5Mdz3QETCqLYMXRst+w
	 A2yKUKmqAt2Uw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/9] mm/damon/sysfs: kobject_del() probe filter dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-9-sj@kernel.org>
References: <20260616150844.88305-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:27:51 +0000
Message-Id: <20260616152751.D9DA01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `kobject_del()` in `damos_sysfs_probes_rm_dirs()` leading =
to sysfs name conflicts.
- [High] Missing `kobject_del()` on error paths in `_add_dirs` array-initia=
lization loops causing `-EEXIST` name conflicts on retries.
--

commit d2e0c9ec8c59c96ff7123c668d926efc99e5b382
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() probe filter dirs

This commit adds kobject_del() calls in damon_sysfs_filters_rm_dirs()
before kobject_put(). This prevents directory creation failures caused
by name conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index f72e1e37df9d8..04725ff3d9f3c 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -960,8 +960,10 @@ static void damon_sysfs_filters_rm_dirs(struct damon=
_sysfs_filters *filters)
>  	struct damon_sysfs_filter **filters_arr =3D filters->filters_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < filters->nr; i++)
> +	for (i =3D 0; i < filters->nr; i++) {
> +		kobject_del(&filters_arr[i]->kobj);
>  		kobject_put(&filters_arr[i]->kobj);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but should this fix also be
applied to other similar cleanup loops?

Looking at mm/damon/sysfs-schemes.c:damos_sysfs_probes_rm_dirs():

	for (i =3D 0; i < probes->nr; i++)
		kobject_put(&probes_arr[i]->kobj);

This iterates over probes_arr and calls kobject_put() without kobject_del(),
mirroring the exact bug this patch addresses. When
damos_sysfs_probes_add_dirs() fails and calls this cleanup function, does
this delay directory removal and cause a -EEXIST collision if retried?

[Severity: High]
This is a pre-existing issue, but do the error paths in the _add_dirs array
initialization loops also need kobject_del() calls?

If a nested setup function fails after a successful kobject_init_and_add(),
the error path drops the reference but misses a preceding kobject_del().

For example, in mm/damon/sysfs.c:damon_sysfs_targets_add_dirs():

out:
	damon_sysfs_targets_rm_dirs(targets);
	kobject_put(&target->kobj);
	return err;

If damon_sysfs_target_add_dirs() fails, the target is not yet in targets_ar=
r.
Does putting the kobject without a preceding kobject_del() leave the
successfully added sysfs directory lingering, leading to -EEXIST name
conflicts on retries?

Similar error paths missing kobject_del() appear in:
- mm/damon/sysfs.c:damon_sysfs_contexts_add_dirs()
- mm/damon/sysfs.c:damon_sysfs_kdamonds_add_dirs()
- mm/damon/sysfs.c:damon_sysfs_schemes_add_dirs()
- mm/damon/sysfs.c:damon_sysfs_probes_add_dirs()
- mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir()

>  	filters->nr =3D 0;
>  	kfree(filters_arr);
>  	filters->filters_arr =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D8
