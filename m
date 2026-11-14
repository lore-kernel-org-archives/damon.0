Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640766;
	b=OtIfn6LzDvWLrxzraicVDCueQcwPTSMLIvpGnlV4K3GpIuyp7DCTGIygQvYhHc8U73cs
	 fgpi8/j4J0Lq8SNNUcg65Cd8La+MMMOOCPkzFW8apGlcZWguGa60r1nm0LYN2qV4voLrN
	 nUcOywds34njCMD6G0Fw523forX0Qq4KixWecU6uAsTbjB2ZAi2nv9OfuS/j/9JxCLopy
	 1h31teX4Ae7WrCppVzv+R+6vI4isACKKc1NReHHJre08hJqFIfqU5+17PGrnUrpC9DSyA
	 W884GgbQ5zF/hvx4fnyPPk1R/3W6Q+c9RH0qMl+LxdB/Hdl0TP9zwV1X0x/1dzwoPiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=53F86g1+1KdF2REfEFTFGhykm2HEgV3Qa4BfWICYJIs=;
	b=tgW4IWbNTqmZTn5l0N/TdTF3lUtaAueUHjQEhR7Qe7jjH3NYFipmyuD2DqeORVeemP69
	 sSjJMJ/1WvHlm5WEjx0mQ3oe7khQn5erMxN/8KfQ0Nk73Tok7f/3burhVEyWqR9x/QA5w
	 wQLTsbi3mNh9kWrWsfBJiLGRUac3+GgVYoZ4xLdkfrnsC1D5koh+DudB5ZR5MMzMoQR1P
	 qMadBP3i1ekMv2LuIBJsFYlI5LApOI4VMUiwXL7MJwRxY3EHmMiH7RkXwB9UuEHFVgsv+
	 zSeRQFSbxAzLBmvKPlYXZd6VGXMaWtdPwpPOiP6RR5BCXJOTP9si18U2FFQBBwwr/VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T96Kmyy1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE99606A335;
	Sat, 14 Nov 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T96Kmyy1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E682F1F000C5;
	Sat, 14 Nov 2026 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640766;
	bh=53F86g1+1KdF2REfEFTFGhykm2HEgV3Qa4BfWICYJIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T96Kmyy1RsaEcBN1qA2dNQ5sye4PYKQvGLL9AzCeLRZ6YCWfC2jHM5eSkHZpwH7BK
	 J7n8/+rve+OIZ1vzYbVpi22xV1P4x38oHghXH2EPsLIfqPTS7LpnDo5ERQnXZ6eXhA
	 Jp/RfzmwuoB2tvEeKlb6T6ybVFXnyyshAHU+UhDHFGACobYkz23iMbT933D9WjfsNY
	 mKG4W25/H755mq7wpdRLbhT++O3UWFhS/3zxu8aniCblTx0Q3Pw/NEha46JGGn06MJ
	 8Mq6zM/8dTi4txFo0eCH1bNiIRDqbY5XhiH+WNKtFmOlaW7dvQywDQG4OW+coGE/mA
	 rPEv923oOaoYQ==
Message-ID: <sashiko-outbox-214255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/22] mm/compaction: restrict compaction to common
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-19-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-19-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:19:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Compaction serves the ordinary allocation domain.
>=20
> Restrict it to N_MEMORY_COMMON:
>   - start kcompactd only on common nodes, at boot and hotplug.
>   - walk only common zones in direct compaction and when deciding
>     whether more reclaim could let compaction succeed.
>   - compact only common nodes for /proc/sys/vm/compact_memory,
>     and trigger proactive compaction only on common nodes.
>=20
> The fallback zonelists hold only common memory, and all memory is common
> at this point, so behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D18

