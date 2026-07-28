Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0D235972
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785213181; cv=none; b=Cy7ES/cbNUm1qnC/gY3Kk20b5Dk7m5Vc0U3jkDrn4tr0XAkBBicoNImbYI4YV75TNGqSHaNhyAOswjqKD4tVQ/lsHPfEEYiwd8UkO/zyvQUO7LbUUL8Cd1IEoDHDxP1gAI9xSG4SbSeoABNLb6070/OAJqwVTg269gYmKMGVN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785213181; c=relaxed/simple;
	bh=9jZZ4bpq0/puy9QxVjxRhljEpdYm6FyXOUo8+eVrQqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AzDEyZmVQ4WTovZW4xIvAN1+4DKFYy59KbaPeOPIwqiXFdD3S+ZuPPwUOxj+lOUIfSlty9xqXPk5kYheKT/hitupiF2FIAhoMWD8uLVlww0CPItJqWF1gOJTilTTl35AhrOfjeTvhPk5G10eZz4C7WFa7Ojk+C16Rs55B+g1LDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFTYH7bh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFTYH7bh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFA71F000E9;
	Tue, 28 Jul 2026 04:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785213179;
	bh=JeWLZ5lWYOYQs+0g2MRj59owHBm64sfYVWxeUAQxB28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VFTYH7bhHFhVGe190hzJMmOl3/Gb7Rz4rorNPBtjYct78pBK9znxLDkcJJCNh/E60
	 gb7zve+clVjAiYkodJDNEaCwSFHOLsv5vzWlFVNFawij2DOcIvuQ3Jjf5yxJNWG/W7
	 N99ZGX/bos0zhM+5J2BCnuXbL2ZLuUf8I2otwgc2NwiNSe6YJuwbdWeVgCq6lKnwrj
	 sawJDf9jKMFl91laCAz3NCut8y/2lLgzUor0c8bVoSluZBEGsXP+B8y6o3uAhKF1Yk
	 QpeL9zeh1pxCznM9oI80hktNinVur1eLZ4GLvYEqYY8p7CiWh3iYoS57P66/vAXATz
	 THnU81qw5XgxQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 02/17] mm/damon/paddr: support PGIDLE_UNSET
 probe filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728041242.187380-3-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
 <20260728041242.187380-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 04:32:59 +0000
Message-Id: <20260728043259.ACFA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] DAMON_FILTER_TYPE_PGIDLE_UNSET blindly matches almost all pages wh=
en probe weights are used, rendering the filter ineffective.
- [High] The newly added DAMON_FILTER_TYPE_PGIDLE_UNSET is not exposed in t=
he sysfs interface, making it impossible for users to configure.
--

--- Patch [2]: [RFC PATCH v2.2 02/17] mm/damon/paddr: support PGIDLE_UNSET =
probe filter type ---
commit 98c0d4f6b2dcc4c706f1af62a258dd827b89bc7e
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support PGIDLE_UNSET probe filter type
   =20
Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
address space DAMON operations set. It reuses damon_folio_young(),
which was being used for access monitoring.

> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5a6a78054784a..199de1463fa06 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filte=
r *filter,
>  			matched =3D filter->memcg_id =3D=3D mem_cgroup_id(memcg);
>  		rcu_read_unlock();
>  		break;
> +	case DAMON_FILTER_TYPE_PGIDLE_UNSET:

[Severity: High]
Is this new filter type missing from the sysfs interface mapping?

Looking at damon_sysfs_filter_type_names[] in mm/damon/sysfs.c, there is
no entry for DAMON_FILTER_TYPE_PGIDLE_UNSET:

mm/damon/sysfs.c:damon_sysfs_filter_type_names[] =3D {
        {
                .type =3D DAMON_FILTER_TYPE_ANON,
                .name =3D "anon",
        },
        {
                .type =3D DAMON_FILTER_TYPE_MEMCG,
                .name =3D "memcg",
        },
};

Without an entry here, will users attempting to configure this new filter v=
ia
sysfs receive -EINVAL, making the filter unconfigurable?

> +		if (!folio)
> +			matched =3D false;
> +		else
> +			matched =3D damon_folio_young(folio);

[Severity: High]
Will this blindly match almost all folios when probe weights are used?

In kdamond_fn(), if damon_has_probe_weights(ctx) is true, it skips
ctx->ops.prepare_access_checks():

mm/damon/core.c:kdamond_fn() {
        ...
        bool access_check_disabled =3D damon_has_probe_weights(ctx);
        ...
        if (!access_check_disabled && ctx->ops.prepare_access_checks)
                ctx->ops.prepare_access_checks(ctx);
        ...
}

For physical addresses, this skips damon_pa_mkold() which normally sets the
PG_idle flag on folios.

When the filter uses damon_folio_young() here to evaluate access,
damon_folio_young_one() checks !folio_test_idle(folio).

Since the idle flag was never set, will this evaluate to true for all
folios, causing the PGIDLE_UNSET filter to unconditionally match?

> +		break;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728041242.1873=
80-1-sj@kernel.org?part=3D2
