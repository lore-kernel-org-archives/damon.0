Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA935387361
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 05:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328464; cv=none; b=c5cEtVVGUy43POA7WWDqYPGCkhaDDYZMqWhcqWhrSiFVVGdffmN3EJwSLORot5Q0RzOiKdZ2GXaxA6IbvTraUSYDcp65oW9BKF2eavkSe6DN5kjt0gE07HXjdLpkPxAyGbCwJDH0J/4fsNrWmA25vz9OWd4Oo0g9D7qUrSG+87s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328464; c=relaxed/simple;
	bh=QajBh7HT9POXccy2DeKa86AV4GlgX8uGQK8aL9XuNlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lMaeHQIBSwMg37+PQw5xewjYEHwY+v0tobkPsBzIHpGkqMIn/gRS03Szxf2bOtF5Hwjm0RLlO8ybuyToIRDVF6jtip6kUOh0pAvSM2xJL3uYuyJeu17QAhPb+ZTzHrv4HmUGwrPPPI6srnYbM2Sq1A8xjMldPVOxt0PseXcoO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvVGDto2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvVGDto2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D211F000E9;
	Wed,  2 Sep 2026 05:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328463;
	bh=Vk4gZn6UaxGVUSPfZKpWimC7qkL6koPUPjlCT4hnrZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvVGDto2BAqv7qaJhsM/uh5TbyJtANwrBVTh7//LmMNeE0dtrCUY2AAv4Ay0szWMT
	 32boNVtXDuXpdy9M9p08kcVSTl5H2z8A7j0O0GI5k+vMowVaMp2esk/4Ixjiw/2MmP
	 7jsjbIBD5+MpD8qPJhct8+2aqqBfaRalpnznhyKUGcnUYKyAAaqhMRfm6YROGl1S9g
	 aPQbTouiKx7Hb5LK5oJxnoaGkgPIypLiKCPhF8d73eQQIY+rxchgRnI/BO7bbm8zkF
	 UBuaIMiy5swTZjBCrySqbH/zqCzBuPVWBS97cx4Q7OY2ELYtJF940i05KOzPusZY4D
	 8yiPymbW/CelA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] mm/damon/tests/core-kunit: test
 damon_nr_samples_per_aggr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902054747.99370-10-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
 <20260902054747.99370-10-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 05:54:22 +0000
Message-Id: <20260902055423.17D211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_max_nr_accesses(), which is a previous version of
> damon_nr_samples_per_aggr() before the renaming, was wrongly returning
> zero or random overflowed values for extreme intervals setup.  Commit
> 35d4a3cf70a8 ("mm/damon/ops-common: handle extreme intervals in
> damon_hot_score()") updated the function to return correct or more valid
> values.  Add a kunit test to ensure it is working as expected.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902054747.9937=
0-1-sj@kernel.org?part=3D9

