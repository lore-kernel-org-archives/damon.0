Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8603282F1B
	for <damon@lists.linux.dev>; Fri, 11 Sep 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119293; cv=none; b=gPh2eh/8ussLLT4A/izXbs+yj5j4fk/DSXpVYlQxSlfY4h6asyYEahpanTfKsdR1YsQghrHnEVQfrEMhdh4t8FiqWOUrFqeM4R9gA/qIhz1HBMa+daHJKlP4zNf6T9L1tXaP/1K/uZj3qbnKlPKVuzoYG1/HLz6YWiJcalBYNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119293; c=relaxed/simple;
	bh=H84dO5mInk1YPhRkOIqjtFzNyjZM0257jwjE7szaS7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qR1nKSORgO90ZH4zdS6WhCHkPa0i9HnhALJDUh5S4/1gkysfSoWRuhlAW31J2MiLJaLIa3MljpZJ2ZiMOkQHebJ//PPhhKR1yWpldjUe9KMG03pzDfTC95HHN25yK5sTQbBsSdkbAggLTPYo3hk4h8gKuguxD9pci3K5gUcrIE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9mORF9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9mORF9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB31F000FF;
	Fri, 11 Sep 2026 09:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119292;
	bh=H84dO5mInk1YPhRkOIqjtFzNyjZM0257jwjE7szaS7k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9mORF9ppn9+3oAO0MNBgoS8qXMtrwOQ0ozkcBjl5OvrNZyvelrteo01NlJXAAjTL
	 mIRGMgRaCT6y3Ue39Y5SPxdyHxS8U1lN5c4shuPP+kHSGluXRoctX12tI6PtsbUU1D
	 oiJ/1F2vaKKNZZ12dMbq3cr1QOQO+ACBy6S9HxoUjaZwphjhIyoYUy2nEcS22sRQDK
	 wg5Wdb58U6EoAZIjFolrrOup1ooq13KLDbvQcJUObvXrMvW5OWv7Fye6eEG8HyoeBC
	 aO2uOnlBuFoYYbFwsbhUJKcMJgG7bmfd3U13kwP1+b7ZngY8Xyr2FY2sRAyiwx2PpN
	 jGQUk1ooDr23Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Docs/mm/damon/design: fix typos in temporal auto-tuning
 algorithm section
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liew Rui Yan" <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260911093314.156875-1-aethernet65535@gmail.com>
References: <20260911093314.156875-1-aethernet65535@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:34:51 +0000
Message-Id: <20260911093452.1EEB31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Correct incorrect references of "quota" to "goal" in the temporal
> auto-tuning algorithm description and fix the square bracket formatting.
>=20
> Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911093314.1568=
75-1-aethernet65535@gmail.com?part=3D1

