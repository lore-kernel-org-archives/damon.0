Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6C9298CAB
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320383; cv=none; b=p8m+P1/TKDX/GYKWhc48xtBX7Dn5Cl7RK6jjQ7KY5wuELqbH/BZlKABQu8jhz8WDo+UqGxNcqtJqJ+ipvgyvYEPTNTp7gFcsHhC4D9Ja9fR6v8cwtcm1luEp+D5moErZ48t5UkZd3xXiDetrgKTyaEV/kwv6nAlKO2GpBXXmR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320383; c=relaxed/simple;
	bh=Ljj/Xg7AirtDb6OfwZjJBXxCaU2ghXhD73XQDhAzv7U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PTITI0qld9MV+3QAmRYPv8sEhvTFiu6Lhw/CaOXMbX3iV8ivsoC88Gu4PBPsWh3C7n4/ulRNsm8uw4dIwTqvLPsHCmo3qIvCsPqujSigZYpE9+LqrTP/pRjnoukS/lksRv03ww9AE9Dovr8mWfMFpT6T1GlVDVFt5WGenSmDKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efVl1+ft; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efVl1+ft"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC82B1F0089A;
	Sun, 13 Sep 2026 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320381;
	bh=saC/Ds5ZaM72giAfEE+ol0pvVdQbHtliCooOASIYFJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efVl1+ftPg5SstQQ8Ap72zWMJPnjbojB/1dTNMKXUtytyhJyGucMDdz71J1MBuwK3
	 PZTsNgSEaxXoHjZGbjTf5gWvSs7w48wjHFp2VYJdeWKKBDJqbqx2UKerm3N3DAxB+1
	 vX9X/r/jrGzpiSb2dJDwqKfoyqacvlaMMZJq7gljIquujn049Xz16Ob9/tNKkUTYfO
	 4W3rPs6IPEu4ucoKzezwqTSTD8TzqgJo5zrfAMoUK1zZCcAjxw3TwS17B6KMJeRUji
	 l6L5ZZyaiM59/II2bvo174SxQ4+Zt+GLt5ndvf5NX7CGUxuLNwfZkf+8tqN+dFTwHA
	 dWxLV4dEZogAg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/8] mm/damon/core: disallow max < min damos
 filter range arguments commit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-5-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:26:20 +0000
Message-Id: <20260913172620.CC82B1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_commit_filter_arg() receives range arguments for a few types of
> DAMOS filters.  It allows any range including max < min range.  It is
> fine for the logic, but makes no sense to support it.  Actually DAMON
> sysfs interface is doing the validation on its own.  To avoid duplicated
> validations in multiple DAMON API callers, it would be better to do the
> validation in the core layer.  Add a validation of the given range.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D4

