Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774765;
	b=beONvf4nuN0XKviLnlk4ZNqqncEa4vk8n2Gewd+TbmDtYK0v2szTokiZV5QWDCWHPSLw
	 nDVuC46G25V6msnbD9XHqU8NjI8UD7Q73mvQWQ/Ws8i2+fMmD9iLPlIq3N9nzJyMD3kRg
	 4UF4hrw/m4Z2uoIC0rJ1rk6ogz0VHhJImjbVRjDm1MAJqQdZQeyO2xIZ74/iAWJhnf8mP
	 lcsbIHq01jJ3TC5ul2WV4hQYT21wtsoBifkfcoCF/QW/aeT+TyefMAlZM5XaUgIQwrALe
	 tmbnSqZCspumcPv7fxjU6BhL18gLAffNsyccETzE4YtSKHr8u8fgWTk3j5VwvO89OoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iKi+ooUEEFzPsKaNj3gbSBpTK4kkyLR9EfuhA6Vu34k=;
	b=vTmnSQi22+zGcrVOzVxOvo/thTYOT/LqJW/LeFZQXVf3aFNojvsSF/k6UUnbXMlQFWmY
	 vMhL0k+kRmf1BpSkHbQ9cUX/LGFF0hy37jGjclHROQGg3PwSc2qswe6kdgg4FKpnWoQek
	 JmB8O/nFwNDWLbHoUUltYnAORSmJeqGPRnMVpjQdtxgoHTQpb8zUosAdR25FGgrHW1TUJ
	 4o1up5KO39Ylra47DIxCzC4XOLehVyQ2tBegr3u9DtwdbYXaSIvFRFNtMPYEpEWUUBIxr
	 1AAvMP6HHqeW7qDwukmfPFa6ogYMbhsdEMCXct73uw9A7eAHlNSclPt2Osou/og78sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOiJs5xl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45611606A32C
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOiJs5xl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBEB1F000C4;
	Sun, 15 Nov 2026 20:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774765;
	bh=iKi+ooUEEFzPsKaNj3gbSBpTK4kkyLR9EfuhA6Vu34k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOiJs5xl8OT+mAlggdC8SnC2furgHn+gJMujD/nd38gqlKl+vxnMHK4PP+eLmv1rz
	 SlbfHy6NFXOPpFgQXtF/5EbVCOKwJaLAt+FTwPJRfDRaRyYTLqcQGc7NrhWL5CYX/s
	 uUNA25n8LfpjhWCX0hNUTQwFaoHb/7z+8zlU4sNqDb8dpgP7rHi+Iye9oh6O4pWPox
	 /0LdtlxDvqdRV6GM6F7pt8XPjObtLNVWF/B2FS4NvG6/6tlbd4NJt+nDo26UDINvXC
	 Y/yEUedxehY9R9qCktVF02JAAD6WjoZk3w/xlULfrrjGGa1R38nBINIyCoi1UOLE/g
	 xqgTaCXTjEFvg==
Message-ID: <sashiko-outbox-215827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 18/27] Docs/admin-guide/mm/damon/usage: update for
 REPORT_MADE probe filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-19-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-19-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added REPORT_MADE type probe
> filter support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D18

