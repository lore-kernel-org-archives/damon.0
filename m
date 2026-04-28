Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA562DAFBB
	for <damon@lists.linux.dev>; Tue, 28 Apr 2026 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341277; cv=none; b=Ci2T6uQUryy/vycGjMtJMD22ewp/Z7K3bL5JrMOLWP7hW++FXKajOEM8HQwD2xr/Z7Xxhlpdj4wUWEcl/uju9g7NFE6+Qe/MUDeSo5nOIt0imMCsN4tXxGX7R3cIlPCJKvJtwE7ySGeKJb7VqPBLOAGiAweP29GBpu3OLiMdCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341277; c=relaxed/simple;
	bh=gv5BAZE7mPy8V0OCQnX9KKc1BvFM7meEz1MP7BMYFFM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPH75r7k667gpMspJnVxaP1alStr8xch8xN9PLFFUzRg4S9MOJqPOO5MOj1/IjWXRxnp+xBQ8ZdlYniY5rKcVLuL/vqf7dPpmE9bJ3QJoGwhwMhB0cyE0uWrugqevPTnmPjMD96SJTOt12sqIMYKHraFgKghIhnoMUpa1w9ELtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4Hfu+WZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4Hfu+WZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D935C19425;
	Tue, 28 Apr 2026 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341276;
	bh=gv5BAZE7mPy8V0OCQnX9KKc1BvFM7meEz1MP7BMYFFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=E4Hfu+WZfj0t8FkQWbvSr9O1iaJpLtcUVWxtUW52twoas007SrPPk81oE1DU6I6RR
	 YmMl+plfCd+5dY3AWnLq21jfHM09luKdaxsiXlfkwaWN4PGomXupsjb/Cb5OWBEtPa
	 0Aa/AeukII+5F2VpyOuA8nzuldrMLczNVBsg9lkc2zp2ZNcRShP8eLVNDqGnrtB4BW
	 JhMHDoz1YZr1um7cGbR0d08c6Q1O+sgKHT3lw190FyyDMAt5eyxfuWisONoRXZ5zbw
	 sV6WFRp2CMEF4t2eM9ZWEiMVFHX7X2TU1I7tRUO1+AZtgzmz0+L2uNRFiJSwIajhuo
	 ocbOKujkkZV/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] mm/damon/sysfs-schemes: implement
 fail_charge_{num,denom} files
Reply-To: sashiko@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260428013402.115171-5-sj@kernel.org>
References: <20260428013402.115171-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 01:54:35 +0000
Message-Id: <20260428015436.8D935C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Sashiko AI review found 1 potential issue(s):
- [Medium] The sysfs store functions for `fail_charge_num` and `fail_charge=
_denom` do not validate or bound the ratio, leading to potential integer ov=
erflow in the core quota tracking logic.
--

commit 43a135a4abb7954bcb255ae58b1aa323b2447477
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs-schemes: implement fail_charge_{num,denom} files

This commit implements the user-space ABI for the DAMOS action failed region
quota-charge ratio setup. It adds sysfs files for fail_charge_num and
fail_charge_denom to allow reading and setting the numerator and
denominator of the failed regions charge ratio.

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 04746cbb3327..dee1f5788bea 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> +static ssize_t fail_charge_num_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_quotas *quotas =3D container_of(kobj,
> +			struct damon_sysfs_quotas, kobj);
> +	int err =3D kstrtouint(buf, 0, &quotas->fail_charge_num);
> +
> +	if (err)
> +		return -EINVAL;
> +	return count;
> +}

Can this unbounded input lead to an integer overflow in the core quota
tracking logic?

The values read via kstrtouint() are unconstrained up to UINT_MAX. Later, in
damos_charge_quota(), these values are passed to:

mult_frac(sz_region - sz_applied, quota->fail_charge_num,
          quota->fail_charge_denom)

If the region size in bytes is large (for example, a single DAMON region of
10 GB) and the numerator is set near UINT_MAX, their product could exceed
ULONG_MAX. For instance, 10GB * UINT_MAX is roughly 40 * 10^18, which is
larger than ULONG_MAX's 18.4 * 10^18.

Could this cause an overflow that wraps around to an anomalously small valu=
e,
effectively bypassing the administrator's configured quota limits?

> +
> +static ssize_t fail_charge_denom_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	struct damon_sysfs_quotas *quotas =3D container_of(kobj,
> +			struct damon_sysfs_quotas, kobj);
> +
> +	return sysfs_emit(buf, "%u\n", quotas->fail_charge_denom);
> +}
> +
> +static ssize_t fail_charge_denom_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct damon_sysfs_quotas *quotas =3D container_of(kobj,
> +			struct damon_sysfs_quotas, kobj);
> +	int err =3D kstrtouint(buf, 0, &quotas->fail_charge_denom);
> +
> +	if (err)
> +		return -EINVAL;
> +	return count;
> +}

Does the fail_charge_denom input also require bounding to prevent the same
overflow issues when passed into the quota tracking logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428013402.1151=
71-1-sj@kernel.org?part=3D4
