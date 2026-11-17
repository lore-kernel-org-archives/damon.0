Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958178;
	b=krkuYUKJx26V1LVpkegnWB9DNmLGXSftyty3dPEidIoxUXf9ZQxSXjJkl5Wa3pAvHiQb
	 D+85a7aqM40sFkQhdUUVIMw0Ae0YkaCik6L2GO4epE0wTOJF1EvObzI866PqKzpekh+Qp
	 bVP4yGp9pGYuHsqvPqvazue75hY36HeXRaBm5AkF05HSdDOvBtlc9iiNd/yftaNG6cLuH
	 qxFdXrHTCbfg3tPm5kxqPXb7BFkEUFfSv0s/AY06Eo4OmHMnzfLAufUZZ9Yby8elyKGDK
	 G3fWTY6yZosLtftCJdCmrjXiFua3iA2IaEY94cYwucXPZJvSxCcncPH9NWjYcPTVt0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958178;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3ncUYA36ewZ3RFz6Dpl/PwTNCz5By1wqs4MfjEgjkoo=;
	b=NZ4rNRbDFlFkMaIIJtmgMxDh5uNSL4QTwjWmf9Jt6x9zhZstTNJmBVrklgV485vZEDo7
	 KEtDZ27kEYrvFuHSc6jHgMHORYn56LtGvYk5qB3QiGlcGCOgVOyJcFRX9A8nzIBILgdO7
	 et6c9M3XyZ2sxhbyhEMBNK2KVPc7VdbFEjsyeERrKRcbftVKt4bBOIMyRSolMYrDjnMDd
	 KV7iPoQhCinDOHKRYy6mV1PSPraIXYCQDbT3vXz6lPqQEK83RLzv/yLM3HBSSS3bTxntz
	 ZD5lMzukNmb70s5lfkW7TgaC+t93C3lXJoc5VXmh2+pfI0mXcO1IwjYhFP6RrR46YLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bO5lpgDK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17643606A890
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 23:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bO5lpgDK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7425A1F000C7;
	Tue, 17 Nov 2026 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794958177;
	bh=3ncUYA36ewZ3RFz6Dpl/PwTNCz5By1wqs4MfjEgjkoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bO5lpgDKHqflvm6F4kSGvsx7/TMM6JqzVo7Uf7W8WXtdDDK2oy5QrZkGOo+IawVzy
	 ZdNn3XhQmgFIuUrDyjZxMGBlfuimOynXx8dFs8VfpcekbMoxLSXQgRDdqD5m8NxHVe
	 xhJxmLw90J6qGqPBM48RCDWfH5PANi+DR60MQ0HfXftMK4qBSHbuZFgEyoMyCwrbqt
	 KuWyKgYQUdiL/espnI20nXyyBcmq5ooOkfrk/GISJvUQfwFIRxYkiBbx79VViWvW6A
	 v5B8tw3n7qA330MLFuCb+T21v4asn6qhaUS8xsT7LFFwc90ZIFo4AuVXbuXu9+oyj1
	 nH7zk8Dt6KuxA==
Message-ID: <sashiko-outbox-219797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] Docs/ABI/damon: update for
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261117-damon-sz-ops-b4-v2-6-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
 <20261117-damon-sz-ops-b4-v2-6-439888fa04ac@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 23:29:37 +0000
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
> Update DAMON ABI document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-damon-sz-o=
ps-b4-v2-0-439888fa04ac@uber.com?part=3D6

