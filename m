Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7C47D94F
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269306; cv=none; b=HSQQruBxqVodbg0uaJdtLDLqfKk0j+iGuCjK3Comyev2pVc9W6cZSWG47iyf+beidgE3ZKWRQKEcE9+R/NuSK8iLINzt76Bm2l1B+sVWtKGcdMRzJryDS28UJqvYQq27B+Qx0Lyvoafsc/G4p0LRBnxQajupeGLgDCVYlDhV3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269306; c=relaxed/simple;
	bh=S4uadd1M7OyW4vkdJ4vOf857Q2HAYPa9KGRvomykniQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Spzhx9YjaQR/4kz/8OyqlFqa0zZgQmLfuYgkpnF3PcFAtqs0posMkeqYmHDH4hYHGT0ymlBjSq3fFJvLLSdsXBppHk011y5xPNezBKniycw3y1xJCAuCfXtmrM66fCo9mOit1tCAia1x8N5AqZmlAtRxF1txYmxqiHXrxbuoU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu7F5pDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu7F5pDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11051F000E9;
	Tue,  1 Sep 2026 13:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269304;
	bh=ZJGNO/FVaxR04sgcYa7TiM/XLsznAO8u/PXR7zjgKV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iu7F5pDPGkuMfSg8Qvks2+LSEMB3gszogyHEBZAiQ5Nhmk6ir9EK2iC1E2gbPVhVh
	 GhYFZ+3HK0zxH4Y8AvSioLIG+1i39cAlCV1ypV9GljbYA4SBgxllnAtGyADy0oVeZ2
	 LrATv5y9nUtZ/5g53oeXCYgg9vsLD6dAZyB6I/ve/Ttl9wedj41OcSH7rYHZ369RI4
	 dYwTrzjebHj87A65wLAf79kc4OfHFxhcPP+FZXy9K6oL+DNyVpCGQ5UML8fxJZW2xn
	 xUHOoWRuhWzT9HFL2VLxxf5Q2+F/x8p1HStpBZT8ToLk9b3zXSraARH/1ODqdVp4qp
	 X1sOpfIZQFJ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] mm/damon/core: skip applying scheme if region split
 for quota fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901131850.98037-2-sj@kernel.org>
References: <20260901131850.98037-1-sj@kernel.org>
 <20260901131850.98037-2-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:28:24 +0000
Message-Id: <20260901132824.A11051F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901131850.9803=
7-1-sj@kernel.org?part=3D1

