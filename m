Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAEB4A5C29
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004159; cv=none; b=eKERZOuAO2O+XurCHWkf4VYsE66NIU1PxqvTAAC3ek3T3sfq7gPFl+wMiXQSE1ZJKaom3I2TZaA2hg3aIN4exJqKG7ULA8QroQxMAbC+6IBEfMmJx8w1aeHUyZNfm49eX1Qq+ixUMrJnzpToqhH9rE0uPhHeXhYiK94CdizN81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004159; c=relaxed/simple;
	bh=BShN/cJRZDTexDvRqdmDzZDOQS3faJIaUhikYdH8Hg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gswf+crCIpxPYzH9B3In+p6cdGOWsWvi/wnUVcndkAYptW1BeEP5Y0f0x+C1CC9wFRrAEYkPrA2xqAXVJaaGVR3wfL2KT7vGIPk4+DDg3cbax7hsd/zgV3okfbJkkGAla6qKpaeU4/hOG4uXtxOx8HO7yqtl+cg0dAeeIRjnnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndaLpHaL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndaLpHaL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5C31F000FF;
	Mon, 21 Sep 2026 15:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004157;
	bh=BShN/cJRZDTexDvRqdmDzZDOQS3faJIaUhikYdH8Hg4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ndaLpHaLkFm5pDAGAEKx2uutah2pb53T2Q1lkS1BSqaNc5RR5VtDQdDGE8AHLAK4B
	 M1JMXTSzL2AU2In15FUfZxbGgNYU3e69/k/1xO6XLAEY/G3LHNFSZcW4RmSCqYcrwP
	 e1X9dZhF1yi2PB4FFLWMrmWlNcRzvuCAAUCIpmbrlbExien6EdIXBfmDkbkxhOa9Oa
	 30WVbGZz59S7QcTrwrNyFOssmkowr+8sr4Vq6r9a8oi88aw9N3CO8fkoN7VNEwBD+I
	 7aXos6t5YX1saAKsNNLYUHBM2wiXefxgMG1xggR6wbMFXeOHEywLs/WlQn4vg/j3hM
	 bd6p30hgtpInw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] mm/damon/sysfs: propagate damon_call() error in
 turn_damon_on
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921151547.78472-3-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
 <20260921151547.78472-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:22:36 +0000
Message-Id: <20260921152237.5E5C31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Xuewen Wang <wangxuewen@kylinos.cn>
>=20
> damon_sysfs_turn_damon_on() ignored the return value of damon_call()
> for the repeat call control registration and always returned the stale
> result of damon_start() (0 at that point). When damon_call() fails,
> e.g., the kdamond is already exiting, the user still gets success from
> the state file write while monitoring is not actually on.
>=20
> Save and return the damon_call() result instead. No rollback of
> damon_start() is needed since a failed damon_call() guarantees the
> context is stopped.
>=20
> Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921151547.7847=
2-1-sj@kernel.org?part=3D2

