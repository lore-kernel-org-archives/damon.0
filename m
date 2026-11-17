Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908862;
	b=3AR94sPcCN/NsDdgRbFgCCLaK0YEx6sN/PN+K7G1sK+4Wt3NYkKYJGhaS/Bo6Im2bv74
	 9WOZqMEKSn3TtQ29zDLLDQGyXizxzkz8y3l0N3Izfa08P0o5wZY1F43disF9W+t9jijvN
	 3i73w3MNE19Qf79N1kczILuuKSzvSLrOHBihfL0sOKb4gZCATYonhQu1INBdm34iibJVx
	 Dt11bC4qk6KVFIip7uEOSsX81xD5uPQKysxN36fjasN2accrV96tbiHpJ2wM5hkktfpNF
	 vxwL6OAJjfVGok3O+0WnbIov2fv3zSYbjptqZTa3yT5PLVcOjghqHrpx9N/EDB0DtNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NcwtjDiSe4N5qL4C4JQ3nE17grk1E2z98d2tavO0V9o=;
	b=05p/TqpC2nGygDMVQHXHTYrpckL4ShSW7HlBwvHqa4h+RLlnD8H85RltpaF72Lm1SoQ4
	 d4gZSe1EB26hGfZ5jiwicpCyklGYBJxsu/mokB4IoStMLyktdXdksaU2XJVsWWIpP6xmN
	 WnSp5u1MAy0uzYh3DGxjkg1y1li07QbypdP+CFQqQd03qiP2S2VGuri3OIOFo+pUFrQfr
	 0WvWi6tdatxsqrhTHvxEsACyirufVntnfdOzffQG2Yb5R2sSzHuKSFdzaHk0kX+9m9Vo5
	 jx6VvocujLuOqa5Yxg6mcf75WAzYFwxrlu/s+NVMSRhLLgSEwSoU4gYSEduTVTUVEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMJcIzSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33838606A323
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MMJcIzSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC57A1F000CC;
	Tue, 17 Nov 2026 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794908862;
	bh=NcwtjDiSe4N5qL4C4JQ3nE17grk1E2z98d2tavO0V9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MMJcIzSBC2UPr9kcl9l/a4jKS3Sh8pShWeM6abR3IfczsAME+dY0wHQ150px/g/QU
	 MjDGLIwEYW1SfnyohqN/jqw34qEhezwbZJzTweQCsx457wkghLX4TbcPtJPA4sZ2K/
	 SYwaTmY22pJSUuGy7R2w03Q7o1pHsv3/jjuGZ32xl7/aP2hUOVjeRPsxmdE2JZPktS
	 72IOaEbvVASZW7kxSPF0NtzofAt2X0seiBSGN5JPVPHHYA9u40IHsf1Tf9jonwsmR6
	 ILMS6KcYgq0bwJcAU2O5RRVNz4uIMfjhKne95DxN+ibqizMHQnJ1B9leJcXq0go1fT
	 zQsKaLDnguECg==
Message-ID: <sashiko-outbox-218523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle time
 milliseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Carlier" <devnexen@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117094339.30978-1-devnexen@gmail.com>
References: <20261117094339.30978-1-devnexen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 09:47:41 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> On 32-bit, the region idle time in microseconds is computed in a long
> before the division to milliseconds. It wraps once a region has been
> idle for about 36 minutes regardless of the intervals, so the cold end
> of memory_idle_ms_percentiles reports wrong values with flipped signs.
>=20
> Do the multiplication in 64 bits and divide with div_s64() so the sign
> of recently accessed regions is kept.
>=20
> Fixes: e5d2585d9e85 ("mm/damon/stat: calculate and expose idle time perce=
ntiles")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117094339.3097=
8-1-devnexen@gmail.com?part=3D1

