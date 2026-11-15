Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774894;
	b=jqc7tJmU3cm29wuYVrQYpwGjSjWoaBWi2OQvMgBeAm3PDDVTvqIdMN/rF+tFUiX3ou9b
	 yZNF0etTqx34tZSl8MjRBeTo0cYsxvtO18Q2qp/0h9X/IVEJPJPeiTfjhQ9MNgnSZKPZp
	 +h6D1o7ej9Hk3s6HbnFunrjUWn6JOAR25gEhfZfaEx7mwqrLZEXvsR8+BNoSvO3qaeAaW
	 3dfVXpIZDjdOom3ECXLZFHk4IdzgjadXHFh/IQ0jDsL4bx9Fa2cjVw2d4qz/nLxx3Bsjr
	 ot6XPSxv0axMbHarGq2+KR4rA7EohEDO1tz6tfd+0oScd+ABTC/UROHkIpPZ4erbAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zVK7Cmzz49x5F30/YP8YpfctJHiWttu/OMSlcTNnOY0=;
	b=3AZVSDzWVgohNQ5DyDq9wIL35ryDPwEMlia3n/YwcbztFYpr8N7wuDZrTq+0GYiEBSlX
	 suCueFA1e/3e1FNZv/sv34kT8nSNoqU2aR1vT40+ONFp+LNKt9b/8GfthT0d2ZCeSAPVJ
	 oV0TYD9aco+5XSDJ6lc9zvfHUf0TjDKBK+UwCp/owvLfCQw3AxwCuhzVbPdlegCspXru+
	 MJip618ZeubSE62wf3ds4/bbgzgCosuUG4PzDpSh5TTYByNCOwhsKd2yxQ58W6yGC0Wru
	 f9rqxgecREtvmvRFutN8stMtieo3SapN1XiPRGIWOiuT3z005qt+zAlIMKP2XjO4+LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nzwv9TKJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59997606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nzwv9TKJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109321F000C6;
	Sun, 15 Nov 2026 20:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774894;
	bh=zVK7Cmzz49x5F30/YP8YpfctJHiWttu/OMSlcTNnOY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nzwv9TKJyDvWIX6PHEJsmKYmVl1ak+MU24UKuFP/2Bcwc+2qqLlovQKFEhOFZp6yX
	 RYIUh7J5Qkehm+YcmYj3E8suQr0u6JSxMDNrOiSl5Zz6kOqFOtKpt+rVw+4LiuY5WP
	 KKxhY0bt3QDakfWK+ld/XyEgCyPOE+azYnyTHD4ozaHxUvvSpH81xiVnF5yr8YFqzE
	 eKXM9jNrvPfQCVcQoN3Y1DvaYBit34qbJAPNR23VDoAGdWU5bsnF7Sg5ho/lyhnSsz
	 719z/uMMkCBmr8gq+lTeojsSrP2OLv6n2dbUgB+JWQqtx69Ig5ldOxg3p0rdY3dcqG
	 XJqExKKTtOo0Q==
Message-ID: <sashiko-outbox-215841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 26/27] Docs/admin-guide/mm/damon/usage: update for
 user_report report support
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-27-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-27-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:34:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added user_report type data
> attribute report support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D26

