Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958213;
	b=yEThv1SeSI0/XR6n9UKJRqdNKcuOFrPL21YYV9yCTKvH208YC33sB1zJ7eMVMvZRNfkI
	 ojSWR2E7lOBkEqVldHy/a72lYvAEriUPd774QDzwwHmrGCZbLCDAK2RCl8tREpA5DToGx
	 7/GQynW/c5Kdv7pP3Wiuypyou51NK51bPFgy1HfXA24I3wD0oFV1uTu7iTxjNYxTfZoS7
	 d39S7BfLcZydlyLKcvx1vc/TBcqKLzUeZfOsJ+t/JD2EtbaXeWGmVB7ApWoIwUpITLHNQ
	 Zf+wS3B6G2AFlmn1ZfYgIJkU82iQABZi0l7T7lzDLnEUeMPs5vXjOuSE0GVzH+F3RZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EnQqYD6pFMP5FX1evqQ6yVpOdHTa8fiBNMWNy1jq3FY=;
	b=ZJEbEgsMtrJw5DAY0pIZpc+BO6EYDU5CQ/d/5W3vlPzp4jzff/aKP+4jgmUy5fcesSpH
	 MWxuhrOLNPHCn/sUkhnl6p27e2eLqsgmQ4wG70Gcpyvh4qerUIOSKkiPVLsp6ZVvZiEEp
	 X8nk6w1kDmYVI0aHyKcPcfWIwIgXew/vJNke+LlV1/niCTBNz6eIS1NBezH2VoQNhUq6J
	 23NKSbvbg1N0CXCp4vUXdy4w9u0YszmKCAdoGJWqMaSmOhZXvwo20SwIZTHe3t3QEGDlI
	 eLd3XHi4UfKLigA2bgwSFKPO/vT7HTam+7miP9F6DPNq+PMLuexKxz09PCRStUIKJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpcQXBkV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86E606A31C
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpcQXBkV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311E61F000C4;
	Tue, 17 Nov 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794958213;
	bh=EnQqYD6pFMP5FX1evqQ6yVpOdHTa8fiBNMWNy1jq3FY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PpcQXBkV5q/nYqxcLd0TRsqI9ziptiKXYQQ40XdbAjZwDIT3OxjzEO7g/CcNbM1fL
	 rG2pvfViJ5hPKzN4R88XywEOL7qAcqS8raTlDmqUyZsx+jmZlPMtpZ14dZg/Tf/5rA
	 PwquHTX8Y164f1pdXzQSfqsaTiK5ybv0u+CdghwIsrTfAW/Y2RQ+3Yt+DwwJ16Ahvt
	 1tm5SFb0svbndGJl2+gPN46Wg7sr7vhF+ygUMksAnfWdoEZbZqC8tBUePO7NTNBdKV
	 kyuyqMsI1FPU9tY67Nu1hgTxW/eaoW76O2Mzm6RI7stXQg1vEsk9UWU6t55hpmS+vY
	 9al90X/uCpszg==
Message-ID: <sashiko-outbox-219798@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] Docs/mm/damon/design: update for
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-damon-sz-ops-b4-v2-4-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
 <20261117-damon-sz-ops-b4-v2-4-439888fa04ac@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:30:12 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
>=20
> Update DAMON design document for the newly added DAMOS stat,
> sz_ops_filter_passed_last.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-damon-sz-o=
ps-b4-v2-0-439888fa04ac@uber.com?part=3D4

