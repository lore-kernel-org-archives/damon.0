Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F3322A1C
	for <damon@lists.linux.dev>; Thu, 13 Aug 2026 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600655; cv=none; b=WXeXXYcxtZZ78GSIMH87mQTOsJ+8oHo31BAJ3bXnmVNCEh7+2S30X4iKl2rypwQUhSigI+UfQp+qXVB5HuJ8swayBgt6v/lIHxUvtOQQUH40TNANHysmlV8IG3AGy+boqDVj7geu8lulwe+vtdWlXM+ESPwroka2OHZlw9N4dk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600655; c=relaxed/simple;
	bh=EmAHeIzvf6uzI6UoOZ3xvU+yX5EklArZk/x/B7Wd6HU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q+FpkjRU61u8F+4Oko2jCxse/8nMB1SDS8I6C04oqJvF7FiZC97BCJ2l8rcFmhRWmUrsm+NRjo26kuW/9yENVy/M7eABdVLs7gwynE60t3AubDuEzemqn4xks/ajn5YPblg7mPpyZ34AtCYOrtsgcXB0ehJ+Dn76GiRTUnaQXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQGlxCZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQGlxCZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E453E1F000E9;
	Thu, 13 Aug 2026 05:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786600654;
	bh=ANuR9PgNYeC/Ez0of576L4fTyKMSyLzLnK/eR4rf8l0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CQGlxCZc3/UeJxd+uPnOKOpX+xDSbJywZffyTNP8Oxaia+cRtr5OEni7MZwDeFbkX
	 fPJzo9nqgvQN+ucrYIja4dvN1VCcSTDeVHsZmnhI8JtiCTRnu2UiARcQOz3kaZzm5f
	 HZ8JTzQfALfryNUubLJp8xHgOJsv5ib/C8bWwsZaR72thWi/lAPNimpUyMYksnFXq5
	 xpf7dEBkF77bSuTv7GNNxGEFC8+jPj2g5ttFbGPC+uuN1AIY53uiDRuCjbrPho35V0
	 9Q7iPPhyzJeiDB7QW9B/Ku4iS9e0FaZsfyKQBYHkZiOEigEwoU2suaD3JbmqMNSOoU
	 YLb8+2KI70emw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] mm/damon/core: error damos_commit_quota_goal()
 for zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260813054432.101197-2-sj@kernel.org>
References: <20260813054432.101197-1-sj@kernel.org>
 <20260813054432.101197-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 05:57:33 +0000
Message-Id: <20260813055733.E453E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> If a DAMOS scheme has a damos_quota_goal of zero target_value,
> damos_quota_goal() could trigger division-by-zero error.  Hence each
> DAMON API callers should do the zero target_value validation.  It is
> easy to make mistakes.  Actually such bugs in DAMON_LRU_SORT and
> DAMON_SAMPLE_MTIER were found and fixed [1].
>=20
> It is better to handle the corner case only once in the core layer,
> instead of multiple places in all DAMON API callers.  One
> straightforward option is using an alternative denominator for the
> corner case in the damos_quota_goal().  However, the zero target_value
> is meaningless.  In this case, the quota goal is always evaluated as
> achieved or over-achieved.  The quota will only keep being reduced.
>=20
> Simply avoid using zero target_value by adding a check in the core layer
> DAMOS quota goal parameters validation/commit path,
> damos_commit_quota_goal().  Update it to return an error in the case.
> Also update its caller to propagate the error.
>=20
> [1] https://lore.kernel.org/20260803134034.15217-1-sj@kernel.org
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813054432.1011=
97-1-sj@kernel.org?part=3D1

