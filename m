Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795036270;
	b=Hc/n8/bcTSlv19c7+4n/eJc8UBhOaA3VFIrh8wQh2bJvLhu5cBPAVJXivscbdyltbJ0T
	 PLhJA0ip6HtprO82cfKo5rTVkoAS6UmbY7y+ZYYjdn+msLoj2dcnPQSbavi4mD3Id1f2t
	 9dx0C4AyShb1WbCfEXD0BXDBrWlFbWhATh1Gzb7t8xutc3wQf5TttsEnNqoRPaZhdHJax
	 LL5ww9HN3uUc6qNPm6OWVl1m1JAWVLRXxVyCJ3bP2UO2eWiSS7Cp4jrBixFFY2FM1pgbq
	 rM6FwRyRqGvfMzmFPA2Af5LtjQXTk4GRd66xIL1cve6bzETChLwByVYema408b4uVQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795036270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o1eiApLpfZtnq2HBoPPJ1yx7+Ug+HMj/bP4DgHZm+YA=;
	b=fb9jE2V74eGPjR3kKujYjZHE9o+pn0hykXrbQNF7kE2i0HiBIEzMufZ+x1tcwXY4nB24
	 bBrA+xOditauvO8U0D7hnjrhk+95FoGRJOCOSFR4r53a7OV5VXkJQ1jOmmmZCzOGRUAT/
	 fbAyK4MxKS9CA7bwJxpOyWMe8Y+YQcOZl+/LbPjG8JmkrMwvaJTX/jf5nKHxX0/u2Jbv2
	 yUkRLYv1rpL6nXzTHjbBFzPkEexKp+7Yz7MFkxGRZvEvW87FPI+7os/mjEQaBrSELvGWf
	 HcKVtpe5sPh7JRJ6+0s1UChXHKF16ip8HFLKwv7yJBYxwID3Q3Z+d6Hi4t4IycgQHFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEl9Oxqg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9F1606A320
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 21:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEl9Oxqg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40561F000C5;
	Wed, 18 Nov 2026 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795036269;
	bh=o1eiApLpfZtnq2HBoPPJ1yx7+Ug+HMj/bP4DgHZm+YA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DEl9Oxqg5/iY6uHoTyt1ck7WTv1+oTG9XCbsc/Fwwa1PXYaDu8QJsSXAnDgRSUpZj
	 WwEbiHuKUjfuAUzm9dpTAXAFpdjrtZQs4RqlagYj6OW3Ay4diqIWkV1uhibaFT+mTB
	 ecDskjNAW4UBcMlEgKvFzfSak+0u+/J9GiJNhj2L61rC++lE5BjMwGNqXoCfSVg/yh
	 E/VWhEYI9G6Pf0dpE7/eUQXfdZQ58DGaCIm6CB+IVBcam8+yKleZV3enePCDyCG/WV
	 YQnb435UF87xmmgnJKkxQoF2pLcw1aH6j4xRgh2omYtAKn5GuNb4SPscjZI7u8SrsE
	 HdA6N2YhdxSNw==
Message-ID: <sashiko-outbox-221976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] mm/mglru: make folio lru referenced times
 count a generic API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kairui Song" <kasong@tencent.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261119-mglru-fg-v5-7-9eee2fe97a2d@tencent.com>
References: <20261119-mglru-fg-v5-0-9eee2fe97a2d@tencent.com>
 <20261119-mglru-fg-v5-7-9eee2fe97a2d@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:11:09 +0000
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
> Pure code shuffle, no behavior change.
>=20
> Make the folio LRU refs helpers available regardless of CONFIG_LRU_GEN.
> Without MGLRU the extra bits are never set, so they are inert. Move the
> lru_gen_* helpers into the CONFIG_LRU_GEN section.  This prepares for
> unifying the API for checking folio referenced and workingset status.
>=20
> folio_migrate_lru_refs() now migrates the complete refs count,
> including PG_workingset (bit 1 of the encoding), bitwise identical to
> the direct copy dropped from folio_migrate_flags().
>=20
> lru_set_refs_flags() skips the nonexistent mask bits when
> LRU_REFS_WIDTH collapses to 0, preserving the two independent flags for
> !CONFIG_LRU_GEN builds.
>=20
> Tested-by: Zhao Zhenzhuo <zhaozhengzhuo@uniontech.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-mglru-fg-v=
5-0-9eee2fe97a2d@tencent.com?part=3D7

