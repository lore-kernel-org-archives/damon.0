Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CF7299A82
	for <damon@lists.linux.dev>; Sat, 20 Jun 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781976948; cv=none; b=mQZYvJ7JnuQOAuMG0UfCt6OTj/8I9I3yqMopfRl2olnUILQpzf4cmXyHL9Xh90nUglExx4wPC0GJOla8wxpqEUaPS7U76K7VcoO02ZTszGfONjV5YqHJ+JxCofO7sDcjMMY/IxXNDDozS+tHHo9mY/Gvu4VIX1hwjoScldxpXzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781976948; c=relaxed/simple;
	bh=bLMCfQZOypiKcH4IlP33f6McUAb5kE/4MvUIujoB/A8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UT9tI6yJxbCCNDdigJhN6j6SUIKz2PwQR2GG+uNxslppk+0rM7f6Yj4nMGYT7bstiFQEo7sNysq30VkbT4idz91BxfHFiZe479rHjVP+mqstvlP+RTUIVJhAur86ZICXgzyMuJPxqPiuLHJq1MLxtH1j0C3qVFo8eCvPfZyoR6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j95OpqrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j95OpqrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F18E1F000E9;
	Sat, 20 Jun 2026 17:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781976947;
	bh=ePZJFCrCD/q/4qeZq6FMPhkUWsBMMw9w7cH2Di790WY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j95OpqrLXnhVhsmt4jdy5UU+6hcbpeM25+r0om4msyGCBohj7zH+4DHXkhlxCteGb
	 DDJi54vsuW9y/O989mhiadKAXOkbSl82GuwGZMe4+1IDTz67b24cr6yKyacnHKolWf
	 /3lBQc/DP5BEh6jwgHTy4a2OFd5FPtIrheu1CzpO4zeKpRfO8X+e9HWhndr94V4of2
	 kfObYeW17tMtmdv3JAjHHSbdCS0JykXY4kS3ufjaqGlke9J5MkADF5fdKNay6OFrBQ
	 EHTLru3Qu96bBVs5daCgBlCc6Z8nJvRItsTdErvdh8CCdNKwqLBHjj9W7vrwFXyVcC
	 a5dImZy+EfO1A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.1 12/13] mm/damon/core: remove damon_moving_sum()
 and its unit test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SeongJae Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260620172244.90953-13-sj@kernel.org>
References: <20260620172244.90953-1-sj@kernel.org>
 <20260620172244.90953-13-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 17:35:46 +0000
Message-Id: <20260620173547.0F18E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The `attrs` parameter in `damon_update_region_access_rate()` is com=
pletely unused and should be removed.
--

commit 4c4d26b15dff409f33a357a198fe9f93686b61be
Author: SeongJae Park <sj@kernel.org>

mm/damon/core: remove damon_moving_sum() and its unit test

This commit removes the damon_moving_sum() function and its associated unit
test, as the function is no longer used for any practical purpose.

> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index a41b66b26a472..670cbfdf880ce 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c

[ ... ]

> -static unsigned int damon_moving_sum(unsigned int mvsum, unsigned int no=
mvsum,
> -		unsigned int len_window, unsigned int new_value)
> -{
> -	return mvsum - nomvsum / len_window + new_value;
> -}
> -
>  /**
>   * damon_update_region_access_rate() - Update the access rate of a regio=
n.
>   * @r:		The DAMON region to update for its access check result.

[Severity: Low]
Are we able to drop the attrs parameter from this function now?

Following the removal of damon_moving_sum(), the attrs parameter is no long=
er
used in the body of damon_update_region_access_rate():

mm/damon/core.c:damon_update_region_access_rate() {
	if (accessed)
		r->nr_accesses++;
}

Would it make sense to remove the attrs parameter from the prototype in
include/linux/damon.h and from this function definition?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620172244.9095=
3-1-sj@kernel.org?part=3D12
