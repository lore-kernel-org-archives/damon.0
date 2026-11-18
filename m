Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968976;
	b=cERU12PoQ1hxTg94oIhMWkfd9cOR/S5FtMbBOw1IRiaJwU/O60my1A419fIbWEl6WxOX
	 gpfXqwIj5yM2lI5gYmCXZAWXzGgLPXb3ciR/YzqYaqv2x3gbsh1XSGcaSilcR+5NNMQAF
	 HJHAXSIiHalA8TtSslVagpkilcndzTWzOb0h3R2sbncPDl1xleIGjLpJGvTjCWxca4VlC
	 MgbX6IiL2Nrnjh1BaXI7PXVmCXg6XWuh9T5zjAGKk1sDhCusjNVA+Sr7BmT9vlfzmFzJq
	 8m3NOQjX+puZu2s3X47PE3S3xLfJqmbUJQf+ARoiixjEuFFf7pm7k1EfpAYyxpRNdnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968976;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xSjTqjEPwM4Dwo7JQjjuzJRp3BsURlOkow92szKx4+g=;
	b=OscWFq2LGlRNc1k/S26GPG16sJ1fAjzSBjvNONX3GLDqPhaVe0jUqmTDRXYTme0YnSnT
	 Z6xr5VkfuCfftZyDfy05pJBXYy53Xcfbx6h74FjxCuEDIuNgo8Pg2npgPCnTkJsfkns9r
	 Cxog9aSoB/fGcPnLCnR+FcRUc59jLC4ndPYCtkCBjstuwgv4F3RjnL05crafEXCric4dG
	 sMqKh+6GpVjKcplHIlfIT9BqIh0dMpMVFGSM2Kb1AZ0w4pEgLnsWIyfTNerW5SEqvGY6k
	 dJQDiLiuybC/kuXZNcd1yrX9A732648EcSDQDHYPzpvcL1zg2gdvcPJe5+rpdIOUePg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFmeXj45;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED3606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YFmeXj45
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56E81F000C4;
	Wed, 18 Nov 2026 02:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968976;
	bh=xSjTqjEPwM4Dwo7JQjjuzJRp3BsURlOkow92szKx4+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YFmeXj457zTmIh+0SIoNVcYusGKs6kZLkDQPf3XpKhndWTUcwqvuDsD0odzpdV909
	 UgUzamkNuZ56XyMkGPBrcTfPbfzUnbYkbKhV/DSFMRC7HtmHchd4LuX+lPYDIDtNac
	 6kinf1hOAgBMPrSGXk0uCUFCfTrHOxacHrk7BopSDsbQbgC3Bj4UTKaLlz2VV7Ri9l
	 N6JEoktQPKRV+4CsZCBN7Qu+J9bdXVMY1ssPl3ZxGNfUkxO4KiiMnhrQ6LJ5BJRZDN
	 bQToDlWg+pUD7elQiptgTZ1sqVUZuYd2ygtuBb3nSauzJsaMYjjBxTxKJSAfGqTO2o
	 F2ZD/CVEcfkHw==
Message-ID: <sashiko-outbox-219960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 27/27] Docs/ABI/damon: update for user_report
 report support
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-28-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-28-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:29:35 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON ABI document for the newly added user_report type data
> attribute report support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D27

