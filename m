Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1184908DF
	for <damon@lists.linux.dev>; Sun, 26 Jul 2026 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785088422; cv=none; b=RIwg8xyHbiT8y4PZYJ1WTJ1VT/RhVGrn0Wl6hgTn1hfab2WHuuWXSEWlM8BxisK9MgN3Vb89OAwHhzwOYzuSmyZfcKD2ZI6nzmdNAFunXUyfm1KEheRLl0dACK5rwqp3ItNiN1BBWU7GrE7YjAMF56fRn15l7Zif7VmmcCccI0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785088422; c=relaxed/simple;
	bh=L7vnIkfZaHOXNkhTpKTaaYcY7cRmfB+X+FJOkejjMYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YyCIg1RyCPRbJeZIvmkQ5nx/8k3I6/NSJvUKieI5iiU/19aAYp0UNyMQhdwmTfhghfZYh0Fg7FsNwG+uZeOuXr8yTsAQ1fDM9Surl/CEfprtxS/sLpE34TNoQC+EnFR3A26Ft+QQjobQ5kUn5Bgs619nCYPb+i76qjeiZdUcUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1JRb/Oz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1JRb/Oz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7501F000E9;
	Sun, 26 Jul 2026 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785088414;
	bh=DuXOs2Y/K0JgZc5zUUfpE2SD7BYRVRcu+IigC42tNAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b1JRb/OzoXqmliM/5I8KbYd44BLaOAcKSdHB1H7l0LBaw8QU0VCWwFdDKrVh4HQpl
	 zmYNoVBUb+Qf4+xMeaMMcbC+udaKkfsXLG91jsbDL1H9C84lzwxOSSTw/yd9NByZse
	 whTcchqIvh546ncn3+BDrjbjHqJAa6KfvVw9dVBRaJsUT67H9l6Y906JmAMStxBWOp
	 tA3GOprxztOC9JXzCQ6iJg+Qlcqj3H5jNvRrubizIO4T/edvufBO88xhRNUuBeiiHj
	 wB7lPuF1HZ7lnyySJuF3iKMH1Sqkoa+0zBUft/KtlX9S5fEoEGdDWjEjlqlU73zbDr
	 xFx+aVxs6m75w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260726173935.94046-3-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
 <20260726173935.94046-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:53:33 +0000
Message-Id: <20260726175334.0E7501F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly introduced DAMON_FILTER_TYPE_PGIDLE_UNSET probe filter=
 type is completely inaccessible from userspace because it was omitted from=
 the sysfs string mappings.
--

--- Patch [2]: [RFC PATCH v2 02/17] mm/damon/paddr: support PGIDLE_UNSET pr=
obe filter type ---
commit 28cc087ac53ca1eb5ea0ff45e8fd4a6108a12c9f
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support PGIDLE_UNSET probe filter type

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

[Severity: Medium]
Will this new filter type be inaccessible from userspace?

The DAMON_FILTER_TYPE_PGIDLE_UNSET filter type appears to be missing from t=
he
damon_sysfs_filter_type_names array in mm/damon/sysfs.c:

static const struct damon_sysfs_filter_type_name
damon_sysfs_filter_type_names[] =3D {
	{
		.type =3D DAMON_FILTER_TYPE_ANON,
		.name =3D "anon",
	},
	{
		.type =3D DAMON_FILTER_TYPE_MEMCG,
		.name =3D "memcg",
	},
};

Without adding it here (for example, as "pgidle_unset"), won't userspace
attempts to configure this filter via sysfs be rejected with -EINVAL,
effectively making it unusable?

> +		if (!folio)
> +			matched =3D false;
> +		else
> +			matched =3D damon_folio_young(folio);
> +		break;
>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726173935.9404=
6-1-sj@kernel.org?part=3D2
