Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667704;
	b=Jc5BKjd6BsTGQTa0j759Io1yGnwnVBM/3F1AXigG9+ZKoyguFt4/lkPdseSq0rLGJiXN
	 xBsqN0TlV1DtPlEbznw9bfPBAlGHoKjaH9JKvh1LQLXQ31MR9CuHrjpFl1hfAU8fK1C4d
	 to7y8Mn9Hlm2kZgob93vDU/2jUQX6ajmksl+IQWQWLQBfayPNqsaHmysm8+1c3MXtWjJS
	 3O8TCOdwQH97OOqdZlFsQS5d9zr13yabMk//c6nD+347qVAtWvCLXzjTY9g9Ijw+PnFWW
	 QOevEuzmD7h4h9EMcrMeStOzsJaJ071isob+EAH0iT+wrzayfkVR29tV8B5Z6o+hkPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HWpXJ4j0KF5pspc7k3d5PXXfrRuc9RLG54wH4mCUbDc=;
	b=fjPehQA6ZK+oqfExy7HHBD/2NUyW50W4ZfAumBXmAWe8TZG/QqlFl7U+gt/GYikKjrk9
	 iExXbafUpdA3XPrpQ6ZffocI9+SGDJZ0mTbid621UhcadIUoAB/jArtYcvBWU73ZrJKvh
	 qsLUXYtvg0V53Tg2dOS6qsqI+Gt3G2HVx0e9uzDlOQZeAl3yBKXLvu6WLyL6dre0vsRSh
	 z9eZ99f1Wq7P+2Va/i+iNYHj8v5WMxhIsz8BZEy1Qci1mg75lz4lHboRFrFbBnk4W2/vx
	 X89C2xfvTvvykG9Gh8pd3e7MIJgmVLmirs977Z3YcIebwk/8st63pOraos9crs+DORA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gazaSlGj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BF606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gazaSlGj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8881F000C1;
	Tue,  3 Nov 2026 01:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667704;
	bh=HWpXJ4j0KF5pspc7k3d5PXXfrRuc9RLG54wH4mCUbDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gazaSlGj+99y7vw6VBAJ/aYeX1WFpwDMfpHTEmUeaDzL0KejaD0BJmZOmIMGiRlwD
	 7hAiNafltRKkefEbslmMwkyuTyyFPXyVI5+5uJDMVI9TJW2i6K9C2+sr8nl9DOpH1O
	 q2M384s/Hcvdo62X/HLfjVoPOd0nwYMCSrFtwZpAengVT3cnNc7SdbZnXm0QTTOQVH
	 jge7qcL8tr2X7HoCG7UOHN83UeGhlrDmwBfK8ZgfZLfVXHdrZSInvgZZg0QFmcn2fw
	 +mJ3bmlUXegIu0qdeXIsaukhJY+6uLAD6XH3/QViBpKUjQ3h4gMmml/19ICXrALfM/
	 1lYvv4zi1snKQ==
Message-ID: <sashiko-outbox-194413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] Docs/mm/damon/design: fix grammar and typos
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-6-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:42 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> The design doc has quite a few relative clauses that seem to have lost
> their verb, like "pages that assumed to have" or "filters that handled
> by the core layer".  Fix those, along with some agreement issues and a
> couple of typos: "Parreto", and "Use space", which I think should be
> "User space".  Rewrap where the lines got too long.
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D5

