Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667685;
	b=fF3oAogfv3r+MpHo2qkbv+PPn3WTEgUCL/ojFojMZNxwnDIN+KVisQoLUbc5vDzMAhM3
	 RjeSa9fVS3dsGIdJs9ziHpsWAu7CaHjzYfkSGaUMSq+AlzxWx3YhWweXitKqXuVzWvkgm
	 wq4SOyY/hlhTquH5x6/U5dJ3Cc+y4z3uZ2NhMldeHIhoC6xXzo8E31qAC+UP6qDWVa9Ba
	 jKwo/Sp6WsTNjLMLtTxm4RZ+BbSS0T31VdGghm+Ej0SGJ4hlbT41JMOlqN9Wg+4jH2KbC
	 /cJPxy6QmhzF+4t1x2+27ngiXhx9FzGwkb8TzYvi+fD+6fsynmPz1ZJfl/TwXAXfOOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zMO/1BcGmSkkMHarNPanl71tad5tjVeTsG2i8QmLAFc=;
	b=aGwiTOTz0pTu6SwU8w90HmgjzBW5HCG84JZt29FKbDQPrj+yP4u9ZcC3IzniuYLGZpQP
	 nsE98Liofqm5JUpZ59hjLMgtvV2gbJ9D9Mled2QdwEFn43ebqSHdt3MI/M4SR51+784ip
	 x+2d9TsvqTXPJ367rE3Ofvp42q0Fhm+2ly/tGZ3OBLP2Mx8mY2oD4UjsMROBsevK0TF5J
	 3Pp+DIk566PEBZXEUVEzdXkjPT7+B8Oe9grvq2LaDjLeE77JEktEz1H/queeEsQGeLAN0
	 /aXcIlI4fFyJwZr+jzEu9ELP3OYaQn3DB0dwEWCjVHuMEyM2/FiejXbsFmoW3o2Q4tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9Abk2Ns;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119CB606A324
	for <damon@lists.linux.dev>; Tue,  3 Nov 2026 01:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k9Abk2Ns
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791071F000C1;
	Tue,  3 Nov 2026 01:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793667684;
	bh=zMO/1BcGmSkkMHarNPanl71tad5tjVeTsG2i8QmLAFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9Abk2NsT+PvwuEoxjPV+yNvZ3ITZceUiUp+e+N89lHSpTwZzpQAIYm68f91c/+fN
	 Z/sn9VxP6srQASDyBdczIJFaXn8PS9ktlyeoJv9NibwXaVCrz3XrY3KRXUgF4aVug0
	 sIVuvONlkEr3a4tP0FXmTBJcDDpY2pnqrBM2ArfSEBgLkUJMiQgjWCld5GycMdy0OJ
	 He1Jh+Q9FDW5OUedcaTv0nvb4s/7IQmSsNgHtJVCW4yIuFG4dLMP5ygJ1qqXmymM0+
	 +IjwjJbSnQlCRS3r1YeuEb3GHcBft0NbjYictZtjsyYAc/JHxb8VVLXFBksH3Tk1BT
	 r9f/+Y0tP2tTw==
Message-ID: <sashiko-outbox-194408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/8] Docs/mm/damon/maintainer-profile: fix
 subject-verb agreement
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261103005940.91432-8-sj@kernel.org>
References: <20261103005940.91432-1-sj@kernel.org>
 <20261103005940.91432-8-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 01:01:24 +0000
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
> "The DAMON maintainer usually work" should be "works".
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
2-1-sj@kernel.org?part=3D7

