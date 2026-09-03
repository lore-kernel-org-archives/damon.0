Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D01D63F3
	for <damon@lists.linux.dev>; Thu,  3 Sep 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398162; cv=none; b=nBO8j9+3HkCAe1C75rJGNsNxH5W8o8ly/LQkSgSP1azaMQ7/l8thZ8Vn4jJd+GeuTocwtf6KhOOrt+YUdjWFZBs85Kzmbh1kZbNPkewl3q7Xz+W+dNxY9zWUj1onbzh9UW2gACWKkCrhKjtMEE82oGwwSQvXEU3vgr8+fU1tJm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398162; c=relaxed/simple;
	bh=X9+wrNNr+JWkyZ6NPlcp60z2gkryZh8FWla5BVbJGQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DQmfSmPQaKGIVdfKQP8ccgaf3r6myk2le8q2bTUmhuPctgk+fThTt1Gwpus2Sr1anqkNtjtEQ5fFa8+aAHBkPzY/YlhcdzxAPLi2EVMAewg4GuxpbYu6eKaLjHIBh9uWGFyx/452IeACAiNhbZVccniYy3gZtNRnpSHZmt+Oe2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4KBGdeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4KBGdeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A801F000E9;
	Thu,  3 Sep 2026 01:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398160;
	bh=LddaiEHmy6STCK03RgJwmBKOqQ+lrfuNXgD5AphN36w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4KBGdeVdib02znS7n65nb0C6NPoI+09QK+gGEaj/J605/f3TwoqIQsMxkCd89jff
	 M8Dcl5aoQlJ2ETihdg1DBA/WLAEBGYSnNJUDQpnEk0peJvF0J1nwRkXBWBuFlEmBJB
	 rzjM+ZFygcFo715QCDZTsjK37vzRwmGKN/mgTJW8W3Xy/HIFI2wI+YGGX6eVrNDFwy
	 StcsNnG0A3Ixdvw2nA+UUzlpm/5lRqmrYUqgr7F+21gD/DZFh9IAUvfBAX/vbzFMUN
	 gfES/0XPqpnv3lQx5ezOZgUkC1bxYTKQEa/PaRS+ql6losRxgJyHFiRQXWEfVoLEG0
	 F+reu5LPkbSmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] mm/damon/core: error damos_commit_quota_goal() for
 zero target_value
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260903010722.94244-2-sj@kernel.org>
References: <20260903010722.94244-1-sj@kernel.org>
 <20260903010722.94244-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:16:00 +0000
Message-Id: <20260903011600.72A801F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903010722.9424=
4-1-sj@kernel.org?part=3D1

