Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640765;
	b=I2Sj3zp+7cP3ZOn7fXx4qKoVKKv3zXS9cMgEzWbWWEfFunaRrtFiR48iDd9DtZLdg9oL
	 MFpgyv28+ASVKFE4CVfBzVnHW+t5sANnjPoc+mccByL64GzEge+yr6ysKZX/k3TxfVfzS
	 xjV8cs9coz2MvZIAG24QitqQW9+y8PpXqfXMivyb4XvAufoq18h9SH+YN7JJeehSrDcKZ
	 Z6AxVL2qZ7a/6McoBO7cA6y2111fdLRacvabKraZwYAwyI+C7Tyh0rqgWvwuAFkVrgqlP
	 Z4DAU06TY1j+j3WV7iUZFoZ5/31QcumB2HU4i6YLF3T5HeoQMm74kcthj+jd4Q6FaHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VWHv/nq4rTHvoYUgB6R3t2xuq2ly46NpVjAmbIsTiFI=;
	b=YDSPKTfwLywgEksgbaFdCKeZqt0gQkjjTvf8dmcW1IfRLhPQj4yWRhLctisYBpDtcfid
	 Dr+HCuQtWeimkMNG73frd9IUvwkLmBkHvltfv6+tK3sE4x0B7YqKHDT6Kk0tv6XCLNiEe
	 2k3ugrAMOuYVI92M5Pjs4bPSy7oBfYWbZwK0ADpV2b6kSvButVhn0Z7/xugfUOAxPQ4hn
	 3fAAUjRFaImMh/0myBP6D9RVcTDlcbSeZDyEs7A+Fbwp/y4RNxE/ykvSsRui3Z0yUUe98
	 05hY5IbL4T9xWy3+w37IUd01uiUCE25vjyUsVp6whLcMK/Uca8xqLCWCDzLYBY3RTLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbl4fDhH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1F606A323;
	Sat, 14 Nov 2026 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gbl4fDhH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD51F000C6;
	Sat, 14 Nov 2026 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640765;
	bh=VWHv/nq4rTHvoYUgB6R3t2xuq2ly46NpVjAmbIsTiFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gbl4fDhHuZ9Cz3kMI6l92p2kBZBc0iCV/wlMvbVjHX08uyuDsx2x7ssu3I4kgCUa9
	 22fQG6aAyPP4NqaaPCFvHGcJ26qGEo6HGMuVCZtH5Gt5qHF47V5NLiha+dSlZDtjPG
	 vT3LE3QKCnGPCS3fHXKxW5PGaYtGTI8zTuAG3al0EKmF/69a3yrwe43p2dyw6VTV/s
	 JNCmkyh1SNhVUZNhXPIJB7hyj0mL1z3KH2pUEl0vdr4pnMw6Upg+lewLmAM00QQBap
	 jo+AehFUJyZzUWS6emIymliPNzzckNpALuECM+3VRiZJM6v1jLeYNHWm5fAJc1Xutd
	 OZOP54qw6eS8A==
Message-ID: <sashiko-outbox-214254@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/22] tty/sysrq: use common memory for the manual OOM
 zonelist
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-17-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-17-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:19:24 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> SysRq-f constructs an OOM request with GFP_KERNEL and supplies a
> zonelist for allocation-constraint checks. The request represents an
> ordinary allocation, whose fallback domain contains common memory rather
> than every node that happens to have memory.
>=20
> Select the zonelist from the first common-memory node instead of the
> first memory node. All memory nodes are common at this point, so
> behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D16

