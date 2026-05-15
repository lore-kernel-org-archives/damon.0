Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC32F8E9D
	for <damon@lists.linux.dev>; Fri, 15 May 2026 01:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808266; cv=none; b=ZhVPuzCOOaixxF20kJZC/s6W7jCPtuwjPqTTUphPwzsvACaACa79I818NqvXZnrfvmc5KSJFnTqLJEmHOoBQeVoVQldH1YA6YLWthNiIIXs5qkw8Yf0JZU9Q3NLcREKXtu70hbwySB8DCxYjv2y5VW9MFXOmC18UZqI+MnOCJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808266; c=relaxed/simple;
	bh=TNPRWROEyc9XACoepv+KigYQvuXjXAv3JTFM0RGK0f0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4ZmUiduhO2wPGmX1ie8sSbOQcipNc4LrjDLzhfnr635u0IgMFOMIykfh4ke4MR/e/Uzkr8s5zhxi4v3kaPQADooZ0ZAZbuZFJnR92dPcsHSaGsuA4NuxFqrNEByfPN6IG0Ut/Unhx1pUXM9nti9M7QJululHs+AMmJUkcFBaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLhigNTF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLhigNTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BCBC2BCB3;
	Fri, 15 May 2026 01:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808265;
	bh=TNPRWROEyc9XACoepv+KigYQvuXjXAv3JTFM0RGK0f0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LLhigNTFPM3+SVYJEkcc/1eZGIf1/11I0EbLA+y3x2nYjyChquexhQIBjRfBvn8aY
	 dbW46Q6pVK9lsFGYW4jX9DVFC0qb0cPLQSrvXako5rDMbg4OFuMIXoA/e/CxMv6LJJ
	 88zRDCjONdBqI2U19/zcHCQ6x6eXKJEzQKzcOT86tLiIglMEcG4hXk1vxHu5qppUlu
	 wQvXRnGv4QpVaOj18rI4K/kuCOA4nFih1YagW0o+C8YhleXx+e546HoAE0hjtwnCLT
	 ZuLYCcfdLCoGRvkUaMKlaN0J9HKK+6QlVDvW7gVmcDPxskuJpBp+J41+f5m2PMKR9m
	 cZw60VFX+ROZg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 25/28] mm/damon/sysfs-schemes: move
 memcg_path_to_id() to sysfs-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260515004433.128933-26-sj@kernel.org>
References: <20260515004433.128933-26-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:24:19 +0000
Message-Id: <20260515012425.78BCBC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Undocumented bug fix / behavioral change in a refactoring commit.
--

commit e622beadadffa95a924ccd6dd1b387669e2ef39c
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: move memcg_path_to_id() to sysfs-common

This commit moves memcg_path_to_id() from sysfs-schemes.c to sysfs-common.c
and makes it non-static so it can be reused by subsequent commits.

> diff --git a/mm/damon/sysfs-common.c b/mm/damon/sysfs-common.c
> index 83e24a9b5a0db..bdc6ae2639e4f 100644
> --- a/mm/damon/sysfs-common.c
> +++ b/mm/damon/sysfs-common.c
[ ... ]
> @@ -104,3 +104,44 @@ const struct kobj_type damon_sysfs_ul_range_ktype =
=3D {
[ ... ]
> +int damon_sysfs_memcg_path_to_id(char *memcg_path, u64 *id)
> +{
[ ... ]
> +	for (memcg =3D mem_cgroup_iter(NULL, NULL, NULL); memcg;
> +			memcg =3D mem_cgroup_iter(NULL, memcg, NULL)) {
> +		/* skip offlined memcg */
> +		if (!mem_cgroup_online(memcg))
> +			continue;
> +		if (damon_sysfs_memcg_path_eq(memcg, path, memcg_path)) {
> +			*id =3D mem_cgroup_id(memcg);
> +			found =3D true;
> +			mem_cgroup_iter_break(NULL, memcg);
> +			break;
> +		}
> +	}

This isn't a bug in the new code, but the commit message describes this as a
pure refactoring change to move the function. However, the newly moved
version adds a call to mem_cgroup_iter_break() before breaking out of the
loop, which was missing in the original sysfs-schemes.c implementation.

While this correctly fixes a pre-existing memcg reference leak, should this
fix be separated into its own commit? Bundling the functional bug fix with
the refactoring might cause it to miss backports to stable kernels, since
there is no Fixes: tag or mention of the fix in the commit message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515004433.1289=
33-1-sj@kernel.org?part=3D25
