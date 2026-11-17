Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936401;
	b=JbOHov9MqgP+hqslX5M+25WDe+Fftf20cmc+7wDyIbLRGMwFTwVtrvCEpsmhK7nmiN6j
	 Ml+0Dx/moxEP+wOuN8/xURYvJcpx7ZXzSUjpxCrvNc/GHjNRZ7g4t+/8yl/lvpb+qmn4x
	 MF2D6YL/RmBa+dsLQsDA2k1VhiYpDw2vVnWDE7X4OCYZoS0t29zVUSVJf1i95hc7W30oD
	 y06UiyAcw016b5Fd4n7kxqi2DbZ1lqwIaY0bRb4HNM7/Nt6RqKWXpL0uKAM3j+KsmmbM7
	 Bs4rToyoXYFBYTqHUrHFtpwFQU0JqeY1YkrpyS92n34ypbRfA+DGVf1wUJFytJzk+9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936401;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q/R/KJb+HwhtNYFDXIwudlBXhu0oCHpPkyWGYW4fqmI=;
	b=cnNA0PzC0ceMwEVDDhOGEuPujhHWTLWHmuw0yZkaQtKWK1VkQP6OCRgEzoCth+DjqLmn
	 cpZYLjJ9+Qf3It7GKYLmmtddTIdp0gUC7OR89ryU+/CB5yNX0B2/oWduQ8/s+bz1+mWjL
	 AtfMmlBKPYZRXTzorJl/n0FoPp+b9RN9Kn3MPKElz/jGhsza7BjbZDvgXeomR10QE2Fu5
	 PjAjZS/5OX8cWwhCw609ua8FgrF2Gs+9c7lKC+gTMpVFejArYcPuBKCX1vN2W26H83yZd
	 YmXlLObT/fI25Q4wMEK16V32PTZPpuFR+kToIjqyZZ1D4aQTXPVtH+F87Vd8UOWJM7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OICTqEug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA01606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OICTqEug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4175B1F000C5;
	Tue, 17 Nov 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794936401;
	bh=Q/R/KJb+HwhtNYFDXIwudlBXhu0oCHpPkyWGYW4fqmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OICTqEugLu05GIVkRLTcsK9NhsgGmZgQflCYcp1sPOM80e2bwQGag3GK5ptWVxJAb
	 I+hOWx+PJ7o3WnIDqh2PVMU2cG/eF5zDiu6BE3JKDcNhJjCkFccS1JOUrQGi+JJF2L
	 +Hy9dmJgsBn6Ba/HVV1M/AWWC2mdMvt5otW0705X1JQXIQODV0dStSS6RKrwPbysLK
	 BpMZuIsmijL/wS28dFVBw3if9rzNKSfGwGaLuUwXK3N9WwQNCazBdm5vumtd1XHAVt
	 dm0recu5cjSFhfuDXoD1g44pxMwz9olR2eUuXVnNpCZc/CE1rDXXpc3uJPi0y94sVR
	 IO+HJrIP6GnzQ==
Message-ID: <sashiko-outbox-219230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: add test for damon_call() on
 obsolete ctx
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sailesh Nandanavanam" <saileshnandanavanam@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117172219.26725-1-saileshnandanavanam@gmail.com>
References: <20261117172219.26725-1-saileshnandanavanam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:26:40 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> A newly allocated damon_ctx has call_controls_obsolete set, meaning no
> kdamond is available to handle call requests.  damon_call() should
> return -ECANCELED in that case instead of queueing the request and
> waiting forever.  Add a kunit test for that.
>=20
> Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117172219.2672=
5-1-saileshnandanavanam@gmail.com?part=3D1

