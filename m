Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199155;
	b=21BlbVzXyuN2Z71a4vsSJcFpFaNQQjrJ0S7BDFRB6mBsIDbzLi/7BEbUrD22AdG+JqXK
	 Ln3q4DSS+JNfezpk2Uo/vwO6Mx3YUWAhmrMDCk1Ou17VgHQPmGYqPqYRcQB6J8t12FWf0
	 edICvKzdQx/1A1xGn3BCOa/gUuwuQNtcteqEgNtEhZCmKGPwMhgvqfJB/2ZkqOgTckRx6
	 f3iDlJ+EsX1nF6MDSFcFfRuHLcwtNIVh+TWSy+rXIkqrg0Oj22ObEvzbdrPhZhGT47y/K
	 GiNe6W5nJF285roQjn2tt4cYryk9Lyt6o3tqg+rOVI9ZJ21S9m49Y/ekDgGNqBe9SCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qzZSuknNCwDR6zsfKzM+TE1tfMOH4RF8VhwWtqHVfVE=;
	b=KE0a8Zf5DHIZp23CbCNAotWNmABnh8CbR7cw2BuDpvGc3M0cFXZnJ26kL7017y/JNCgI
	 Dcp1IBG8Dsg//aZEcMt/QCb2h2YXSJKHyrSFknww264GJurIEePiGzXFn8vCfMEXajmpH
	 BaDnnstX41bjJAo0XiDCmf5hxvwhhM05CZpqwQtkvUBrrtQLxVjdWw7H235g1KUFZAPVE
	 xPQHtVZLtfcDzRF8Pi/6J/UI2POeYyWTIfdmoUlchZ/4NDQEpO8u0Mr0CZpVFBGpA8HRG
	 lAPeUXoVGL+UzqP7jdw1pgbRGtGc8652y94VQxkdYDvsQTFlEzfkod3z2Dm+PgCoiBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePiBjfTx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BC606A320
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePiBjfTx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20EF1F000CA;
	Fri, 20 Nov 2026 18:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795199154;
	bh=qzZSuknNCwDR6zsfKzM+TE1tfMOH4RF8VhwWtqHVfVE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ePiBjfTxVHqS9DLqaiOTfLTCCeisOkRZ1bq6Fe+SLGA5jzL4dpiLQzbmZLt2Ktsa/
	 huSB0XJ7iA4XbMFi1l9lr35xnOr2eV38OX9/qrr3dxFuNg8gKRvp6TULErz4Mozsfb
	 R+hnXO7oCg5eFh/Px5K50WfZ2MgKzUvBGu2vLl0OoWfb9VkiO6jsNjOkDU4OJIUqz2
	 NqR9++iFHB7tdZHvPCgb7s86uPvLVlnMJ8zgxguP4DZ76doy74AdSkkl6/C9pLQrpw
	 Y7BNSQvdh3YETiuenLGYtXWQHKTLO6N0qnIBfADLEWRNOUQB5xN4JVdOxkBhYp2qDj
	 lgL+4gfo/NgvQ==
Message-ID: <sashiko-outbox-225826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/60] mm/vmscan: restrict reclaim to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-12-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-12-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:25:54 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> From: "Gregory Price (Meta)" <gourry@gourry.net>
>=20
> Reclaim serves the ordinary allocation domain.
>=20
> Restrict it to N_MEMORY_COMMON:
>   - start kswapd only on common nodes, at boot or hotplug.
>   - walk common nodes when MGLRU's debugfs interface iterates or
>     validates nodes, using first_node_state() and next_node_state() in
>     place of first_memory_node and next_memory_node.
>=20
> Direct reclaim serves an allocation from its own zonelist, so it is left
> alone.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D12

