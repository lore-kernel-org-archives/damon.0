Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857573;
	b=RMYfwfel4ZzxgentZA02QAM49iGWvdms7dwx1us8gf8K0UjQXEsDn/iXoFizmtk8rkxF
	 ZkqWR/gPsINUSTluVEDJuvJEQTxW/KhXxWg7IFquHKvtNPRXxwzCvWay9R1cIWqK0gk6S
	 H07npadoqLzoj2dcVqcW3LDNEJDSw9n0OKCxYw66bGDbjJlnJfzj72nCVgTRQQLq2TuPd
	 9kHRBHPSPZRuedeB4j1y60K93XmAZdnOo/vghTxWp4WMWUtrSWo1CgGjEjscB4vvHrU04
	 BHlhseVl9tpru9RDTPJGREPZEENsqVBzYlbX3zuj6crcrcXdL79CnlwYq0M80eT7d4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oo4yDA1LFG6Aw3ZMQ5hnJwZ1qsVnnef0wYcKMvyBI2Q=;
	b=lZ85qcxmfABZyAfzOy7iagHoSjSCcAoHrDeSbn/zFE7RIJ7qNk4G/TDCNn6T0CDvaxMu
	 b6Wr+HnE1G0USmxhBNAoZMI2bHCO7QUtprwEFXJLVsgm7VqZfSo37HH3YbaPot/TmUCtY
	 /qhRm8e/x69JGt2e94UmKj2VSeQOKEGDJzpOD28baJMM0cwdaWmVNGLAhm+PLsqmTzUGK
	 YbUIsj9dBVbZgbIeAOp+vCWU0Zr78hPcuIhXnapYXyC05W42x3fniupUJCqlfwNFRqqYw
	 1/LRydPLUhkOocte2cRbwAqMzP24xYXmAjI3wPPqhrAYhNxAxfNUIimK2b5Jt4+ZmMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqdRYPZb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9F606A33E
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqdRYPZb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BFA1F000C4;
	Mon, 16 Nov 2026 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857572;
	bh=Oo4yDA1LFG6Aw3ZMQ5hnJwZ1qsVnnef0wYcKMvyBI2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MqdRYPZbNQVG2PDUntwbDSw+cWTk8YEVxpRrjWResci87RAY9NOzz0OFOC04Rgdhx
	 trWCekhxxjiM82sCUVCLY55RTHQgSToRzL24SRBH1eBIHr9O2eo64t/WSDbfCDw+M+
	 Rfgx2x9qZKK6DvUwdOPzI8LXbitqUdG/hvxnb3thqCZtiQ8g4wZaahEpDkeke5Md3y
	 czMBciFgVJRZc+hSGUTTckFLNQl486NSAxu6zc4Hlcm4ZIm5egE6qz60Ph+B77vyxI
	 MfBgm3haltYfxVGqoY1k3dd9Oz91BPqZGXsmLma6xfQbXGT98sxqr14ZZkigAid2pV
	 2MELcmrJTpPUw==
Message-ID: <sashiko-outbox-217571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] Docs/admin-guide/mm/damon/usage: update for
 sz_ops_filter_passed_last
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattathias Pinchover" <mattathias.pinchover@uber.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20261116-damon-sz-ops-b4-v1-5-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
 <20261116-damon-sz-ops-b4-v1-5-1cffe7227e6d@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:32:52 +0000
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
> Update DAMON usage document for the newly added DAMOS stat file,
> sz_ops_filter_passed_last.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-damon-sz-o=
ps-b4-v1-0-1cffe7227e6d@uber.com?part=3D5

