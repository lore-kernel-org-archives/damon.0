Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBC1DE8BE
	for <damon@lists.linux.dev>; Sat, 16 May 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958966; cv=none; b=CeFxjEgU+JG9KdP9JSSbLJxUWMgTT/cVyt83hiBUi6GKJdYW0HDwTvogzMfqIQ698gSi/4dziaUvziK57D25++Wk8+gNKlgObNKtv6e1KsfDrKwSlt1kLL0iHaM4/2qbL8KGoWm3Z++kYLi6mBuSTZ03uSTL/5NMNPPqNTOTS3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958966; c=relaxed/simple;
	bh=/EKSvmRQkbuoCZCfM7H7Htvssqliy7CD0u1b1+30E6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kFO0TwkHIK+v35zGFlzqvGW2aTxdS5WgCHKAkGuGSyE5rOYtWrdVj0Ks6MM3JS/U6aV5NrKcid8p7YqX0Bi4BUufi97gCJgZJkgZKVgHxZDEb2OyCjmfuP7hToQ6Xl+IiTnvmA911VWv8LDjVvCyPAieMOssHKGmlPABHS0EGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf4FX7TX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf4FX7TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FEAC19425;
	Sat, 16 May 2026 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778958965;
	bh=/EKSvmRQkbuoCZCfM7H7Htvssqliy7CD0u1b1+30E6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Hf4FX7TX32U0bInUkGLB9Jj4nbRZiInAF99HyJHM+Zww1ZwOmb4pgYoSNvxEZ3hcx
	 DzEnzWHXPjIpoPzhj09tDHiqUtRPNaE4xun2DsGX98XSwFmXsAAizgk4Nyg3lhIc9Z
	 WDtTQ9MmT6YzEfoBrrLDWH2MQcarHYC1Ht12Lu0p5ZWX5fmoJYHLh+GqMV5Fm8KEvK
	 4EJQt8tRlIPchSFIRgI1MiZviYqn0hn1L1QUIE9pllsoRj2FHU3Hiet9gR5YIdsgR4
	 tTEqZqWc5q66Eh1MVfe2CXy4NhjTUCe6uAl1TNX3EMH/THlOxoQs6NFXk7PG1/d5/o
	 jtWkdHc2BPU+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 25/28] mm/damon/sysfs-schemes: move
 memcg_path_to_id() to sysfs-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260516183712.81393-26-sj@kernel.org>
References: <20260516183712.81393-26-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 19:16:05 +0000
Message-Id: <20260516191605.83FEAC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit silently fixes a memcg reference leak by adding a cal=
l to `mem_cgroup_iter_break()` without documenting it in the commit message.
--

commit 1ef74f20c7bcc208023c4d45c1ced02bf234a75c
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common

This commit moves the static function damon_sysfs_memcg_path_to_id()
from sysfs-schemes.c to sysfs-common.c and makes it non-static so it can
be reused in subsequent commits.

> The next commit will need to find the memcg id from the user-passed path
> to the memory cgroup, from sysfs.c.  memcg_path_to_id() is doing that,
> but defined in sysfs-schemes.c as a static function.  Move the function
> to sysfs-common.c and mark it as non-static, so that the next commit can
> reuse the function.

The commit message states that the patch only moves the function and changes
its linkage. However, a functional change was included in the moved code.

[ ... ]
> diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
> index 83e24a9b5a0db..bdc6ae2639e4f 100644
> --- a/mm/damon/sysfs-common.c
> +++ b/mm/damon/sysfs-common.c
[ ... ]
> @@ -104,3 +104,44 @@ const struct kobj_type damon_sysfs_ul_range_ktype =
=3D {
>  	.default_groups =3D damon_sysfs_ul_range_groups,
>  };
> =20
> +
> +static bool damon_sysfs_memcg_path_eq(struct mem_cgroup *memcg,
> +		char *memcg_path_buf, char *path)
> +{
> +#ifdef CONFIG_MEMCG
> +	cgroup_path(memcg->css.cgroup, memcg_path_buf, PATH_MAX);
> +	if (sysfs_streq(memcg_path_buf, path))
> +		return true;
> +#endif /* CONFIG_MEMCG */
> +	return false;
> +}
> +
> +int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
> +{
> +	struct mem_cgroup *memcg;
> +	char *path;
> +	bool found =3D false;
> +
> +	if (!memcg_path)
> +		return -EINVAL;
> +
> +	path =3D kmalloc_array(PATH_MAX, sizeof(*path), GFP_KERNEL);
> +	if (!path)
> +		return -ENOMEM;
> +
> +	for (memcg =3D mem_cgroup_iter(NULL, NULL, NULL); memcg;
> +			memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) {
> +		/* skip offlined memcg */
> +		if (!mem_cgroup_online(memcg))
> +			continue;
> +		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> +			*id =3D mem_cgroup_id(memcg);
> +			found =3D true;
> +			mem_cgroup_iter_break(NULL, memcg);

Is it intentional to include this memcg reference leak fix here?

It looks like the original code was missing this call to
mem_cgroup_iter_break() before breaking out of the loop.

Should this bug fix be split into a separate patch, or documented in the
commit message so that stable maintainers can backport it if necessary?

> +			break;
> +		}
> +	}
> +
> +	kfree(path);
> +	return found ? 0 : -EINVAL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516183712.8139=
3-1-sj@kernel.org?part=3D25
