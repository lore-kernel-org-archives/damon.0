Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA092874FB
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785212627; cv=none; b=txJk1jKHyMzPWTN6WNX+AE6p+zg1zO5uFasGukm1BbeRzBwinChbaWVZX+omUP5SyvApoUWu196pHSgM3Cyl1bw6dLX0a+1m/6zreXC5mRBvlbnPhhdLnggrIOOPR7Q+yeSg4I1AjJWnRCItaRIgJUXEBeR8Ks1W+N/odgrUYyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785212627; c=relaxed/simple;
	bh=mmKsHyKlHltj7DPivDBG7A9m9c4oewunZsfx1mEzmGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nwCIRm1S7pq6SH8BVy3Oacu4bgrHzpsmbHKm9jOk5WpuaOZXqu6+Gyrw334ExphEQwWBbd8krm8mNbF4fruZ5SMbRj8RZ3KjqNtdGGxNJLWg+EXHBfxn+p4lbWBN7Y7DPxDXPh9oOSOPnhK0qF+VWXEyS67MPbVYlMOIwwjXy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW6rWAWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW6rWAWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3661F000E9;
	Tue, 28 Jul 2026 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785212626;
	bh=DStnWAOz5hblFCKmEOu19ER06qj0LoGlYb2WNx509LA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VW6rWAWvYAaboT+l085IJwRSk+fz/mLFSyTn6NLrv8CTxsa25DBUhnkDuDgYMCVm5
	 bjkCs0YkKj2bPOoGHmH6D8K0FG/Z0w4CzmESYTcMZU9l9ihaw5myIz2pb3Wujjq18d
	 Xfuhtkk86t8YpPWViyw8bLXH3fdsGbQXzmKekMjCkiTMOxvynDVo94rkaoxSLoEYx/
	 MLgEW4IR5Sv9bmGmabsJnPWaAzAvfP76VVJLgnnECVl1J34pz15aeElcOLW6CdOmJG
	 uOVR+Kb2iAId3Nq0+hIrTJuvJojYQC0vXwGtpZqDyHgpDDh7hBCFbvn+55W49ywtDZ
	 tJLWXIXeZfsaQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 12/17] mm/damon/sysfs: implement prep_action
 file
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728041242.187380-13-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
 <20260728041242.187380-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:23:45 +0000
Message-Id: <20260728042346.5E3661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `prep_action` configuration is completely ignored and never =
applied to the DAMON core.
--

--- Patch [12]: [RFC PATCH v2.2 12/17] mm/damon/sysfs: implement prep_actio=
n file ---
commit 5572380654e6a74889b64fc57510a982daf24d8e
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs: implement prep_action file

Add a file named prep_action under the prep directory.  It represents
the corresponding probe preparation action.

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index afd39659d6b84..c0130843223d7 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -756,6 +756,7 @@ static const struct kobj_type damon_sysfs_intervals_k=
type =3D {
> =20
>  struct damon_sysfs_prep {
>  	struct kobject kobj;
> +	enum damon_prep_action action;
>  };
> =20
>  static struct damon_sysfs_prep *damon_sysfs_prep_alloc(void)

[ ... ]

> +static ssize_t prep_action_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_prep *prep =3D container_of(kobj,
> +			struct damon_sysfs_prep, kobj);
> +	ssize_t ret =3D -EINVAL;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(damon_sysfs_prep_action_names); i++) {
> +		const struct damon_sysfs_prep_action_name *action_name;
> +
> +		action_name =3D &damon_sysfs_prep_action_names[i];
> +		if (sysfs_streq(buf, action_name->name)) {
> +			prep->action =3D action_name->action;

[Severity: Medium]
Are we missing the logic to apply this configuration to the DAMON core?

Looking at damon_sysfs_set_probe(), it commits sysfs configurations to a pr=
obe
by calling damon_sysfs_set_filters(), but it appears to skip the preps
directory entirely:

static int damon_sysfs_set_probe(struct damon_probe *probe,
		struct damon_sysfs_probe *sys_probe)
{
	struct damon_sysfs_filters *sys_filters;

	sys_filters =3D sys_probe->filters;
	if (!sys_filters)
		return 0;
	return damon_sysfs_set_filters(probe, sys_filters);
}

Does this mean the prep_action configuration is never applied when a user
commits the context?

> +			ret =3D count;
> +			break;
> +		}
> +	}
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728041242.1873=
80-1-sj@kernel.org?part=3D12
