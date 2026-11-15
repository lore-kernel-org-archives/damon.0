Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774777;
	b=Ji/69xfyuAhJdi1H1yWfgaeI5SI1nn/JGGNSjdwUZQO5Xxc9O0yKXcMUJHXIq/U6bRXk
	 LmFLQSTDoBpyr1ipQBCgqw3zmMOjmZAi+Co2BR+EwgGRVzhO5FmbIK72nrf8THlPtS0Hn
	 ns6O9ZHq0KXIzxONgSJPjBvlbO9d4WV8zUiGveg5V70HyBtAN0chmnFnWyLKY2ONdnEoN
	 jfR5oeO8Jec+QtVzyHY/hgcXdHZqcPj05T9sxeYoEmhasx7KTlCZ8PU8vHzJASOCcqTcF
	 SUTHXDJ5PXSPvr0eNRc/4he0WPGPIA2TA4sUA/XykCgKAMnquUq0e+TOe/bkW0ROe2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QNmFiEk7XvFHc2uYnB7ua9e4mwC/RpUHyNmBUv52OlU=;
	b=LQcGOmvfNDrJyul0Cv/fzk6oIsDhkNIQG/vW9jWSHGvvj/TH28h0IzOOM9ai+Ww79EUR
	 GvPS8sQ/fM0Jkh6p9nPHIQYFWrhpCjbUc9K7SDqArel+Yw6rOevn9iGyTU6oTjtnlUplD
	 KB1xbRzI1SwdR39Lp7Bz5mky75G3J4PAZR2ZuCtumPSjHXDBgZs7avClXJn9zdQHo8yO4
	 K1xiUIBKmXL1p707HJMz/ho9Obo/X/aY6mY4wPHtoqjXmvrX+G6cN31yl4UCUZeKTqdCH
	 syemIK9rVOY/ofPiVX9RpS9v90QnyZ9QdBMlzPSPJJZoXoTH89W+YQN08VMqQzoC68g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL5sxvw9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0F606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mL5sxvw9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEB71F000C6;
	Sun, 15 Nov 2026 20:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774777;
	bh=QNmFiEk7XvFHc2uYnB7ua9e4mwC/RpUHyNmBUv52OlU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mL5sxvw9n+BPYKb9kZZvHZa2E3HXKWiTftYsCmzvV5P4I930NBBQdvowFsoA1rVWk
	 rmYJDjfiyvxCdIR5qmAaiTOFTEYxAMDmPdkLUP2ggsnsp0asxTBGj3XhzRWFLVoDra
	 nF40o46/ir+HlGWXZBYLE5DG5VqMaX+5HEbvrvdr0j0XNBXUQNx94Kz0gE6vbfyFXe
	 IA+kQYg5bEPVnG0RT/LOkvzV8/lzRy77HoSLw3pGW7edGSNxS4LHfuDnrpUIoWfkM+
	 8NP5kmMtTFGDIkxFqK6P7GPx7KADwAFVCj1mi77z+wgTdnizSErH9kd7mp1FkNMiAf
	 BDNKAeq/G9bng==
Message-ID: <sashiko-outbox-215830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 19/27] Docs/ABI/damon: update for REPORT_MADE probe
 filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-20-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-20-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:32:56 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON ABI document for the newly added REPORT_MADE type probe
> filter support.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D19

