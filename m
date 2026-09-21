Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C704C226D
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004720; cv=none; b=PeBPXypI1eQpOSfJufk8YRGsxCBFSPpeNuaePgW2cs6doEYnBvgQbtVTvR4EKLYyN+9sZ2ay+BsydUwhSfCTDZ2C/RlyeJHJwFlIazYtnJa1xCv8y8VasPGkysf8+rmJOgPArxqShz6+CCxYFuBVmGSfpguQntt6kc+wS3lKUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004720; c=relaxed/simple;
	bh=0E10U9i+3xuRy0brgsAufm1I+ah7vFddL8ZjJ6Rwv/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QfNY3zVbfSuma7GPKDYkZMSClUwgEdOjsqHxCtof9m6ASE8jrAeSc2HN5y6xvxa2eZFpEPiyv29Zo/mStHzMSaCfT1Pl345k6D5UGPHQ0JL7N7SWtX4K3m/qVHmHHCH533YlOSBgLSN+odwRppMGmhVuJxGuPRDaMxqdvYmk9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YM6kU0Fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YM6kU0Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532BB1F00893;
	Mon, 21 Sep 2026 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004718;
	bh=FhhDciiIPJ5jVYWJaPmH4QgaWTgFFoeUA3sTasVHXfc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YM6kU0FyfNCzYTVNxhGbgGeXyrKoebN4a5MHfz0c+fhXvvR+FNoUK0WEsMYUkXsCv
	 KKrM8EPkQjsVsJRcSPsrM3Wfp127nKq49oyl6mMzUTrmFpvtc/aGBZAO+5J0P4+PM2
	 AObtSqq3838qAQ4bLWVwHLHMLpIZWCfu0kaQapNogGJugiobqSNA7OOAUzsUjTl3O8
	 BzYrbJnSTjgQVbc432dNq1KREfJU6hQ0TYJ1YJTkALFcQnF7S5/X5bxEL/ji3SVUVx
	 9od4w6SUQS40cmtzy2Ely2ghrZuNW52OWGXrtrAu23x9C/nsm/cWZxXrWYoyeR67qs
	 UW/RpqDTHXzgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/tests/core-kunit: test the size charged
 for a filter-trimmed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921152443.80132-3-sj@kernel.org>
References: <20260921152443.80132-1-sj@kernel.org>
 <20260921152443.80132-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:31:57 +0000
Message-Id: <20260921153158.532BB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
>=20
> damos_test_filter_out() checks that an address range filter splits a
> region at the filter boundary, and stops there.  Nothing checks what
> damos_apply_scheme() then charges to the quota and reports as tried.
>=20
> damos_test_apply_scheme_filtered_sz() covers the two ways such a filter
> trims a region: one that starts before the filter's range, and one that
> starts inside it.
>=20
> damos_test_apply_scheme_filter_sz_unchanged() and
> damos_test_apply_scheme_quota_sz() cover the cases whose accounting must
> not change: a region wholly inside a reject range, one wholly inside an
> allow range, two filters trimming in a single call, a filter type that
> never splits, no filter at all, a region the quota trims, and a quota
> remainder too small for one region.
>=20
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921152443.8013=
2-1-sj@kernel.org?part=3D2

