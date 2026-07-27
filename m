Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F53FF1AE
	for <damon@lists.linux.dev>; Mon, 27 Jul 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163965; cv=none; b=H5jqeI+CsHVsVRRuaz9txnGR7IGvlKF3braThgYxjhBihQsi+RsP7Jzs9ci1+LMMg9OtQtJibpkdhkzDFp0x3sP0hgHkPwB/FnaUm5VajE3sOK0mLTTRfeLteCkP27HJmwA3nTAQgNOnnnAsatSoXCIlMdeYZ994U3/SxFvVRbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163965; c=relaxed/simple;
	bh=ZskL7r90/D5XHS3DyEAYjVGWlzGTJWr2QRI4JIrqx48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=apOfq2+NTWorElON9Mw+//BtdsvWrHAuqgjL9Bp+U27IHGuTtKhlulFivCzxhvcDFBIsak4yCe6Kdphg7SQ/AdD8k/lvwa6mMQD4GveXgyo+yhFhHgS+3YJrXmeP4ou6mfF2L6xRXkeQmc+Qhr0zCm6ZN5Iju/r3MBmKWOh1o1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYngbL7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYngbL7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD2C1F000E9;
	Mon, 27 Jul 2026 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163963;
	bh=PHCno8Hxovf1rJzt0I/DDZMCdqtHMZtPAcuEIw68Pck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WYngbL7YWMGmlD/RnAqJk3P9sgOXVGRBfOFKxLRna0az9QpdMnXnyF4z1nAyh1csE
	 xS3KNQgPWWqNcK2an0I2kiyunVREwM6ZOaBErhjGD/JKpw60sPy3mjrW3Gwt4gvdUA
	 0pnrRZfK83c9tDnflj38pfajMlS7L+ZQDM+OrJc+F7yNJ0X4kaTMFhkDx04tp7g3bk
	 zO4UGZBK4salEr2+wh0FreTezHiswVNIvXVIrgffdmYqnvshA4I5RiuDpnq/ttBm5V
	 /zPI6F5l0wCBR2AiS8iFsy3JR2QXOsjqVQ7byix22+vs1GpYuOWfKOGf3dzJWRK99H
	 7KZ3jklUJ+c0Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.1 02/17] mm/damon/paddr: support PGIDLE_UNSET
 probe filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260727143829.86236-3-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
 <20260727143829.86236-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:52:42 +0000
Message-Id: <20260727145243.4BD2C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added DAMON probe filter type DAMON_FILTER_TYPE_PGIDLE=
_UNSET is not exposed in the sysfs interface.
--

--- Patch [2]: [RFC PATCH v2.1 02/17] mm/damon/paddr: support PGIDLE_UNSET =
probe filter type ---
commit 67629d6971ecadd1e1c345f911e353e76f34b34f
Author: SJ Park <sj@kernel.org>

mm/damon/paddr: support PGIDLE_UNSET probe filter type

This commit implements support for the DAMON_FILTER_TYPE_PGIDLE_UNSET probe
filter type in the physical address space DAMON operations set.

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
> +		if (!folio)
> +			matched =3D false;
> +		else
> +			matched =3D damon_folio_young(folio);
> +		break;

[Severity: Medium]
Should this new filter type also be exposed in the sysfs interface?

Looking at damon_sysfs_filter_type_names in mm/damon/sysfs.c, it maps sysfs
string inputs to DAMON probe filter types, but it doesn't seem to include
an entry for DAMON_FILTER_TYPE_PGIDLE_UNSET:

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

Without this mapping, does this prevent userspace from accessing the newly
added feature, since any attempt to configure it through sysfs would be
rejected?

>  	default:
>  		break;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727143829.8623=
6-1-sj@kernel.org?part=3D2
