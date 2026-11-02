Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633365;
	b=KUT2BpGUNd4s4N8NuuT7aUX4ZKPxEtwMaa1T1yII3AIstridKIA7kNOcGHiA7ChKHmgo
	 cshXT8YrMJFQYV/y+5Kwdy1Wu1Jw3bQ0Jdt6RI9CkLqNBVKWB5y+Tl1bmpqmly4IXIotc
	 unXbxjzAWwG8UTx4OfsXH8Ywi++Mv7yLCBUfbjBp8gfV5O1GYDlaBwbOFg4yYPSqGD1uB
	 nwW97SH0+fMMX+f4UIpr/fsmIZLcgKPSYrX1pMJ82rDFjR8tBx6AXVbKRHFqWZTflJWXt
	 5ZlQUA6NKH5Y9OPN4gXeoW1K8jE1n/HATCdA5lrEC9UvgrLRABrYlaaOnNO+Mx4qLZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633365;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jhOF6OSBUXvNVuy1PlU/pEkFj7DUfv0AcEsuKKscaVU=;
	b=nqOT2PAsRpXmJp1a3XZY5a2RVObqNMevDujsyhJHVx39KQVRLij+wJK08s34DNExIAmj
	 8jyak11nUUYgRhp+LAzyx7lVbz/WF78lLkqNTh5rAxHPtec1KOPq2JhwBppYfOfhE/pt1
	 JgBEypaonO6/VxgEsk9Px8r+p3wQGpIUkZypEBgneb8qPondbAwDhAnko7qdg9B2pLAH9
	 mtAT3fA1CqF/V4Mu1BZq7c/15qtZrSwA8bzqg0GPepc//80s1xemNZDowNwEsPfxTFo06
	 A/mEr5iwRmf/n9htXCG/zsAX48LmwN/INkTDYy3trXj1MyktA/Z0Y86j6goT8LoZMdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6OTPqBp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011860D17A6
	for <damon@lists.linux.dev>; Mon,  2 Nov 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6OTPqBp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75D81F00A1D;
	Mon,  2 Nov 2026 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793633364;
	bh=jhOF6OSBUXvNVuy1PlU/pEkFj7DUfv0AcEsuKKscaVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V6OTPqBp6k4EJ4S+mBXlp6zWChi+PbJiAxzGKSSAEQdedaMPo77m9UDa2pRKfuXuD
	 Vxc6xLDtbuDU3qCEZK6RquZspgAt9ZywPLhbIrd5fwc11Z+nmg1yIOLCowrCYZvvLg
	 iX0Zmtg5KyD6+7+iuCLcmlHiCND9ajQ6KgQ+nur1IdlzCRpZj00smwIinuRg/LiMds
	 4X/w0Qe0i4sugBFOSHAxysC8595xz0M/7OB8QIkozJOXmRsllPa0yXdrA95hgvnjSH
	 s6PvrtlvMx78OQ6Zd+6CtHzlm8JLUrfC+5Z5q2VTh6sEifRnVZT/AGy7wOa6zBOj73
	 j3CN+LFpeeBeA==
Message-ID: <sashiko-outbox-193665@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] mm/damon/ops-common: align MMU notifier range when
 clearing PMD young bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261102150757.93058-4-sj@kernel.org>
References: <20261102150757.93058-1-sj@kernel.org>
 <20261102150757.93058-4-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 15:29:24 +0000
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
> damon_pmdp_mkold() clears the young bit of a PMD but notifies
> [addr, addr + HPAGE_PMD_SIZE), where addr can be an unaligned sampling
> address. This can miss part of the sampled huge page and age secondary
> mappings in the next one.
>=20
> Align addr to HPAGE_PMD_MASK so both operations cover the same huge page.
>=20
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memo=
ry address spaces")
> Cc: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: SJ Park <sj@kernel.org>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102150757.9305=
8-1-sj@kernel.org?part=3D3

