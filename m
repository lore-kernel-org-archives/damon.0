Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCA3546D6
	for <damon@lists.linux.dev>; Tue, 28 Jul 2026 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216935; cv=none; b=sfvieSord3/mXj8Sn3YBmm/JRS8gMVTicVSDDz68ASRudZN2gvVjw5WnKcIvMQlpDK/+90K84cNpKPqa2QRdBHwAdn8cmo+mJ+0/L7Xx7rzF/49FZrN4U8JurtSdz+vDodZaDrQ026dLnH/8SuGx1VQn7Sz1v5uhPG0HVo0ogEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216935; c=relaxed/simple;
	bh=0jyI5zCaa2Mta5FNW6NRL7vBPRjUOgN0QyeXc8MwcsU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QyzKm2G5T186g4rlubWOCkrrDCbHb3K18ZzHRph2i7acw5NIemJPKnpMGjXpALreCX4frBnzwxIZSbjNUdCX0mvrXKmwaOg5m8clN7wuKCwK4cqsIP3FYWkUOIEzFrWfuxF4NfMtkuNodBDqlaxmG83WW9rhmO2uipLM9YIykOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECvodRl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECvodRl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B293F1F000E9;
	Tue, 28 Jul 2026 05:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216933;
	bh=WO7fIns+u+vSAhwblTD3HF4tacI1UeZahYG9+/C3ABE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECvodRl0xy4267bIakBk8hJHDrrpSyUlN0QxUa5WZ4kHgzCbyRp/yCQHWnNNH7kBH
	 CX3Pi43J7PQsZu15Xi4/GmiDz+T00hiWr7q+WpE+jZHsYSnHDIwPgVLpkUnfA5b1yo
	 p+wYPnCCfCxfvxR1f3N6Wk/6tpuY5bDmU1+Co7eqh9sIwa/cefykILLw3twDhH31i6
	 QUGbotsMfP6TEWAMoYhJrs2BZyiUTSaT62JObNkPl6o/bLJCUY0E7GRrTuA2yBoPLf
	 y0nRXxMtBXvRrlfengb6XYdGS6CaglX91zpmBUagFOsAkNVIwMy5Vh3uI7JJ06mpVe
	 Rb3o7rawocEPw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/10] selftests/damon/sysfs.sh: test
 hugepage_mem_bp quota goal
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260728052811.192712-9-sj@kernel.org>
References: <20260728052811.192712-1-sj@kernel.org>
 <20260728052811.192712-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:35:33 +0000
Message-Id: <20260728053533.B293F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest unconditionally fails because the kernel implementa=
tion for the 'hugepage_mem_bp' quota goal target metric is missing.
--

--- Patch [8]: [RFC PATCH 08/10] selftests/damon/sysfs.sh: test hugepage_me=
m_bp quota goal ---
commit 033ea051e9d9dfb2787f833f5569853c4af61194
Author: SJ Park <sj@kernel.org>

selftests/damon/sysfs.sh: test hugepage_mem_bp quota goal

DAMON sysfs quota goal target_metric file now accepts 'hugepage_mem_bp'
input. Test it is accepted in fundamental DAMON sysfs file operation
selftest.

> diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selft=
ests/damon/sysfs.sh
> --- a/tools/testing/selftests/damon/sysfs.sh
> +++ b/tools/testing/selftests/damon/sysfs.sh
> @@ -210,6 +210,7 @@ test_goal()
>  	ensure_write_succ "$fpath" "active_mem_bp" "valid input"
>  	ensure_write_succ "$fpath" "inactive_mem_bp" "valid input"
>  	ensure_write_succ "$fpath" "node_eligible_mem_bp" "valid input"
> +	ensure_write_succ "$fpath" "hugepage_mem_bp" "valid input"

[Severity: Medium]
Will this selftest fail when executed?

Looking at target_metric_store() in mm/damon/sysfs-schemes.c, the kernel
validation loop returns -EINVAL because "hugepage_mem_bp" is not present in
the damos_sysfs_qgoal_metric_names array:

mm/damon/sysfs-schemes.c:target_metric_store() {
	...
	for (i =3D 0; i < ARRAY_SIZE(damos_sysfs_qgoal_metric_names); i++) {
		struct damos_sysfs_qgoal_metric_name *metric_name;

		metric_name =3D &damos_sysfs_qgoal_metric_names[i];
		if (sysfs_streq(buf, metric_name->name)) {
			goal->metric =3D metric_name->metric;
			return count;
		}
	}
	return -EINVAL;
}

Because the test assumes the write will succeed, the missing kernel
implementation for this quota goal target metric will cause the write to be
rejected and trigger a selftest failure.

>  	ensure_write_fail "$fpath" "foo" "invalid input"
>  	ensure_file "$goal_dir/nid" "exist" "600"
>  	ensure_file "$goal_dir/path" "exist" "600"

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052811.1927=
12-1-sj@kernel.org?part=3D8
