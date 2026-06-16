Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1326B0A9
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623453; cv=none; b=SVm/Iht/MhuSBZUKVizfWI/O/NejbRtlLz1LE2jujuEei0X6sWkdmZ5pOIngPJThLOcdqK9ALjw1lk4T5Wy3UaFpoX5VXuHDb1IwnKSebrScARFInfzizaMOi0sBcq5vuCoSk+fmUgAktevymnN6rmt8jTOcoCCKaKlHxWTioSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623453; c=relaxed/simple;
	bh=zR00yLDCx3Zpw+MXabJHUhTy77xG9STeMAFJqva1brM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r7nLyBakdPoCGe9IDDM+Pgxzm0ChTYA/KpeXFsNvz4+u7wpTYzu9sZC/w6kfvIjb8GswjJuftn+fnNySwQgQlBu1Pv5pSlMN+Mfui2oy1dAOzBAjLn6xbsC3yMVwfSidHLV6LotVCe+FlmUrqxMfXCFOAF0iAvNSC0hjMI7NeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkvZXDIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkvZXDIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0241F000E9;
	Tue, 16 Jun 2026 15:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623452;
	bh=1Nvs5Z4hIjaBsS6AOcI8tjpH3s+Y9DlpGYKNzqYIW48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkvZXDINCKhxJj5qnglPjv1NakoYWH5ylA2wAuZ2/U1n3Wqver6C9y7dSn8yz0IsK
	 eIxqy8IitFknNdJVvrr4Awa8HTWMr2MmCSF8H6pPCCtlHgwZv+S8Hkq6cPkEMjf5Wv
	 fIuKe2Nd7WP6HTsqRofyASYsrHP3Sm7gkg8Z9NTEz8VHkZ7JSnkLD7HuFvky6a0dby
	 YEXvFt71GvsPDT1XZeWbF8QFYm9Eh2O6ORrn/kb7NwH9/daqViFUngO3whX0257t9j
	 qIYHdy8GQyx3PkfzdtQVXWyM0fWizTZH67tJ0o3tfm9ptxZQOO4sdfIVCrogdLBkEc
	 8oGzIxnskP9bA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 9/9] mm/damon/sysfs: kobject_del() probe dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-10-sj@kernel.org>
References: <20260616150844.88305-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:24:11 +0000
Message-Id: <20260616152411.AD0241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch adds `kobject_del()` to `damon_sysfs_probes_rm_dirs()`=
 to fix sysfs name collisions caused by delayed kobject releases, but misse=
s the exact same flaw on the error paths of `damon_sysfs_probes_add_dirs()`=
 and multiple other array-building functions. This leaves the system vulner=
able to `-EEXIST` failures upon retry after an error.
--

commit 4a5efc2733f009261a15fd64a4d901ca19499bb5
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() probe dirs

This commit fixes a directory creation failure caused by name conflicts
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It adds missing kobject_del()
calls during the removal of probe directories.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 04725ff3d9f3c..04ca0a34e1206 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1139,6 +1139,7 @@ static void damon_sysfs_probes_rm_dirs(
> =20
>  	for (i =3D 0; i < probes->nr; i++) {
>  		damon_sysfs_probe_rm_dirs(probes_arr[i]);
> +		kobject_del(&probes_arr[i]->kobj);

[Severity: Medium]
This is a pre-existing issue, but it looks like the same lack of
kobject_del() on error paths could cause name collisions upon retry.

For example, if damon_sysfs_probe_add_dirs() fails inside
damon_sysfs_probes_add_dirs(), the error path drops the probe by calling
kobject_put() without kobject_del():

mm/damon/sysfs.c:damon_sysfs_probes_add_dirs() {
    ...
		err =3D damon_sysfs_probe_add_dirs(probe);
		if (err) {
			kobject_put(&probe->kobj);
			damon_sysfs_probes_rm_dirs(probes);
			return err;
		}
    ...
}

Under CONFIG_DEBUG_KOBJECT_RELEASE, if userspace immediately retries the
operation after an error, won't kobject_init_and_add() fail with -EEXIST due
to a name collision with the lingering directory?

Should we also add synchronous sysfs deletion via kobject_del() to these
similar error paths?
- mm/damon/sysfs.c:damon_sysfs_targets_add_dirs()
- mm/damon/sysfs.c:damon_sysfs_contexts_add_dirs()
- mm/damon/sysfs.c:damon_sysfs_kdamonds_add_dirs()
- mm/damon/sysfs-schemes.c:damon_sysfs_schemes_add_dirs()

>  		kobject_put(&probes_arr[i]->kobj);
>  	}
>  	probes->nr =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D9
