Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F6488218
	for <damon@lists.linux.dev>; Mon, 31 Aug 2026 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788198326; cv=none; b=nSg3yn+VAXIzBsPRRpzdNeYcRNuxhoaVzX51IFqJktSZ9sAGoQMw1odWGmt3AYBDFCL7eXhw8DFvOhCY+NZBMAz4EA8XHl9NHzEum532mVWrzaaELx0yAgYq9gJZ11vW91I38hF7sL8Qpo9tLKxhtTvoz4mpUjPLN4/3zERYdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788198326; c=relaxed/simple;
	bh=5gd83QLD5YEcuKU8n+QXI3Qix4rqPSW59i2GlzFRNW0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uhYGQlvjymgVu02mmtGhYgVFpRAaPFgQIHUeufExEoiGmEt5J9s9DIjQah/7ZzaAc2yNJq26NMRz0cfUJxYLHIaTjQ6X65+vMWLleGU0Cfr4yutZgPgWHGoOvAA3GNC6mtXwbe9TTHFOAc6wsl/zT/MGyN+fKr2bWFlQwoqcRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2H0KMum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2H0KMum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C7A1F000E9;
	Mon, 31 Aug 2026 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788198324;
	bh=bhLqmKgIDP6q9Yyv0PbdZsBD+tihQ2VoBjSaYTmIIOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S2H0KMum3m+TxPMNl5IXh6HZH3IpdrF19WAmOm7rB6w5QMFaVnbYg2QQSIktc3dqx
	 VPa6Jg1Jy9gRz80xOrbAz2PgSv6SGEiXD9GtKR+ffkcB1MAHL7yd/+gSmykiOdpL4o
	 zoZ9uGkNSlZnJI+3qIxoG8B8XumrEN1lWClHTj6erl8bL19WZyugWMYiI1gAFd/Ly8
	 Y2xNKO2HlPhs9Zl0iN8eGG7PRVEjJJG/5wiBFhvBfiKZ8IHovRtObYo7uiYcivPfMK
	 842ZkUHQCa9P5qwUR7ewnmO5yDIWtYKxVT2jzWI4JIHbikJ+pXqu1jhlmjyuEyF8Xz
	 B/nnTP3QPfNkw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1.2 1/8] mm/damon/core: skip applying scheme if
 region split for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260831140254.72004-2-sj@kernel.org>
References: <20260831140254.72004-1-sj@kernel.org>
 <20260831140254.72004-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:45:23 +0000
Message-Id: <20260831174524.53C7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damos_apply_scheme() splits a region and apply the action to the
> subregion if it is needed for not violating the quota.  The split
> operation (damon_split_region_at()) could fail for allocation failure.
> In the case, the quota could be violated.  From the user's perspective,
> DAMOS becomes more aggressive than expected under the extreme situation.
> Handle the failure.
>=20
> The user impact is not critical.  The failure of damon_split_region_at()
> is unlikely since it is arguably too small to fail.  Also DAMOS being
> aggressive is limited to the single region.  Users can set
> min_nr_regions to set the maximum size of each region.  If it is
> reasonably set, the transient overhead shouldn't be critical.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260718171523.87547-1-sj@kernel.org
>=20
> Fixes: 2b8a248d5873 ("mm/damon/schemes: implement size quota for schemes =
application speed control")
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831140254.7200=
4-1-sj@kernel.org?part=3D1

