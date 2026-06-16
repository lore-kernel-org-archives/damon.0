Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC14418DF
	for <damon@lists.linux.dev>; Tue, 16 Jun 2026 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623555; cv=none; b=FvQ8AzYM7NnoMsA3MB95byK8+IDEuAO44FYgmKUPOJAVCRSuDfa/zp8FX1ZkYLDF4qHjUoQoawFO0WsgdFMzePGlktpnsyIVyIO2dWa8NLlGI16xc+vm6YajHLC3mw4Mv3VfU/tecKpvH61wOJl1enfkVyT3qLoGfGKQkAuBOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623555; c=relaxed/simple;
	bh=qva4pTL4LZq9a7ReG18dZGabCax8WLpUfmHFw4DeOrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UIrZ8dQw6pA5+0AZ7tRNJ6nbiNe5Q6qv0JK4nqxjUDzd4G+cB3/EbTxiSjLv0Tp+YJGiwdfwxRIzuRRMznhIemMltjfwtgAcgSq6mY2xvi0Rhai96V1vfzupH0BSKdVaxmYAAIGH7ciKb9dpO442Qw/GWCSvS0JWcG9im+Qo1Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B78LDo+E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B78LDo+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97A01F000E9;
	Tue, 16 Jun 2026 15:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781623554;
	bh=eJvppLPhCZq9hhCtcsWxprxEHwFh/no53pHEomtsI3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B78LDo+EasZCAqYem93+vuMSX7Noqe9I9kQhJeLIIt5fyEf0srzXZO5oDWBn+meEE
	 YGiONqOAt8Fq7KjLjaQKNMALNxpibQDEj2MslcFvhfj9ZUIXSvTXIyyUAXRVny93op
	 yTpve/xohX4TObeu06JfEvCz9scBi5xWlJ0WphN1Qp52G5q/U5i62ILE9PbBxYR1JH
	 VmN9gPbyGt73cjciVpYD8JRgIdPpAn81xQ8VqCw3OYRhVMTrSVaH+F6cUDSUe1oA+i
	 TSAUkaZbc0nCPHaiEC9+peHAJppRJHgVRW1tZcjRjPypsokSwrmXvb/QyFI49H9DEk
	 CR4lS3OkGlkww==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/9] mm/damon/sysfs: kobject_del() target, context
 and kdamond dirs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260616150844.88305-2-sj@kernel.org>
References: <20260616150844.88305-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 15:25:52 +0000
Message-Id: <20260616152553.C97A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix: Missing kobject_del() in sysfs directory creation =
error paths leads to persistent -EEXIST collisions.
--

commit 1c0329e17860c383f4ab90a119f917db75ecacee
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: kobject_del() target, context and kdamond dirs

On CONFIG_DEBUG_KOBJECT_RELEASE enabled kernel, lack of kobject_del()
could cause directories creation failures due to the name conflicts.
Fix those issues for target, context and kdamond directories by adding
kobject_del() calls.

Fixes: c951cd3b8901 ("mm/damon: implement a minimal stub for sysfs-based DA=
MON interface")
Cc: <stable@vger.kernel.org> # 5.18.x

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 2e95e3bac774d..d93f7919c3ca1 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -333,6 +333,7 @@ static void damon_sysfs_targets_rm_dirs(struct damon_=
sysfs_targets *targets)
> =20
>  	for (i =3D 0; i < targets->nr; i++) {
>  		damon_sysfs_target_rm_dirs(targets_arr[i]);
> +		kobject_del(&targets_arr[i]->kobj);

[Severity: High]
This isn't a regression introduced by this patch, but while you are fixing
the -EEXIST name collisions in the rm_dirs() paths, are the same
kobject_del() calls also needed in the error paths of the corresponding
add_dirs() functions?

For example, in damon_sysfs_targets_add_dirs():

    mm/damon/sysfs.c:damon_sysfs_targets_add_dirs() {
        ...
            err =3D kobject_init_and_add(&target->kobj, ...);
            if (err)
                goto out;

            err =3D damon_sysfs_target_add_dirs(target);
            if (err)
                goto out;
        ...
    out:
        damon_sysfs_targets_rm_dirs(targets);
        kobject_put(&target->kobj);
        return err;
    }

If damon_sysfs_target_add_dirs() fails, kobject_put() is called without
kobject_del(). Does this result in a lingering directory and a persistent
-EEXIST if the user retries?

Similarly, in mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir():

    mm/damon/sysfs-schemes.c:damos_sysfs_populate_region_dir() {
        ...
        if (kobject_init_and_add(&region->kobj,
                    &damon_sysfs_scheme_region_ktype,
                    &sysfs_regions->kobj, "%d",
                    sysfs_regions->nr_regions))
            goto out;
        if (damos_sysfs_region_add_dirs(region, ctx, r))
            goto out;
        ...
        sysfs_regions->nr_regions++;
        return;

    out:
        kobject_put(&region->kobj);
    }

If this fails, it returns without incrementing sysfs_regions->nr_regions.
Could the next region processed in the loop then attempt to initialize with
the exact same name string, immediately hitting -EEXIST and breaking the
entire region population loop?

>  		kobject_put(&targets_arr[i]->kobj);
>  	}
>  	targets->nr =3D 0;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616150844.8830=
5-1-sj@kernel.org?part=3D1
