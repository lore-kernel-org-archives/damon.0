Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667692;
	b=pkt7C7/5Pe09Igu6hSpNYko4f7KJirIPFihDUuoyJ3iRGGXTcdwGH1FF8NB8DETncHs+
	 yWc/3PyJN2G9elN+6XV8wFYGVaWmUKk7YR6ebcp9Odq+J1QfLVCUEL3cmBn8mWAWPG1iR
	 oHvvynyCRezU1dk5wCQ4wGxyiQXzNoha3SKlQlRJcOGAkeXoLYG0lblYus+dFUUmW2Jy1
	 2zGeTIw3yHTbb36OtIG4m7ktRvIquAhhkfeegOaOtKdmI0EbpeLmQfH+ELd5lNlhxM7ua
	 xyTzVVNKK7fPk+1D9ECWmxsj8rU7ZeUXUj39r6X9wLqwNpXPL88aQQuXz8k+7Eo82PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667692;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pky+mBEiZk/fSQEUJGnUat8IDUrM81+dUGGx260crMw=;
	b=DR3YeSAe4yr5215MXJX8/zi/8pVPzdZM3bYOGBc1aBfp/nvmm2GxkIZOdTW5H+CTBBic
	 Dfak7aaj6QUdVz2ZTEFSXEBmUd3/X1BdAZQoouhj5+zOqSLFlb6ZO5D7b5/CDR+5dkLAw
	 e+FPeS0LOHKpIyomO8nx5sy3jKEQ7E0/NMucJI2AQU6eMV/8/t2O0WN+W23N8LN0tO2Px
	 KXISBGLt79ApVXmFF4PQ/ZdVxyn2T5JSpElx7+DWvA4yL3dL0q5MBaYqagfNTcvToVZ5M
	 BfW8S95vZBjDyqDegx3cwOzQGr7C45bhD4x8MJhMrVZAICa1feNu+i6+QvgN8EA5w5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d76hKb1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB83E606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d76hKb1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4F61F000C1;
	Tue,  3 Nov 2026 01:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667691;
	bh=pky+mBEiZk/fSQEUJGnUat8IDUrM81+dUGGx260crMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d76hKb1pGlO/9a1UGPDfHgXJ2HAX1wq1SLxLt157ZTJROQpmeoAA9iAJZvbFHHj8d
	 iGw2NmcUgST3TrOLjeZqiPhEjCLthRNFYknSTs0MAo/GhOMo/5QOe9ol/USipHah3c
	 OXut0EwQWvQr3gW/ya9TEgSxK6d0LAP3YTE2zHdWURx8nDwAbXO3hS0UUMIPrOAOMu
	 vSTAdODVWEuxK1DYRGry1fvOhh2woTDmZGzmeUzc9wfZazxuntmYKU8Zcf/IY92rZG
	 Lo5/vCXhpk2X/hfDsOSiTk86ysMI+sj5rlf7achgwjge6yD+cX8DdlaN+6L3IqlTwG
	 zGXQqG5slarnw==
Message-ID: <sashiko-outbox-194411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] Docs/mm/damon/api: fix verb form
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-7-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:31 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Aveline Noir <jm5905938@gmail.com>
>=20
> It should be "All you need to do is include", not "including".
>=20
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Manuel Ebner <manuelebnerli@mailbox.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103005940.9143=
2-1-sj@kernel.org?part=3D6

