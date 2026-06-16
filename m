Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17E43E48C
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623651; cv=none; b=hSZEnGJwhXwBCQ8g0EbkpHakzlgjsAj5gEUVVJVXLZ/m98ZGo3rN0MN0gfrnJufJV5Ro3r9GUKzvEqMRSlKraFYOyb0JhsNsj/l0aPS/R48L0uH6FCilyeAMfN8Fcah2kQcbJ5me4NUA9NkHsqqlVH2BfE9gdpc4X2c/HaW42vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623651; c=relaxed/simple;
	bh=BRz+C2WeOPKMXSsp14M4gJdHYmrFoIx1hDf9rntBPTU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kUvIgupn1eNG5TtPuo5Q7NlXUbxlXYqGmXb7caMdDmZT041v6msAtZ8FKQbqRtkFMd5C8rVm4izOCJ7U7POc4Z3sF9HVsTnPMHHeoWxuD2f7eK8IFSg5eflAQ+JgIpVQcvrTA3DNGwh/pvLS5UI3rkli/f1WmUgeFcYYSeCfO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVn9YcMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVn9YcMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369181F00A3D;
	Tue, 16 Jun 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623649;
	bh=643t2AlYxhFMPiKfr/8/YJ1yVtbTxuKQ+OQVAwAMLzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVn9YcMhChKrx+h1YELmmPQgpyMSvWPaOhkkRvZzKfLe3OvHGQu2ifKgT+E74a5AG
	 A0kxM1LMorI31ZSG5gK3nK1NZqzbH9hRk/KudG4kyVcD429iEGQqSgNYDqhNnB/m6u
	 afZBE5X9OEqSmKi6GmoBVT0o2yVXBAdXSzWuYnD2kb/6IGZ9puW1/nxHNdUq0B62RJ
	 G88zSKdl4oeqqK99xnuxbE3jw1dOG3e5ZbAxlaE0ROXH9Yq0hgiFK28dywL0MyeeMT
	 QYzcixamITz72DEApK4NLCW/gAJZ/BUc4Kftguo94wadb1JCtJy4qGLWKTuK2+x06m
	 msbJrfxY2qFBA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/9] mm/damon/sysfs-schemes: kobject_del() scheme
 quota goal dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-7-sj@kernel.org>
References: <20260616150844.88305-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:27:28 +0000
Message-Id: <20260616152729.369181F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing Kobject Deletion on Error Path
--

commit b01a934762aa810a11a4a01efdd70c41f7274410
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs

This commit adds missing kobject_del() calls to the cleanup of scheme quota
goal directories. This prevents directory creation failures due to name
conflicts when CONFIG_DEBUG_KOBJECT_RELEASE is enabled.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 300930c2c5b3f..737638be84f15 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1465,8 +1465,10 @@ static void damos_sysfs_quota_goals_rm_dirs(
>  	struct damos_sysfs_quota_goal **goals_arr =3D goals->goals_arr;
>  	int i;
> =20
> -	for (i =3D 0; i < goals->nr; i++)
> +	for (i =3D 0; i < goals->nr; i++) {
> +		kobject_del(&goals_arr[i]->kobj);
>  		kobject_put(&goals_arr[i]->kobj);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing missing
kobject_del() calls here to prevent name collisions, do the error paths in =
the
various *_add_dirs() functions need similar fixes?

If an error occurs after a successful kobject_init_and_add(), the error pat=
hs
currently call kobject_put() without kobject_del(). This can leave the sysfs
directory present until the object's reference count drops to zero and the
delayed release runs, potentially causing a -EEXIST failure if a user retri=
es
the operation.

For example, looking at damon_sysfs_targets_add_dirs() in mm/damon/sysfs.c:

    err =3D damon_sysfs_target_add_dirs(target);
    if (err)
        goto out;
    ...
out:
    damon_sysfs_targets_rm_dirs(targets);
    kobject_put(&target->kobj);
    return err;

Could this leak the sysfs directory for target->kobj?=20

The identical pattern appears in several other error paths:
- damon_sysfs_contexts_add_dirs() in mm/damon/sysfs.c
- damon_sysfs_kdamonds_add_dirs() in mm/damon/sysfs.c
- damon_sysfs_schemes_add_dirs() in mm/damon/sysfs-schemes.c
- damos_sysfs_populate_region_dir() in mm/damon/sysfs-schemes.c

>  	goals->nr =3D 0;
>  	kfree(goals_arr);
>  	goals->goals_arr =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D6
