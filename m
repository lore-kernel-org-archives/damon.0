Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012431;
	b=mJFDdj3Zgnsv7oCQBUmoyMMDJq8Thou6Q3Ze5In91w2pEMyaxegyT9MoJXMYpvB1pEZC
	 iyOP+W5ixWDV+Dy/hyqUERu8N1apbLaNaVFbd8V4VJvQF2XBD/UMIpBdc7YAekdxvTH8N
	 4vfVrFqKXxXqOGIPrmnlZaOswxhAW4tvfnZBlNGlv/vgirHfBhEioZGls0NI897df/WSc
	 N9ODP75WbqJR7zn/IBWDZLfZN68VPYXFnDZWwR9SAYb7+WOMRLAMUYn7pi9BrRZ5Ji7wH
	 fltxCqMkWaObqQCybW6C9BALJ9SJJkpoa1AGDpXtVYpr8sP5GmJBsmeeW5ChV8vDrpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012431;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jxIOGfiXduyXJd2NWZIvOF6cgXGn8xtg2R6LE8Zvbe8=;
	b=dfXDhTFOSAwQb63g2yqP5czE4f4YE697+9s4N8HW66hAcUzhI+u1sOO9AamS5eiW7BmY
	 gHxUcXOAmWsG2oYZmPxJGkdK8SDn0m7pZzbFpyYkNONyb+wt+UoigIWyFotyi4emArohf
	 w6Am/epPmDTmE91zfcjUYRO4hQbZBgQpkciZ8V4UaWEhlCB834iLgaGhw1NEmTKkG2PRe
	 PKQoNr/W9QCKWwTGzpPnP7YOV5pvSaLoH9U62FIZMrmvcdlstPM5IKyt0vLPeGwZErbhH
	 xQ2erAlUsisP5eBTL2dAvPnt5KwTfyXtVlT5zcRDrHW+nmzBBuuskIVOPc5zU17m+zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7Eh26YN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE97606A31A
	for <damon@lists.linux.dev>; Mon, 26 Oct 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7Eh26YN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F81F01825;
	Mon, 26 Oct 2026 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012430;
	bh=jxIOGfiXduyXJd2NWZIvOF6cgXGn8xtg2R6LE8Zvbe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7Eh26YNtM5c+ru/pao2cTwQ3XITbaGcM2SnUwzDbJor10ZcyJvj7mxq5y8sJ/+/w
	 m8eIs1MVsdMwqvBLiG22alDV4NbiKUiP/PtWroOeBQc8vIGFNAMaDQWLZjVXKWpBgJ
	 ejPA8I9Rx7DkidkNX6NP8Zrr2zSZknTVnLp3PfsJQ6B9lm44ZYJ6aaJOd2QgCssX5m
	 dAgWGEHkR6wKHeP7i/OgbCfgMPTtjrnu6Wz0vdw8wLU8ijd0NzcFCfllZAuVI3MfSZ
	 wrdNxm/zfuW6CqOj+cy4xCoeWglszxd8Ixe7UOmmW/9A6PlvdimRuRrxDa6Ll7YaeY
	 MDNL3q/WqWmSw==
Message-ID: <sashiko-outbox-185037@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] mm: remove unused folio refcount helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivank Garg" <shivankg@amd.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261026-unused-sym-v1-2-82ca2dceabe1@amd.com>
References: <20261026-unused-sym-v1-0-82ca2dceabe1@amd.com>
 <20261026-unused-sym-v1-2-82ca2dceabe1@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:00:30 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> folio_ref_sub_return(), folio_ref_inc_return(), folio_ref_dec_and_test()
> and folio_ref_dec_return() have no callers.  The last
> folio_ref_sub_return() user was removed in commit 38607c62b34b
> ("fs/dax: properly refcount fs dax pages").
>=20
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-unused-sym=
-v1-0-82ca2dceabe1@amd.com?part=3D2

