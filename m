Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931034;
	b=NrCY7Wasg8PSXgStXiyL1GvRtdt1FG/Yp6nD07NEBcehR7FGjcNuBaqc/2y24/G0R1/V
	 jiZs7jVwnXvTGFyBcHI8OAUhPPnIDRyJsRw/RqzfXazJ6lTYXDAzwGClPot+iCjn3EeRt
	 RBScy8HqardSZF0nT19MKC/3ixyAiw8yj3tFAkz7c9busbqdKZ+W1iwpQ8wXVW8ahhG8R
	 RNltLT3+lVv3dD9Pj9kBphieoloqT1euNTBnyZq5nzVR6y8fOqXZCmQLvktA8HsJiBWpR
	 L4o1A1Cd1aGOcAabxjQ3NK9RQTfqMFvhUwAHm7Qjs0AVpU9oAFKHQpefLmixM5CTygw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3VTw4hf+NzXQq19sW1fHj9GKMu/YKQ7oEwQYqEb4Cp4=;
	b=HFMyKbLiVgbYcc5g2lwFImEyk86DZQj/g3pTCT41QxzgseGalh2sCjvAf6qLulhLQCVw
	 WINqHrOv/Gkmsx4Z2U+ftOuZt+9Vkfug3hXnUcgCeYnB+fSJyzzV9oWPH11iCBpIXjkqJ
	 7exxBcD9svf2rYOv5cluJ0RQZN34/3meGNQaWq2qdsWEV1yZ5aKTe0Vd5bJprehcKn/Pn
	 G0wjDXmqy+wGXV+uGvby3WkU+fV7YEGwKQtDPC9HfBwLG5VuZ+P+bmoodidRODGxKPMZ/
	 RpkP5Oww1dz07VH+l2igh4xRvcWwC9xuc3VvSa9E+zcYrCZonyZnDXUudwLM3tNGo8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zx+3TgyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C7606A326
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zx+3TgyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612121F0089F;
	Fri,  6 Nov 2026 02:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931033;
	bh=3VTw4hf+NzXQq19sW1fHj9GKMu/YKQ7oEwQYqEb4Cp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zx+3TgyQ3giph/tGFoixaUza0f/SradjjFMf34oNFbNw5Qex6eXnXZmm6lk2DSO+O
	 hkrdX1TgZ1JslTVYalN2o0HC+g47XaAax+Q9sNZPJLXgMqDKoGIAuWpxlxvRXQQ2OZ
	 Fa4lzCZjmFOmmPOzIqxb1ir/c7Nr0ZNiJN93zyhJVePf0cpzOY3lBKP0Iw8u19JV4D
	 TWiN/C02g1PVzUju7m7uyiwXHeXK5riDHS0+MYQBu9Q+t5HSB4u/2UICuCMdfbbBhv
	 52N35hHHu3lmNt8sInt0mxcIjF1TGSyUtO8CGmLnokmB2V6rjQT94wNGL3ZqwvC+mn
	 7s05R0m6oFIsA==
Message-ID: <sashiko-outbox-200579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] Docs/mm/damon/design: update for age_ms damos core
 filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261106020559.98352-4-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
 <20261106020559.98352-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:10:32 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON design document for the newly added age_ms DAMOS core
> filter type.
>=20
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106020559.9835=
2-1-sj@kernel.org?part=3D3

