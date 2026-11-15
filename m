Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774684;
	b=RNBncThj/uX14fnoUca+3JPvq8w6snQ7x4zdef8d6lsjl+i206VFgT7S9I+XB7VCwh9+
	 q0tIZQWqvH9kjkHStFKzWuvEhNiczml/OhOBpNvXBE98tbEcrVRoyww5iqVEfFvjf6r6W
	 mfUsWNML2A+SJL9v0q1Q4fM0qo+zdQirrA4Z+iyQes5aj/hgmzkrUE6vYxRnrOQcdI7gi
	 HnghMy9kmQbygFOuLQIZY0Fmx/i60g4VOPIXzG0ks9mV8CfB3O4Tj1h9JleIfs+3fvXiO
	 UKIlnuaXa0viwKKVYONrKLiPYzEv/kMiQ2z6pNf+WkPl0fhvMJIJo4O3p1cB456Tntg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774684;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k99PzsEljm9Pn+S/bAvEFMC9AXuNPs5YnvAGObBHIt4=;
	b=ec5eFr6cN+emB11Gi1ya2nJ6wTSgp/Pq/v+fWtTAC6Artm5xUC9WkdWsW+UoaPeZJXn/
	 SYZeXIUZCHqBNmQnEM6+pU0FG0R+5MyjFeQ4jsmjvXYq1wMdjJYMKQCgW8o3G6LW5k07S
	 ewaOq5WaLz8viDAhK+Suv9K8vDyIaGH5kq78CsJ3OGs0VnB2TIu6bSmSl9/MXal+H4xf7
	 OECNoRUrIberqpTjkdccLfsShNhsC3TJKzccf1cwl4WAzC7fXOFSUL56eFDPouH/Wz1l0
	 pA701pFBMf4li4K/WFrVS9CFo0fyVggFBIWQaNcmnA8Mx8DWABgZKqgKT5jb3pc79Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aKscN/H6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A01606A323
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKscN/H6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EC21F000C4;
	Sun, 15 Nov 2026 20:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774684;
	bh=k99PzsEljm9Pn+S/bAvEFMC9AXuNPs5YnvAGObBHIt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKscN/H60uPGUogPhCbpNUCkGlnCH8NDfjeW4w1ciD92ZkRudU24Qlac1hn+G/Tzb
	 nMcXjvoGhfyO7u+v+T3W1JBUpYUnrByYFxXTwdOGrhX2b7ql7IRpePj+s4FEaYRM79
	 QmdA1fjPaHm3O2uZYjZVAmfBfN5LRjr1NbAPbWc/Etqrs0t35G75+wMYbCIshuThUp
	 Euw4bG4y+CpZfOqn6ekN0o+o0jTO5zmBrse8biQUiOOrnne/qdWleP+jwa1Zg40RyX
	 iHmb4h13WSnEoFWmpEtQ9jM4yV5ro3KGVjC9wnVTBnFwiw37+ZR0NHIN4htFYotQXl
	 dfh1B/UCF49iw==
Message-ID: <sashiko-outbox-215819@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 11/27] Docs/ABI/damon: update for report producer
 sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-12-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-12-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:31:23 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON ABI document for the newly added data attribute report
> producer control sysfs files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D11

