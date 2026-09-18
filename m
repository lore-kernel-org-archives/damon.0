Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486E4FC35B
	for <damon@lists.linux.dev>; Fri, 18 Sep 2026 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743938; cv=none; b=mDi0h18yaA4mPyY5i/pQOQGlhmgijedXrY8f39sOu7Gh9/eZ+xSZUgcgyKfz+QNAHadyWsKPJxxNbJVYkshkD4qzYqfC6chD9ivKA3jpFA4Wtul4FwJXbTNUKrFnDx3Y2LboZN5s9CS5c9kiFuWZ82v8Rak5aVMS3UB6LbS5evg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743938; c=relaxed/simple;
	bh=jLELUzmj1fIN+c/Q3Xo4VyLxqQMQQ9/B1hQ9FDgi3t0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GPUnnZJ4/JfuTS5gWmmr4JzPUZ50QqKxISqomNumB2xIB+PjNxIlwLzV5Wp9VzKdm+AtiYmURtuxZvCMbknUx+rL1nW89khffcibJ2E2tY4Kc9IQIwiBlf7AfiQnJAsD08HGRIWgxen3NZzF4HY/Wb+8rF9WOip49P32bAIXbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDn5qGFE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDn5qGFE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA851F000FF;
	Fri, 18 Sep 2026 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789743936;
	bh=fvKU7jCNfAqEhjxatXJ0VfR0NTipmE8Gf0CAYT4VcVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cDn5qGFE3EoYV3HMDSAbZK+wfwjKHDspMi4F7NNtuqobyE77TVXb8iCVUuCT63tsk
	 BFVMeVA7Rn4i6ZLSPP5/4WL94eE7A4Yp8Rkf5zortbYml8Y2UUzeYxCHQNXEZoKXVL
	 Mi4QNj+aD5/L3OloyZ0sCUIg4vxyruiV6gax00GLRT+jBjsSehkAvchX+djxRlY/7P
	 0EQMana4nvSB9CYuOjvI9q3j+qE/C/mNcxUNCup24xEfUi5eHX3lr6S6S3/GJ+iVFc
	 4aduLSy/xgTckbOwybF3CbvkgXfVypMG1Ptx295HY6+qbQeVNKzL6cYuC8cTOC+mpg
	 Y35dugnRXkaZQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/7] mm/damon/sysfs-schemes: support quota goal
 complement flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260918142827.85303-4-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
 <20260918142827.85303-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:05:35 +0000
Message-Id: <20260918150536.9AA851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mm: unsigned integer underflow in damos quota complement calculati=
on
--

commit 8f39260b8b618fca6e69e55388bee135a86971f3
Author: SJ Park <sj@kernel.org>

mm/damon/sysfs-schemes: support quota goal complement flag

This commit adds a new sysfs file to support setting and getting the
quota goal metric complement flag. It exposes this flag to user space,
allowing the complement value to be passed to damos_new_quota_goal().

> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 06af417bc9a2f..8f083611741fd 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
[ ... ]
> @@ -2869,7 +2898,8 @@ static int damos_sysfs_add_quota_score(
>  		if (!sysfs_goal->target_value)
>  			continue;
> =20
> -		goal =3D damos_new_quota_goal(sysfs_goal->metric, false,
> +		goal =3D damos_new_quota_goal(sysfs_goal->metric,
> +				sysfs_goal->complement,
>  				sysfs_goal->target_value);

[Severity: High]
Does exposing the complement flag to user space introduce an integer
underflow risk for PSI metrics?

When the complement flag is enabled via sysfs for a
DAMOS_QUOTA_SOME_MEM_PSI_US goal, damos_set_quota_goal_current_value()
in mm/damon/core.c performs a direct subtraction:

	if (goal->metric =3D=3D DAMOS_QUOTA_SOME_MEM_PSI_US)
		goal->current_value =3D s->quota.reset_interval * 1000 -
			goal->current_value;
	else
		goal->current_value =3D 10000 - goal->current_value;

Because DAMON runs in a preemptible worker thread, natural scheduling
delays can cause the elapsed PSI time (initially stored in
goal->current_value) to exceed the nominal reset_interval * 1000.

If this happens, the subtraction underflows, wrapping current_value to
near ULONG_MAX. This corrupted value is then used to calculate the quota
score, which completely breaks DAMON's throttling logic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918142827.8530=
3-1-sj@kernel.org?part=3D3
