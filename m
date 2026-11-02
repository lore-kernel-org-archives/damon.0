Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633787;
	b=ya5+IF3g1pYr9CAjs9x1lcsnj3MeW/tfuxbn7JHAm+rtsu69EbnG6Ks+A1QVcs3EIzum
	 Ef3eYpndDWq/eosHy7wKSUaDrY1hn2RTnuhUqYU/VyAnR12MAKJGokhhCh26veE1F1eto
	 0A5zbMFV78+m2THFxzxUsmjcT6YT47cYP5bP7sP9xHUoj24R9rGZKE3UmtvWn95YlVPNv
	 kEhN6hviPK5yjFHrLN1wQrvXaabsNk3u5Rt4uivb9oD+hev4NvDlI75zF4Eqf4Uw7l4NS
	 0M61zf5o6pu8y9S1b1mQp+YvrP9mPzrbDq/YqKWx2NJwZR3Fz/gaSoutMAg2kfz2ZBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633787;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FWqVDoVh3g5CKIG7eEpeC+TY4b/UjyNe5bpG5fach/A=;
	b=0WrXAk/8gQdeuMShCSw2SJCR52Aa6fGbbxUSQSED4ejzXCDigdUCVUQqYmgdN9yf/Fvg
	 3DFCdveO8JkTcPRh7S1z1zWvs8y9jfGIloIiJXzgaeffHXn0IZVv3PYn8DraA8OKieSM/
	 z+t5QBu6jYG6Jf3hIJoJEvqdJ87S/7b5UzXWL7B8yR2FqH4RzQLTWPM0gXnsT32pOzhJw
	 aMwNF1xpI01GfP6WSsByUQ97bGKqJkwfHJJARgW/aaelsTQ2//4ap2s6P1Jh03rRCqQ2S
	 v8PEJteAxFK3wAI3Lzm8gJLH7lnL36oS43rRhdv6K4JJiPSo+X96Tc0wWg5ZpC7hYKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0BqSlxA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FD60A18B0
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0BqSlxA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94D31F00A1C;
	Mon,  2 Nov 2026 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633787;
	bh=FWqVDoVh3g5CKIG7eEpeC+TY4b/UjyNe5bpG5fach/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b0BqSlxAvUpSIF26X761tR0CgiTiw3WH3QkTjmjb+IQ1UlfwGu8vWY0h7HQJbBoAU
	 8hf5conAOkFEWvQWJjuO5FTO62EVHN6T4X/Iq9/x4Kjta/Ce3AU+Lu8fg2OYy27bId
	 3s/9uoBa1V/NHIEO+5GIKUV2kPBqggKkw9H3AOMD1y8ah1dGMMW/y/fSIvVBTmdCFv
	 ox/VaqgcOwoEOzlDZN/HBpOH0V3oqyCs1jr6QtpBcxqqDNTJzVNjEMvhcC+qwolo4U
	 PsLC8ROetRhgWKgTAxvsk7vUWptIu9LkZGFNzKADH1OCo73GulXm6CkIfg2cJIwz1v
	 mGnY5Lf2e6mew==
Message-ID: <sashiko-outbox-193681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/9] Docs/admin-guide/mm/damon/lru_sort: fix grammar and
 stlye
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-9-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-9-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:36:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Manuel Ebner <manuelebnerli@mailbox.org>
>=20
> Fix tenses. Split long sentences thereby imporove readability.  Replace
> 'set as' with 'set to'. Replace [] with () to make the file uniform.
>=20
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D8

