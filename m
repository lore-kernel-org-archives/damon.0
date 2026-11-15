Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774814;
	b=GBQu/1RdcWfygZmNeu/tuUNr63orF7NxKAsjqESZLT1H3uCBwD6N5uoBDxDyvZbL15XL
	 wVtElW+WJe7Pff7LkDxhIRAlCUqgtXEuWGSLFCIeSs1ShjTSQlGJNw1NNNxc+Hwt5MPQh
	 pXaCqlFISi7Zm62nStJua4z2EOZzD9Rmgy4Km8tkzrRSNlvMupwA5rGflFHO+3e/rFEEs
	 n7QwzXsLNH6l4lWAiSEm4TyqEUiTxGDvd99xpocgwRmnmQ5LE49CCjmceLgM7ngU7vbDN
	 QRtAOnTk4f/JecWybAVOAdHbjk1OPOwKwCEgo7Nqy64/WwSYyWwK4so0rjHLXN1QLeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tjM7xgT9DUSK5tQw4pZOdP1Cit/1tgq+exz5mWOcChs=;
	b=VB87WI1t4qD9NYxrlDlAs5oBPTrNMSFVE+rP/jcChT3U1926LpmsGESIAxtjHdrpj/QS
	 IhIfZ8fNLmETLDB/97Ba/ci7qTuAwK7HqE4ZMxp5M6DnQO8h2+eJ7EIlSsm+F1vs4yI+x
	 nkLVuTKU8c22k1ZbM9ZRPfpKuXkcth/aB4SPexZIZCDGDwNRxdajQnoHeUrQy6LaPI98b
	 56jyIrtcmHY3tNK382bm369EjEdKedHA4tx0/dd3UyifNCfPIcv2f3jmqEvBILsRmG9md
	 nYOFdT9vrvGt30DNMbSG90T4GYPfBLyJZXqxKDKfD4eptDUtcgl9lD4e2DsE5Yw3oLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WM209E+8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8B1606A31F
	for <damon@lists.linux.dev>; Sun, 15 Nov 2026 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WM209E+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BCD1F000C4;
	Sun, 15 Nov 2026 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774814;
	bh=tjM7xgT9DUSK5tQw4pZOdP1Cit/1tgq+exz5mWOcChs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WM209E+8nwWsOMEytgr+AW0vDr2rxCoya/UaUYoTjezKZSZWAa3UhDREbScmp/BrU
	 HGowknAxzoJLqN9lmMw2xSTAvqS52ZuWZR2GZhNjKN/CM2fMYs5plzTV7LSR/67v5k
	 gIuZekQGit3neFXPFhzGfq5a0RuxvI5UcjW19QD3R1p/0AyHy17K3Aeq/26wJIav6f
	 v4c2OPEnwbHUijTFh43AxZKqEmDAj7BiCn2uLlRhzPWCyUhNARqGgIU3cviSPZdHsR
	 YIE4DCSc1elnBT1nCCg0EP7h4QjnuxtVCLAp2d7VBLuuWiwE89Kwwj88EnPN3Y1cX9
	 ltQ/Mp8PWNhFw==
Message-ID: <sashiko-outbox-215833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 21/27] mm/damon/sysfs: add user_report support for
 report type input
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261115202849.99134-22-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-22-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 20:33:33 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Extend the mapping list for data attribute report types and user
> keywords, for the USER_REPORT report type.  Use "user_report" as the
> matching user keyword.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115202849.9913=
4-1-sj@kernel.org?part=3D21

