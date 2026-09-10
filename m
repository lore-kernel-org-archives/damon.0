Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D341A4E4
	for <damon@lists.linux.dev>; Thu, 10 Sep 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050616; cv=none; b=gpSyGj33en1WtUNCVdflz+JH9XFg8jpr+d8xT7KtG3RiC7TNN37c/xJaoOWR2Mfse8vFqmLZtDMgoLLOKmy/zU8QiuPbyM/wXEy8HAtdEOAWNa7sHGz2Z3AcVHlxyftlchgvhtN8gyrdpBrPZ4MTth/B1ADEp5wRMj//42EeS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050616; c=relaxed/simple;
	bh=EOoDDWSFdEMSHq90FM0/QGNB2anB1MxXNxQMjFlSYyY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/+io9llaFR+gGpdaH4TeYjj0zLBBkJpzbUzv+/+uf+vCgADPMrLngnKGvnZSvb4Gj0cx6ZP8+mQPRGEu944RQBwY3E/VzrJ5KtqK5Sx7khI8gHNqFu6PEC5WXgEPNySDZHBMogv+JAx3GyC0GpVEL/X8Wy7+tIoXgkLVOGalc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9iMJlK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9iMJlK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114E01F000FF;
	Thu, 10 Sep 2026 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050614;
	bh=bTaPuU9Hw1oeAKkBNhFvOFax/y8w5h6LVA9dfwvVS04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U9iMJlK3sMyHXRnxedjDa/RM+B8JZVV/c2+L7Tqw+YfMisYY1580GkgRq+ZH96gpg
	 woEUlgFUAodlth0+B6xSk2vr9PtZZctk4oTkMNlxE8fdE7GQpfExR9uLEYfi2MWdAw
	 cUuiCvLDQZGkF5yhYEGw303B0vkC2u0nmOyJzj8mDnvIggiLBim+LxizNscl40kAJ/
	 rDL9Zrfvq2LnHqjBH8ZKtqa6xEtwnqotwsbwtP6awEawwKbZR1JUvXBSUx3BVgGcow
	 VtssLF32zQ9nhO7rkGPUABRD0FvFWn/sKO3Egsz5v/VB9TWjM+aA2IRJZTLzEXO5iI
	 qjBcsVaiwCpaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] mm/damon/sysfs-schemes: support probe_hits_wsum
 damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260910141849.170896-6-sj@kernel.org>
References: <20260910141849.170896-1-sj@kernel.org>
 <20260910141849.170896-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:30:13 +0000
Message-Id: <20260910143014.114E01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Time-of-Check to Time-of-Use race when validating probe_hits_wsu=
m range allows invalid filter configurations to bypass validation.
--

commit 27bc99697c36a87c8e4b72fe6006955a564a4bb2
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: support probe_hits_wsum damos core filter

Extend DAMON sysfs interface to support probe_hits_wsum input. Also
update sysfs input based scheme build logic to setup the min/max probe
hits weighted sum range as user provided.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 4d9147d2a269e..d9dd4ee0442c7 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c

[ ... ]

> @@ -2844,6 +2847,14 @@ static int damon_sysfs_add_scheme_filters(struct d=
amos *scheme,
>  			}
>  			filter->sz_range.min =3D sysfs_filter->range_min;
>  			filter->sz_range.max =3D sysfs_filter->range_max;
> +		} else if (filter->type =3D=3D DAMOS_FILTER_TYPE_PROBE_HITS_WSUM) {
> +			if (sysfs_filter->range_min >
> +					sysfs_filter->range_max) {
> +				damos_destroy_filter(filter);
> +				return -EINVAL;
> +			}
> +			filter->range_min =3D sysfs_filter->range_min;
> +			filter->range_max =3D sysfs_filter->range_max;

[Severity: Medium]
Are these repeated reads of sysfs_filter->range_min and sysfs_filter->range=
_max
susceptible to a time-of-check to time-of-use race?

If a privileged user concurrently writes to a filter's min or max sysfs
attribute between the validation check and the assignments:

    if (sysfs_filter->range_min > sysfs_filter->range_max) {
        // Validation passes
    }

    // Concurrent sysfs write updates range_min here

    filter->range_min =3D sysfs_filter->range_min; // Now invalid

Could this allow an invalid configuration to bypass the check and be added =
to
the DAMON scheme? Would it be safer to read the values into local variables
first, validate those local variables, and then assign them to the filter?

>  		}
> =20
>  		damos_add_filter(scheme, filter);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910141849.1708=
96-1-sj@kernel.org?part=3D5
