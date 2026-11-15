Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774705;
	b=l4hQcqLf1vCLh1iolqI1U3POUpFCUbty45LHtk7DF/YBThH8nm8dCNSR9aPfXh+rX5ct
	 lbGuKDdb3hlQqiw9+TMDaiauVsvvmxRlinm9sMkmUPh05fMNG7XGslpZ+NrWiC8y4Xkd4
	 Me8e3J4rS51/gTbKztW5T8yZb5+RolpNysESEj8v2Xd2EbUGlooMAEqX64u+jB7cJG9Sa
	 b2HehmqBuo8XbpigZndus6xVOETktvGm6qcmeyTcX0eEqhFTfJKbQJ+onJ0gQ0P526olw
	 mPuAjUBU7xGyzev3YZ7T+8REcqFwdog1adfpodL7XkG8QS9/AbmxNoahuKrPnJ1nUHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774705;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6pFAWW8//JWj/nJZs5Nly9Xt/HaPupscPA5gX/ye62U=;
	b=DL9/5UMDzGmJtmcHBXdLkzNZbNp+m7cifukqQ0fhh/ImxaypllbdE/u8snqcrpastCsu
	 Ino+iMV0//2ali1ubvovDq+v/E6aDvN1YtamF8PQHHfBpbUPc0EA5Dwlze9GFt6DkBwms
	 6bxp3IjqJzXEa+6ZR63FfXGr+90uOGR/cGYzsOu18vLsCy+7bNnsw4Q/a2tIqfQc+l861
	 BZyN+OZmSgPKwtyIaQ+Xue8ZjsaUxUGPbRiq60o1gibbn0n8tB6YgzRsqMkJW24DwjMQo
	 bFPeCTOPbx5e5FJhHGS/ue9CNagaXqwyhEMMFQkNGOE5Zjm/vIQUJuS+ljQuXLMKqbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gw5Do+BH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14D606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gw5Do+BH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93E61F000C4;
	Sun, 15 Nov 2026 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774704;
	bh=6pFAWW8//JWj/nJZs5Nly9Xt/HaPupscPA5gX/ye62U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gw5Do+BH89TdV+fCNPOju7akBynRbEFnROGfF4Xa3+9yzlHOZ/+ML6yrvcj6UiMbH
	 iqXlmvatgzhFE1eAC6kTybxfG+5ZYoBa1RGUdAGnVzIBjFoZuRWoKBkMDXiK89OoSF
	 2+wPhIV+TQm+o0OFkvlgHbZm1PAQ1RLpY4fcasgsE2aqnzkug+Tl+jZ8/7ItSotSyi
	 O5oJJReWhKKwJ57PFdVsdsDxQJjOJxYGt/lzaLii+PcgZZdKIMU5ZZjAs67XFz4IzI
	 9AbI2Ed/B7xHoSub3q5lozGguXpP7NaodfMW1kUeTw9XoPgVGyf58db59WDkd1R1gj
	 46vPgMbigJhmA==
Message-ID: <sashiko-outbox-215820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/27] Docs/admin-guide/mm/damon/usage: update for
 report producer sysfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-11-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-11-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:31:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added report producer control
> sysfs files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D10

