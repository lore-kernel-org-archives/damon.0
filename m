Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199051;
	b=hbG8p9KqBba7JpfHZxyN6OMT5wESbKWbO9CwcUW99AkRQWd8vJqRyYlfXhhGpYjPhHqy
	 Xstn4mfs19ZNQi0mJf+dP5fOTMTXEM5gQWmGDXKrH7PkemTc3KxgXTBilg3EncLZg2a6X
	 wceufZ/xzQOBEwiQ9BlTA0cR4geAGudVE6tAfbl0/7+vLhX9Ef0hPNVgTMeB+yt+AuqeT
	 qNDwbGID4Teu8mF7Dc6B+/QOZffRWVaINe9RSOEdV9bG0V83ivOtMBYPCcSC5bY+XLGyw
	 9j/x59iHSIBHs05m+rFRUEQNbr0wkbcatlfNQ4WrhxZfDFst91sC9IyvGkounDQT3vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199051;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8nemoiFvfTjUZg0dXud4B9yQX/RzGrTPRGN9ENt2lD4=;
	b=M3y1Bbh48c9bkJNY2YQB9iP8MB3a5WInincbrPVH0GGZ+mRK/3zfZdD/4SN+wKwbyQMZ
	 O/gvz4HAI+yEFK2uWn7xqpXPk0o5je7pZaVeLv2hEWyctjhJdP9ED3TnKBc4aV2Gqhi00
	 xeLHMwHgLPWLu38DTxcUe1RXLnp5K5EZLwcw40n3GWySFbEkgyObDS2jk26NkFy66XgFb
	 nTyQV5mQf+B8qoyMIbuONaNnRT4UPbxrESh1zjroIf/rgf26Sf9+cxQzo2SQgajdoXnbI
	 k1HK3W5hl/h1BN5Y3TlUqD22GpPA04SLHxvgQsZyYm5oO0V5u3iMxcOpZol/7Yj59OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7P7WKZc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709D606A32A
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7P7WKZc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6670E1F000C0;
	Fri, 20 Nov 2026 18:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199050;
	bh=8nemoiFvfTjUZg0dXud4B9yQX/RzGrTPRGN9ENt2lD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L7P7WKZcNKU/hVRFJ4nSRmmPYo/RXQdnxuRmOyykRWGeNbyNEm3t7JPbuqL9E4wLr
	 UAESRz3Mod7OQs1k7ZHRuS8b9wtX29gWtVzunlL0jxwncokI1nyH0juWs5KZ7xh+cR
	 ulE9+dvwkr1N2Wm2SekUbBClmJXy4o5WEYBD6X6rgzGcxIYsui4duyJaLj4xTTl1co
	 7QoLRzHVET2t3wvQp9iDAXHi2f/e4TLnMABkrsl+mQFY4gvDQExCMeBG9EOHjcUmm+
	 /ZDBkXcFZNmfoEBFV31tIxkweZ0U/ZNVh3PWSyJkvAcXF/wE53I/uMU29TABEhA4lJ
	 VhG96v9cXqwjQ==
Message-ID: <sashiko-outbox-225817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 33/60] cgroup/cpuset: ignore private nodes when matching
 OOM victims
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-33-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-33-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:24:10 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> The OOM killer only considers a task an eligible victim if its
> mems_allowed intersects the allocating task's mems_allowed. The
> assumption is that a shared node means shared ordinary memory.
>=20
> Private nodes break that assumption. If two cpusets partition common
> memory but both allow a private node, an OOM in one could kill tasks in
> the other and free nothing the allocating task can use.
>=20
> Initially, private memory allocations will never invoke the OOM killer,
> so only common memory pressure reaches this check.
>=20
> Leave private nodes out of the intersection.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D33

