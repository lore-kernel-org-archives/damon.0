Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167935;
	b=I9/AXfcVj+3NhyvnSZNKyeOHM1169RkzpB31Cj7v8FXvqzB98Tj7E6yWxDg0xov5ghvV
	 gsTVsCA19PyQsT6GqNPOh/6jpCIjc6ldAngGvxulzxM+toaU+tLfmFDriwXPUbpE22xL8
	 wiBZPKAl4IWbgJ3rXlh3K1Wxyb2dVECZaS7zD+4k8/KFyWg/XgcOudp3g+750WgdTcpLw
	 oF0aIIbiDuIfK74Mg/yze1r6x60YmAWRCAObiciu1btuR55PiPeVoudydZspCU7LPP/xe
	 lsaFfMFPYE+id1+Ihr1GAjZY8m8G+YnWEPcIfbjQJXjlA4vhGpmBVZS2ow8erff6bxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167935;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OHdC0GgEhyrosirHNB/j9T8So70Qs+7SiSlEMgyb4uI=;
	b=X3g5lVOagBdtWfBhZw0p4opt84J3fVH0n4zy6GZ19c3okoavnJN3LiQULJdRCM8vgPbQ
	 ASYrIahwUWjBhmzuw8klR2x8KdheuqC2u7m3F5oK4etPn1KG7q4qlf23EqTzTeWvsr01S
	 vrR3fkc2qh8k0XlKEPiwvkWZe0gShnMCLLpgkzUtxEpCgN1ogSQZxLjXLV/5wSl27QGIb
	 YsJLNvJ2xWyIyRz4WwfVLo/eEi/aIdQ4G2fXrBDRuMOMPjjKB0CdD2C5BHRSP7rYqkFXM
	 GlVfyMbOjnFo+9dfFUfomSzOzITVCL/2QeCGPs8Cz7/Cg1xK2GBU67ydkl8jVx7Dz8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fG38dylr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59578606A31C
	for <damon@lists.linux.dev>; Sun,  8 Nov 2026 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fG38dylr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D208B1F0089F;
	Sun,  8 Nov 2026 19:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167935;
	bh=OHdC0GgEhyrosirHNB/j9T8So70Qs+7SiSlEMgyb4uI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fG38dylr9Hy1btz5PvAxrRAt/orWcJxUM2voNaet6bOKkGuuuOTUBnMBgArAckq8U
	 tTeF98Jrcfa+2HS05hjKOQNrbdTQPfiW2i+sU1DiLaNMl1qbixrVsxq2HBvqFDE9BR
	 ///7R0lL+dn7iXebZywDkgSgniNr3BQaGSZOkpdgL+Bu9fUVFQt+IUFz5R0w7az1nP
	 /VUyesUkBgR5+VWHEc3QR93MPx6EaNUqA/M/AOZRugGXMCZmQRJGoSkHJIdXB1P5Zm
	 nnfXfM9o6ufbENK8B3iXmmAnoJwreDaSqPBctV/VSdZHfDZhLn+TCIbxpFLwaIZU3c
	 uqZzfndzwXu6Q==
Message-ID: <sashiko-outbox-203999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.12.y 4/5] mm/damon/core: filter out damos address
 filter-split failed region
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261108195145.115792-5-sj@kernel.org>
References: <20261108195145.115792-1-sj@kernel.org>
 <20261108195145.115792-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:58:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> When an address type DAMOS filter is configured, DAMOS tries to split the
> region for the filter range, and apply DAMOS action to the filter-in
> region.  The split operation (damon_split_region_at()) could fail from
> allocation failure under extreme memory pressure.  In the case, DAMOS
> action could be applied more or less than expected, ignoring the address
> filter.
>=20
> The issue only rarely happens under extreme memory pressure.  No crash or
> leak happens.  Occasionally not applying the action to a few regions
> shouldn't be a real problem.  But applying the action to a region that the
> user has excluded via address filter could be a surprise depending on the
> use case.  It is only theoretical.  No such real case is found yet.
>=20
> Filter out the entire region if the split is failed.  Update
> damos_filter_match() signature to receive the error from split.  Also
> update kunit tests for the updated signature.
>=20
> The issue was discovered [1] by sashiko.
>=20
> Link: https://lore.kernel.org/20261020004119.106690-1-sj@kernel.org
> Link: https://lore.kernel.org/20260801203121.117449-1-sj@kernel.org [1]
> Fixes: ab9bda001b68 ("mm/damon/core: introduce address range type damos f=
ilter")
> Signed-off-by: SJ Park <sj@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org> # 6.6.x
> (cherry picked from commit bbeec2d8324d7aac438bb12dd2d22b184e0a8d43)
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108195145.1157=
92-1-sj@kernel.org?part=3D4

