Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47329556BA0
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879391; cv=none; b=g0r8mdWBf0JJe2Non+1Z6+UzyPXhHCElDlBzpqOjs9Z4PKGaHq6UtAR3JAsHDqAXyv4fzFtREG6q1fWuGN/L2ABth80FPmInhArebOKsiocHGlpV91yfgsj+ugPBaTMM7FnUhN84npu2oWoW//5Nf/xPu/4d31Yk+NvrEsGRRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879391; c=relaxed/simple;
	bh=2I4WVyPc17dY+iQqY7wyoJr/cqhYb/4bSP7fq4+xL0M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SXAMpTMcREX+wNhfpMkU5TZRZzdkLDD+C6JZ0S64JlaWZDCwP8DlkmgENNreTU7YAnkD7yxdF25TS7fHbQU7QN87JOBz6tiNqH5WqTd0ILoZfYxYi9oOK0IbLfWqBHRM74mKFz+x7Hj6JcoJnd6BGwStDRYB4FWDDlzN9suVVCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4164D1F00A3A;
	Tue,  8 Sep 2026 14:56:20 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2] mm/damon/core: reset invalid
 quota->charge_target_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260908144246.104162-1-sj@kernel.org>
References: <20260908144246.104162-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 14:56:12 +0000
Message-Id: <20260908145620.4164D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMOS can suddenly stop working if a target process that the quota is
> just fully charged on is terminated.  Fix by catching and processing the
> corner case.
>=20
> When DAMOS quota is fully charged, the target and the region to continue
> applying the action in the next round is saved in
> damos_quota->charge_{target,addr}_from.  In the next round, DAMOS
> iterates targets and regions from the beginning.  It skips applying the
> action to the regions until it visits and skips the saved target/region.
>=20
> Virtual address space targets become invalid if the process is
> terminated.  Trying to apply the scheme to invalid target is just a
> waste of time.  Hence commit 6e4930e33329 ("mm/damon/core: fix wasteful
> CPU calls by skipping non-existent targets") made the logic to skip
> invalid targets.  However, it does skip before the charged target/region
> [ ... ]
> [1] https://lore.kernel.org/20260830064708.40CA61F000E9@smtp.kernel.org
>=20
> Fixes: 6e4930e33329 ("mm/damon/core: fix wasteful CPU calls by skipping n=
on-existent targets")
> Cc: <stable@vger.kernel.org> # 7.0.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908144246.1041=
62-1-sj@kernel.org?part=3D1

