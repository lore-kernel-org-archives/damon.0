Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134A45BD5F
	for <damon@lists.linux.dev>; Wed, 17 Jun 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709941; cv=none; b=XYzU2hF2bjE7lZjiVtdh9y7UEIq7svqTwyYoA2YpPH7E23rs8zZRRmCBGPmwJpzP25/SG1r2lJfu7v7yBvk4BGz0b5M80rj0WlZkZilA98KPnLzEb81cvOTGbCyTw1aTKeIeyA/gMst1TbfbD7cWu4zfiFRzunIwZ/qqs0miz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709941; c=relaxed/simple;
	bh=zUDsb4acWaZdGlJPUxZ3vmej2bM7sOgJ/UNsYA1eYww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEM7YYKzZwXn4Cou9V6vy//04nB9BsoIVlP1LyX1lmSOYIKH8e2K06oMIDCFQy2O8jInPOCaLlowHXIOaxwkpUujQLqvY4miNTb2RWKRGIJaWOlcq7mz4nxwQrpKvVAAjq5Z1vP51DF4GGSqVz6o5DrhNaOag7yDBHQqwEBcTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGQ6Sbz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGQ6Sbz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F322C1F000E9;
	Wed, 17 Jun 2026 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709940;
	bh=6JueIlQrR8+V0jdhrwTaIXaJgFf/Anmms/V4SLdUD5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGQ6Sbz+JuyO4RhV20GPYFzWdYvjRXCZLcjmcBs1Mn6hEALihdmxIRhXr6B+l75pW
	 c5UJLxq9KMBCARiT9dppEF7VaxmijvOW7F2u6KnvCNTLZ/R72f3bY4aWdrzXebzFhg
	 LF1Pd2+boJ3I3lVYqbnnDrCuIRliwtlFtnvnVXcNi/eHw0MT7znx8r72AiqyeBmaBx
	 iOgOZemSaFi1kO1m+UljVsd5y5et7N/gCHZMZaOPKKdkRatpqNvBE3YNIJxYdh59Hn
	 XOC4O7aDCAjtgq2Hlf/Dn22qTFwPd7jFoSZonMJWc1MS3i63vOO/BZp2zhf19r2yFq
	 6VXcdsbb3KjDw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 10/11] mm/damon/sysfs: kobject_del() probe dirs
 in probes_addd_dir error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260617144807.91441-11-sj@kernel.org>
References: <20260617144807.91441-1-sj@kernel.org>
 <20260617144807.91441-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 15:25:39 +0000
Message-Id: <20260617152539.F322C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing kobject_del() in damon_sysfs_schemes_add_dirs() error path=
 causes sysfs name collisions.
--

commit 173cb69d781e9cc64949d93111b81f4c2c036934
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() probe dirs in probes_addd_dir error path

This commit fixes a directory creation failure caused by name conflicts
when CONFIG_DEBUG_KOBJECT_RELEASE is enabled. It adds a missing
kobject_del() call to the error handling path of
damon_sysfs_probes_add_dirs() to properly clean up the kobject before
releasing it.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 36a0e82601697..ffbc99411f53b 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1183,6 +1183,7 @@ static int damon_sysfs_probes_add_dirs(
> =20
>  		err =3D damon_sysfs_probe_add_dirs(probe);
>  		if (err) {
> +			kobject_del(&probe->kobj);

[Severity: High]
This is a pre-existing issue, but does damon_sysfs_schemes_add_dirs() in
mm/damon/sysfs-schemes.c also need a similar fix?

If kobject_init_and_add() succeeds but the subsequent
damon_sysfs_scheme_add_dirs() fails (e.g., due to -ENOMEM), the error
path jumps to the out label:

out:
	damon_sysfs_schemes_rm_dirs(schemes);
	kobject_put(&scheme->kobj);
	return err;

At this point, damon_sysfs_schemes_rm_dirs() only cleans up previously
fully initialized schemes. The current scheme is not yet part of the array,
so kobject_del() is never called for it.=20

When CONFIG_DEBUG_KOBJECT_RELEASE is enabled, kobject_put() delays
memory cleanup. Because kobject_del() wasn't called to unlink it from
sysfs, the lingering kobject can cause a name collision on any subsequent
attempt to write to nr_schemes, preventing further scheme creation until
the delayed release occurs.

Should we add kobject_del(&scheme->kobj) in that error path as well?

>  			kobject_put(&probe->kobj);
>  			damon_sysfs_probes_rm_dirs(probes);
>  			return err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617144807.9144=
1-1-sj@kernel.org?part=3D10
