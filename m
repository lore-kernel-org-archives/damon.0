Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969372;
	b=NToss1mzy7gkjli+51jOYGkMD6hMEOHkgtddk+m5Vxhi9RGTo7FGYhYopMATxzZo79ye
	 X+Vxudknm/pE+Dec/4hQO0mivCQAPbp6K9kVgokP4AFw8mpMoXHxe7zdxmt1qvk+Y2rcx
	 Zshd2MKMF+b8jOKmMZp60sH+3exl1+qQdEHNDUscVOkCypTEy5Q1ygUoYNmDz11E3XGbq
	 b7ClCbXKgbQBmqkSA++d7G7FBuGOlVizoFJQP2KRRuEBFMW0IrZmJsfL08msnZZ0zkUKC
	 bqol6JdNRq3S1AuQv41tMS1tM9+8vxWRBEoTcd2mVG75UZeceLmaFjjf2aU66xnRmCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969372;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dv/mrLw5YzjryKXEX0BXaR1ZaWhpvAdiqzMDujSeUag=;
	b=GJpfk/U3NA+XAJi71+pOBTPF5HY74D0WSFFdKbma7u4wmZTBEMU/kDnpeauCUk5Lz0Tm
	 QKoV41zuDZDAoCDQlQqDAbwYM0eU/v2kfMeO70t55LU7lJmqx17Zl5WbGOVl5X3nmsV16
	 IzA3X2FRXw4jHoNIUGBUbjJjJtHxlj6s0gioZxjNwptTYEzwT7e7vqOL16DjR25tRhELP
	 ytwn+pI1fYGmUdTgCfThj/JNiT0szNL1LDD39O5372F+N2Xo6xdDNUxmHJDdRPqvpJMmP
	 rYNnkHsPULnu40FqlNsUOpf7UngmsreAkKg4H7r46qKcMzTKflspBcHWzdQ5lHLLxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg0LrutX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51E606A31C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg0LrutX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B131E1F000C4;
	Wed, 18 Nov 2026 02:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794969371;
	bh=dv/mrLw5YzjryKXEX0BXaR1ZaWhpvAdiqzMDujSeUag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tg0LrutX673xo78W3/WtVN8hXBVQSsgQdMtf39OXltJbURIC+7OZ2CvAuGS5YPU7P
	 Y4mX+mHcfP45JVugNBuIYIamJaMNU8cLrI+9rhZpITpYJoFLLZl31P0mV/0xG6vTmb
	 JMGkYlrTkdV4ciweBX4WUE7jqMchkG3q4KLyHnbg2kxTbfKB12qB+mEIr9FU2i2Yb2
	 YcgeBfGpbFU4MpROyY9XeIjIG4nkPQ9LnsXukRY8Q1zzajZBytdrvIEdFOSgBJ2MKw
	 /GEqkwDcFOSzB9xT1BFGe/DpiSvTD0gHaOXmdUUNUm6zRRKCRSQtOOgaypK5k8Ol/H
	 RFB8hPLeSzvig==
Message-ID: <sashiko-outbox-219973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/27] mm/damon/core: introduce
 damon_submit_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-4-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:36:11 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement and expose a new DAMON API function for submitting a data
> attribute report.  Any kernel component in any context including NMI
> context can use it to report their finding of data attribute information
> for a given memory.
>=20
> The function copies the content of the report into the DAMON-internal
> report queue.  The copy is done in a ring buffer-like manner, without
> being blocked for consumption.  As a result, the queue keeps the latest
> reports up to its capacity.
>=20
> Use simple CAS-based try-locking.  If any parallel submission is
> detected, simply forgive the submission.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D3

