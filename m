Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854090;
	b=O1+uqHznf60ry7Ars1dIsqfbaYqVY6bfJV3yxj3jwJG7CYI0GKMtpGli45wVfJjLVZe9
	 qQvn2+o0SX53+dRlVqTfrDSzvq0TmJ9ju8qeqAeHPeszKmq7JV8jzdiHsF/QJ9qSbbZh+
	 xmvvGM1yPrhODRbCrJy+kJbvgZCZASl8MyjI3gY04vhWv2E93+wiMpoKXkbZYF1JYBiYZ
	 lQ3DKaCW6lmH9fh6tSRIdgLUbIDvFiImIQo1b8SF64ExcBDKutvweDKUcyNEM0fkPwDiO
	 scdR0naZaqpSSGeKpC7+nyymPRHQKxjDaPHbYTByiaKcnjkYBKrG27VVqAgOAYfk8DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854090;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=09yA9RT0UqMPY5mDsmHiX+EdjggUOc3Pwx51VXXJSuk=;
	b=cm+DcAGZQV1DLk3MkzgFHHs10cVqCOxO9GXsEp2KNq1oRa7FrIvaCXWSuLP6V7ODK9vN
	 7VROJM4GAJytD364Nci+pQaEoIW10Gk82rk2sC6JHJWb7MJjfz4J2KuS/UIY+GmiZh6oh
	 ifP0G3Vm2BppJmYsvEE/aDro8Ijrl2tM7C3jHXiiM/WBTRKhv6F+dqWi2u1ts5ErwBxzV
	 ALABDLdxzvzXQqPY+iTyScNon1u0iDudtE1ebq9Zo633SOvKRLrBhzm1xZUgTVnHVpwaY
	 bEGgT4wbh9CpNTZGv7uACzyzdhW1G/oiZUgvd/r4/zqC6zH0+9yP5lLNFQhlc+TsEBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=binHtt2e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29204606D802
	for <damon@lists.linux.dev>; Thu,  5 Nov 2026 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=binHtt2e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965971F00A02;
	Thu,  5 Nov 2026 04:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793854089;
	bh=09yA9RT0UqMPY5mDsmHiX+EdjggUOc3Pwx51VXXJSuk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=binHtt2eePgaa6IrP2PSPwlKF4ShbzeCMUfvaNIwaPbewWoSrpww/OwuDBtRdgeJQ
	 WIRVnmWOf2H3T1zvkAJjVv0PC8ac1HsygRa7/2ytSBSkfX6Yf5U6cWvwTlXCR+yvyD
	 r9C0JlUBo3YFOAYloVXgArMvAdpIRNuoGX5VbAALISomDjrdhp/MRmKgsqIzOC80jJ
	 C5Fnaw2UMnR1R8ynsB3hxUs+7tu8v1nMlIPiCdRguTE1hRWxL2IUWymHrrAZ/JldHC
	 YvW5s/GvQnYwIPSIzrA9ESSZDz3UNKaj1crdnfmg4U5pEtWastlb+CxuvdYJm+a6ua
	 MmwsyH21qoq6w==
Message-ID: <sashiko-outbox-198565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] Docs/mm/damon/design: update for age_ms
 damos core filter type
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261105044425.87142-4-sj@kernel.org>
References: <20261105044425.87142-1-sj@kernel.org>
 <20261105044425.87142-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 04:48:09 +0000
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
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105044425.8714=
2-1-sj@kernel.org?part=3D3

