Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807796;
	b=QcIl387bsLXyC1P4rpHafimuVB1uwceUrksGP6YqOsBFNDL3P8hbCuj8jOwF+XdWUAKm
	 pHFbo2HK/uamSC24bq5C+D4bmdEXTafSJmWOC+jJL1kOQnfNSDC6G3jejIzFyye9jGOYb
	 qd0/pUQIRXhgbrSSRMIgL6xripy3/iVHsxs2DPjoe9fAR6VTxMQdTOoWAQPD8vcWvwVZa
	 gOBNOdUSWBYDKBH8chrUXUzteYLAHZFOPBhMQNfTtu08eDG43+tCI6wAi67+pivwAsfc8
	 XwCHKgE/4gA2TWPN1U50+rd2WDCvJ9fOdfLMvt3NKr3kjQEQMLBPZn7znskqKEcvmaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807796;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NSxmny13ggD+mjRbMyRCXlRIWaJ+SDrQzpDzQwdOiDY=;
	b=C8BRlIdA2nsYj1JZK4e0UaXVWG5+HxdgDylgT2iJVp/xbo4MViwCh8JesMzZMuZtjXmp
	 2lZ9E3QommmGomquAOUR/cWhUytKnvBwNXcqsDqqXQqoTyv6eKVhgcZxTOmgFsRw3Dn53
	 LbUaL2DbCoPVIt0hw9EybdWLWb5zrb71Hsun/VVGAnrlDl6yYcTA8BJld0bKprJAf/03f
	 1hmyQ3lThTKUrF45MzOSGEPtUL7SET/Kd7YhCMQJT864DQZzcOmFfu5/q/c8SgDP9C0Nc
	 tGoj+cTDrRNPfxugC2Ts87HGmxO9ZG2UxrBFJXDDuJoUQ6IW+iMlvjk6TqQeH2wPLRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2vN+u5V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAC606A334
	for <damon@lists.linux.dev>; Wed,  4 Nov 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P2vN+u5V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546341F000C1;
	Wed,  4 Nov 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807795;
	bh=NSxmny13ggD+mjRbMyRCXlRIWaJ+SDrQzpDzQwdOiDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P2vN+u5Vp6VPIJnCwxvvCNfVB6njl+EANJaMgQMflK7M0R5Al4Cb9xqgwYOKAa8GH
	 dCImMr1LqBrViQrEs1JwsA7ybAw7a8srT50Pb7PyrlBlP1gEkIaNTUd0KsxvmmGa8F
	 BKnIgvJwVYt2vP2gdvJjSHvI2gS0MSbbJJ34yaYWRQH+bYwd5YlvsjcX6Dzyj0o3Wh
	 Dr9/QYkEABfAlkrXeDQoDnHQbksEsdz6f+Nfu31XM8KABDawABqmwiDcI8JdUWNUw5
	 +RzsWxa44//DZORcRg9LzgNgUIW020kld2KIAoeFXsOSKyPidBWlgiSN/70rNC/Mik
	 qF3CYzc2Tg5qQ==
Message-ID: <sashiko-outbox-197562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] Docs/admin-guide/mm/damon/usage: update for
 age_ms damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261104153645.82945-5-sj@kernel.org>
References: <20261104153645.82945-1-sj@kernel.org>
 <20261104153645.82945-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:56:34 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added age_ms DAMOS core filter
> type.  Add an explanation of how the age range for the filter can be
> specified by the user.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104153645.8294=
5-1-sj@kernel.org?part=3D4

