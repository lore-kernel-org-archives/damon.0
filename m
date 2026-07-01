Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3D40F8D5
	for <damon@lists.linux.dev>; Wed,  1 Jul 2026 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919745; cv=none; b=aWTDWgiQLHJ+RYLINdXOkRHcWxWBY38vQK9VO4GmKDhqgBb1ECTfPwW4q0bEEVPfr/fNXhknk9m6ONg7kNTSxogpSnsGr+JIjsgGhUOGgXTTc9N7XKeD+hQiafpY1J5yZMaphy8RSW6vKweH9cJT6TMMd1R9AnuMXbeQPZ0HaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919745; c=relaxed/simple;
	bh=qzFzwu1CDXWf9K7OZU/yPomwkC9WXcs+sul9/onaJ+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPYE17lmN4Wux75e8wrKhsWOlq4ownhiqfvd6x2DdanzzuOHngiPrQJ1efVEoSWLu/+HW5C3NEPKiNyFFQ5XZXL2EJyedKF6XM50/XjqNH8OJCTQYGHBFqWx2OTZo4YEdkxgKydN8rZR6k56o2zd+cvX8jNwyOS6R58Ou/iOho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njyLGoQf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njyLGoQf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8D51F000E9;
	Wed,  1 Jul 2026 15:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782919744;
	bh=UXfsQd2Jnlm3Zk7ozJ0CXigaSaqAMGGU2s0zK5EwGhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=njyLGoQfnWg+qfzATEDtQ2XZ+diCCSmJsR1BqRlUUTx8yt+K4Q3q18Bfyk71UxPW9
	 as/seeuLmcM0JXqq3kmfC5D/UC/2aCRGtBP3+IWIkqTmpNu2I060HkFRbWfgwiA1c6
	 y3zlbQk3SBD8tuZRf1l9V+K5KUm7IQk/KXsOiFmg62pt1Ionl/7Lt3R531c1dViSE4
	 B7RzwpxTwGzWT5AyuR1aGfc/LVzc4+ztcL1193XW68eR5nPcmuJitRvbgOXAhQzInj
	 PNO1lpsrzjGO40hp3aUcWFYbaN6FxO66qNa6Mp9WSwekatmJCVGCKNgRWV7DOWMYX6
	 1EX6G2b2OFzFg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/8] mm/damon/sysfs: remove duplicated commit input
 validity check
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260701144815.113325-4-sj@kernel.org>
References: <20260701144815.113325-1-sj@kernel.org>
 <20260701144815.113325-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 15:29:02 +0000
Message-Id: <20260701152903.DD8D51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the explicit `test_ctx` parameter validation in `damon_sy=
sfs_commit_input` exposes an underlying flaw in `damon_commit_ctx`, allowin=
g invalid sysfs inputs to corrupt the running context and terminate the bac=
kground kdamond thread.
--

Note: Due to system limitations regarding exact code recitation, this report
uses a free-form summary of the issue rather than inline patch quoting.

commit bec0828fbe945683bcef8cfdb56247414f2510d8
Author: SJ Park <sj@kernel.org>
Subject: mm/damon/sysfs: remove duplicated commit input validity check

This commit removes the explicit test_ctx validation inside
damon_sysfs_commit_input(), assuming the same validation logic is safely
embedded inside damon_commit_ctx().

[Severity: High]
Does removing the sysfs-level test_ctx wrapper expose the running context to
corruption from invalid user inputs?

In mm/damon/core.c:damon_commit_ctx(), it appears the underlying validation
logic tests 'dst' against the temporary 'test_ctx' instead of testing the
new 'src' parameters:

damon_commit_ctx()
   err =3D __damon_commit_ctx(test_ctx, dst);
   if (err)
       goto out;
   err =3D __damon_commit_ctx(dst, src);

Because damon_sysfs_commit_input() now relies entirely on damon_commit_ctx()
for validation, what happens if invalid configuration parameters (such as a
min_region_sz that is not a power of 2) are passed via the sysfs interface?

It looks like __damon_commit_ctx(dst, src) will fail halfway through, retur=
ning
-EINVAL but leaving the running context with maybe_corrupted =3D true. Can =
this
cause the background kdamond_fn thread to silently abort without recovering,
effectively resulting in a denial of service for the monitoring session?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701144815.1133=
25-1-sj@kernel.org?part=3D3
