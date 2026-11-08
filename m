Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168442;
	b=umSHT6R5r2CWkUvRIVCLrkYrA++tz+7NMbJgoVNR//olWA7lcgClZbTnSx/jb1kZsBRx
	 D8v+GI/Rbcoux87lAoLfiV0hei1Zzy0cOkd0eF62N4gq24UDBrGSEzaAOq+10Lv9GDIKU
	 vFYqQ8gFP75RI7JtiKtuoiHzI8+Pwa9gUOK1N7x04jDqfywnu2g7nqwNLeyCG+6uwCe1k
	 hn35e9oX6YRHNNT7Gfbp7kCiQRWo8bifDrj0br4vkv85hZWM8CsE324+W2yB80CA7zo2x
	 KyfDu1iCd4ygFc1b3CwRE/7Hc2xDnM65Bqy93UGE1GlWc46ivOgaDMvJAaFqhyz4e2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JnexiImNzH0LwZiSLs2mNm4Ym4tC9B2T6qJnvzE4gug=;
	b=Ehx+BcSpmmeuiKmkLnuqVOUQB6H7a7QPrHpNzzGoN0Ndpzzrk7H+44Bm99V2BAylwOnr
	 DuewvFxTS5wmQau/EbXaBmLZqXQ1Q+Kfk537Arxpz5UvPHpMmmVhHtetxa3HjOeFILmYU
	 T2ooOPi+bsyf9RCxakjLUaH8EcYjZzj67uF+j/BVPEb6q3hyZ4pl3gqTEnRwOZNRewr2Y
	 GFo1ZVzjwTDLkMMkZrFEkEHNoaogI3MQ4rr3nX1mntBWUYbdcwZawDwYVmN9QcOUytzlv
	 ZuIqzk0YcRZXcD8Y0HaImCDeu7Ob8pzLgSsHRhrJ665Q9JguUwKPvcECkls9KRhX3Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtI7SBsq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B01606A320
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtI7SBsq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744361F0089F;
	Sun,  8 Nov 2026 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168441;
	bh=JnexiImNzH0LwZiSLs2mNm4Ym4tC9B2T6qJnvzE4gug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RtI7SBsquop8doU+a30rEi5WVgWUCoDWJ7lWelkxnHAoC5ngjRy54/bUtJVcU0b0V
	 HApbTTTadibw6G+kS4m0fUBJTPXOl6S225MTD29K4HrwyD53OrhW2OWnjkX5wd/tz+
	 rbouP/p4NjKqyVQoI7kf+jQBU8CWZAAqe4x28OL25xMJ42Oa2EloIhMEG0GZk6aA3E
	 zOOQAvQeBprvlpTf0oZyEFWYx7W0BxtDnsFYrI1b7Ox8U5VzDCMdHoxmhHCG9JDSyX
	 90rO3Q6g4VbDRtVCiq61xcl67yW/YgIKevJ6ByOBN5IIdmWl+g2V7dO3qmRQVVg7Ps
	 xWwhb1axHmL3w==
Message-ID: <sashiko-outbox-204004@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 5/5] mm/damon/core: remove unreachable damos
 charge_{target,addr}_from
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108195145.115792-6-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
 <20261108195145.115792-6-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:07:21 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damos_quota->charge_{target,addr}_from saves the target and region the
> scheme's quota limit is reached.  damos_skip_charged_region() skips the
> target and regions before the point.  The target that was assigned to
> charge_target_from could be dynamically removed from the context by the
> runtime parameters update (aka commit) feature.  In this case,
> damos_skip_charged_region() cannot find if the point is passed or not,
> so the scheme is effectively disabled.
>=20
> Similarly, the user could also remove all the regions of the target
> using the runtime parameters update feature.  It would be uncommon to do
> that, but it is a supported feature.  Because the skip pointer detection
> logic (damos_skip_charged_region()) works for each region of targets,
> this result in the logic is entirely skipped and the scheme is
> effectively disabled again.
>=20
> The user impact is that the DAMOS scheme could suddenly stop working
> under certain uses of the runtime parameters update feature.  It could
> surprise users. No crash or leak happens though.  Users could also
> simply work around by re-installing the scheme.
>=20
> Catch the corner cases in damos_adjust_quota() and reset the pointers.
>=20
> Link: https://lore.kernel.org/20261020023958.108276-1-sj@kernel.org
> Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Closes: https://sashiko.dev/#/bug/linux-cd0c55fc-0cc8-45d8-9637-3334811c4=
9b8
> Cc: <stable@vger.kernel.org> # 5.19.x
> (cherry picked from commit 5695abc4e742b947f586bfb6a080a80ad9957e5d)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108195145.1157=
92-1-sj@kernel.org?part=3D5

