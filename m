Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4A367F3A
	for <damon@lists.linux.dev>; Sun, 13 Sep 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789320356; cv=none; b=OyjzPaJ/XDSUsOd98BkMY+AWCdxZAXJd8yzzt8Qu4WBqJ06rGG1RNcoRwUG208bDImM6rC9EMLZa/70UvL4WTh29w5Cuc6xspYfVkwQ+y9kZcII4LBCA7gJz4A4x4l+PGMc79MIPzwTDanIHZoT0DFT9k59A/MQUoGhpqkJyiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789320356; c=relaxed/simple;
	bh=hQ/9Xtts3Q4EtjqV9KMXVUrN15kyUTRCMkBVLKa1JWk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MpfZps6lAdP1Thx31ly97Y3khpmaRFCHkqtQ9DqmAxAeY4LXjOI1h1/4a+4z9rxaqtyi+58lglnW3DWO4Pj2b1WyDBREXQOnCxkbHIlIvBcl4RmDQyTb/XC3oX0IJOQuYw+kj+SlsOQ/QejtV5mSAm+bQkDU+ewnnmL+a08Q3DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ3kOE7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ3kOE7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F2E1F0089A;
	Sun, 13 Sep 2026 17:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789320355;
	bh=CzHAo+RGx+yl+uhgmeezZQxkrBHCIjCh+Hl5e1DZDEg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XJ3kOE7vwHa+BvnyVrdeJpz9ZOzTvJO2cApQzpuppKi4Ylz4BJT1jgUC/ytJ+vnKR
	 hDGKH7BOe3wSA0XLuyNWQCu92xDzeadR0IP87E4be87DD1ugr7IIgMWLzk6vWBVXzw
	 adZ6gOCTl/xUJs/RYaDf5qH0qOkzAx0qHTh26gRTqoHHP7xC3qb0mK7PxhCH3VS7YZ
	 xQY8FZ3H6RyXjQKlwRVp+q3K4WfNhV19FOVWoJU44W5AmxHMLCsQTMXNl1uMHCAO/8
	 mXJoxCzZAi9q3P0+tjK1VFUOwFv87rVw24LvshldOPj3Km++n40szXYzL3H0neLMzb
	 XZ12y3HqpHGNQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 5/8] mm/damon/sysfs-schemes: drop centralized
 filter range arg validations
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260913171706.103052-6-sj@kernel.org>
References: <20260913171706.103052-1-sj@kernel.org>
 <20260913171706.103052-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 17:25:54 +0000
Message-Id: <20260913172555.20F2E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON sysfs interface is validating wrong range arguments for DAMOS
> filters.  Now the core layer is doing the same validation.  Drop the
> duplicated validation in DAMON sysfs interface.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913171706.1030=
52-1-sj@kernel.org?part=3D5

