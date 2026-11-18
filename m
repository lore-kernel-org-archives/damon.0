Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036335;
	b=vzcQpeLF7yZ/mPqZujczCOxJ2UwglhJD8Alca4jMZVsweLQzaqBlpJQPJ9IlUq/Qab83
	 RTaQn3wUJ5ujWRONrDPYkbIy29YJNKesVkTt2CFRv05jgws8LFrrjv0SD5D0RWhYMmqbS
	 XvN5wp8cOJOkuksxcjpRpdGMztNPKBw823cdBGc/lKynvXYAtQzyR/AVohtVwwOxTrqis
	 3OokUG4tO0rJ4z7Qb9momoD4+xgOQH9LX3zC9AYloBOyvMzz9qDDJVDJAoyr0m0Cd067d
	 wIaX3y9XI85Ch3R/toQa8rb3KIPSgFwvHjFDZFa6rKeDzGCbdN5qt5UykAuJHgpCF/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RtEg7apGO7wLStOWmMBoN0UMjCFmpmp0XbyFt6uNEAQ=;
	b=z8rgqL/uGPlyCd1v2MjnaSNWbGMTTwm6vvy0KgfMz15c5VhvNmrIvOFsqtwdnDwxkc/m
	 ghAkjb4uoSKCh8iATWRaxXRn22Dw8i/6sVVzAurakREEaG3F4A6y5HORenjeRFjrVqI6O
	 8F4WySt16w4QqJRYIU+BAP+ssbmNfMSIbgMkbtc65/TUQItTtx6/fP1u6lIJPXOLpiuz/
	 PhX9DS2qQV+/h78v76vn5FZFsb35g22jm/9peKbEt0fjqaXUmJUi6Eo6BhRiWJSFUrXjb
	 rW9F63mY6w1QC7zlxmA4PFNb3N1zH4ajNZFIAccv9Z2lur6pyqCsjoLwEReVNiqgMKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9EslLvO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64583606A32C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M9EslLvO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817721F000C6;
	Wed, 18 Nov 2026 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036334;
	bh=RtEg7apGO7wLStOWmMBoN0UMjCFmpmp0XbyFt6uNEAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M9EslLvOy5PDxm33/m3FgruTMrJYfbI0pD1ZMlGUc760PEuLJw80UmVAswwrPaP1c
	 J/eqfddSJHfBuwgK2QDLbRFLqcROKbCT4s+/gFmCcLRyoVqfWIEF6GDhtQWjq+p5IJ
	 6l362R0xIylX+atW0/dezTBs+T7jxdOrrKPW+vv98Rv7gNB0e/P+6rLcgzv3Ty6WAp
	 WlAdW7v5Uq1KmpKf9f6OI7a1uvsTCHX1XYF3KYwh9VzPFQm4OalAf+nzcIKTu33NiC
	 nuZoCcqfna12Kp40BaIhW/A9/n23PPhR6VJgPwLYqNjmhg9+iTojnKJxSFc2hxguYd
	 lc13FFMs+41kA==
Message-ID: <sashiko-outbox-221977@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/17] mm/memcontrol: allow update of LRU statistic
 without holding LRU lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-2-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:12:11 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Kairui Song <kasong@tencent.com>
>=20
> To enable moving file pages in folio_mark_accessed directly and lazily
> for MGLRU, allow updating the LRU statistic atomically without holding a
> lock. It may cause temporary counter underflow, which should be fine as
> the counter is eventually consistent and only serves as an estimate.
>=20
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D2

