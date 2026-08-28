Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1732ED3A
	for <damon@lists.linux.dev>; Fri, 28 Aug 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882274; cv=none; b=fNv8+cL3YCWOrCdBshxmirqUw9G4sLcNjSaMbGKANMe6blNurv9BDGRPWX995fGBzlHUx/riN4mIlobyHpJpH2ke7Wg3EUxcqtls8UFOpBKencZl0rEQylpLL6PIME/K0u86v/0iK6ebWulTzGC97sn/aJmaBnu86ZVr3cF38BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882274; c=relaxed/simple;
	bh=TYuHr9eY5ana7a8pAgydJwqC3Hq7v6Kq/2HqhiTxPTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SWGY3p32R85fsPH5dG1Nie1e0VG97cUIbiswFQKGlGTV168XuVcVHgl1tqNXphtXPtTmLmDtCgdkN0/IdAhns0CuwoYnslsjEpOjUUwGl6s7/PmJrNv/PEvkNFCJTNlRJbQEFvzhbKKtXHczpgoevybogU4irZiaUSifQI1aRTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPazD9Xt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPazD9Xt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23881F000E9;
	Fri, 28 Aug 2026 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787882271;
	bh=KDE2JXu95ujycY6HLUdy8vDEbx9cgfEqVLz95UZrYGM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RPazD9XtZu8HAHKP5HoClgoLL0qEt//z5slZtyBguMpQtRj/uYQXgzboykzRVnlHv
	 +hBRyedKPgSiiGX6yywkxErf+DbNjWKzlH7D5WQlJYyt3CsgDBGB82WUDQvZJclL7f
	 wWgQo8ZsZlynwBkeIkqj2TVda29s03BvoXGwNc7eRq9/vmb46WbZ7HREZNlIYz/5X/
	 GLsFAb+O4RkgBT2bULp/17sjuAIg2RwdTGuE5sQMCgNObElADdw0ZqrVY9ggJi/wxQ
	 +isyrRIe06H2Hf9MgsMCxSHjzR73qPPyPLSyyjdCx8HGFhYE9Y9O4AlBWg6VdnaJDZ
	 Ss9oMOtM6ahLg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 4/4] mm/damon/sysfs: set next refresh jiffies
 per sysfs context
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260828014659.121058-5-sj@kernel.org>
References: <20260828014659.121058-1-sj@kernel.org>
 <20260828014659.121058-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 01:57:50 +0000
Message-Id: <20260828015750.E23881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> When 'refresh_ms' is set, DAMON sysfs interface periodically updates
> auto-tuned parameters and DAMOS stats.  The timestamp for the next
> refresh is initialized when a DAMON context starts, and updated in its
> damon_call() callback function.  That is, each DAMON context updates it.
> However, the timestamp is a global variable that is shared with all the
> contexts.  When there are multiple DAMON contexts having different
> refresh_ms, the update frequency will be changed, depending on the order
> of the contexts.  When there are multiple kdamonds, it will be even more
> chaotic.  Fix the problem by having the timestamp per each context.
>=20
> The user impact is not very critical.  It does not leak, corrupt or
> crash.  The update will not be faster or slower than the lowest and
> largest refresh_ms values of the contexts, respectively.  The user can
> also manually ask the updates on demand using kdamond state commands.
> That said, clearly this is a bug and can easily be reproduced.
>=20
> Fixes: 9fd7bb5083d1 ("mm/damon/sysfs: change next_update_jiffies to a glo=
bal variable")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828014659.1210=
58-1-sj@kernel.org?part=3D4

