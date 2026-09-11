Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B9CA6B
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089710; cv=none; b=Q7N0fMttryUp1hXi0XQGFj9xI7sLUIzM6oLIb6o+06jMjYXXTTOH32aUpyv2szSw+C9vepPo6Ot8ZvgH/6ktgePZCz10qWfKPRYFPDIkJWGOdGTEyYtTJv37V/XAQsyWTCLgPSkTw9hcuAWByH85oztRZssiV7bqY0ZsiGZgY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089710; c=relaxed/simple;
	bh=BvQrwYzMmVLK7q3i2wlixUjtVNEe28uNdtmeX3vcjHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hul2D1NM1MqFExz86+FeMlbcXg2JonUSKzO5Sru6rfmXn/D1t79PLDIEkbErD3qAKAw2UZshh4SuEoaUGVjVpuy8Fj6yTkyXdRhlOXMdj4WKqmOnpHtdbk5Ej74c3pQGOnbfukVKvDN4xaBzWgbx6t3nmgTDa+2pxUi2ROiHQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1T3agZb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1T3agZb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C5D1F000FF;
	Fri, 11 Sep 2026 01:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089708;
	bh=dsM1iFmIUIKXu+jzk8HxjX6+hveTDXLPuRfZUa+m55A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1T3agZbvpN3tHCFM7Z/ie6+WGYzMsaXDpwaQbWPJHhAtnSOVceLMPP5w5Dzcwr8H
	 DL2jK9cRCiBTKpOBS/KHe+4JuUyl3y8iG2t07Ve3xmfBry5i4o9rBxaQ9YpeiTO3O6
	 d/u4DlfzftTWJ6301+glKWWcX52SGDzgI+rdy/TURCkFQGLiT81aM2f3XubzHUXDJ/
	 f234E9rIbxLsoi1VVulZnsYYs5IQJ9r6zJ7tv635KxudJvs4MlswGDwKlYXPUldUo9
	 wm1DfCy4C8GruV2XyQu/JIgs8XFYCE3Z6cY6J60WUeMoWn3ZibGYOTG0zugEfWDS6B
	 uJOU4M176Ifuw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2.2 2/7] mm/damon/core: extend probe_hits_wsum()
 for moving sum based calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911011330.93678-3-sj@kernel.org>
References: <20260911011330.93678-1-sj@kernel.org>
 <20260911011330.93678-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:21:48 +0000
Message-Id: <20260911012148.88C5D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> damon_probe_hits_wsum() is being called only in aggregation time.  In
> future, it could also be used by DAMOS.  In this case, since DAMOS uses
> its own apply_interval, it could be called in sampling time.  Then using
> the not yet fully aggregated probe_hits could result in suboptimum
> outcomes.  Extend damon_probe_hits_wsum() to get the weighted sum based
> on moving sum to prepare the DAMOS usage.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011330.9367=
8-1-sj@kernel.org?part=3D2

