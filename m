Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640854;
	b=QWqO3Hsc7QQlA0n+yDiSYX+047ih6NkJUQ71fgdgnsBTHzwtIQz0L8neXSSHGZUt7mgy
	 9xg50L0pfuut9TGO4Z9peR3eGpn3D37G/AgPg2pz9/M+aiqLQaQdGe3dmP7RHf53XNz37
	 5vfWiGnuNEvEs7Gh00JFqrbavfZZXkpAffiEdlNNRpi/YPwLPhIP6uAAaP/SCt4D0VN4j
	 85gTygczu/6PbDaimKGVvFGfVpOdcwbBNtt9VjTwAgmT9yvkKBPOSpbAWvHx9CJ+vH0cn
	 b4GvxQBnQf5Sfn754G59neN0kCHcywvNhJHyHmwMzG6gkiNJ6yw8e4MLQNM2YyTA/+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PfpHdivN+KDSzAkAWuYw2tCHCJlUyhrbBLdfSoKxT2o=;
	b=PILHVlHYiVr67qq+KFxP4X9uY3nokbBYaTl1vnnICMoJ69wqQK1wop75hWsQmmefwey2
	 D74CO19t97Ak7taeMF9aWvwhcltWWyEMbOqu7GOS8MkVWt1c2ARDXVmz8wHerO7iEHS9W
	 cPCu17VfETDQ2ijqOUImL95DEAoHa10E6ZfBhJwAtabaDDW/VNkACwdnVQUhcu32oB+10
	 4xJ1ZSY15V7XR5kMKQw20izhFTDegAPpwtq3Wj5IGbITnvXIEXUa8/HcQKkIESk5VE3vA
	 fRKXH3kr/ICcpxQy6ltPskkvzov4DAB7W6OYBATihQMAbgpAr/PHI4wLHVd76a4ydAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kkQD6nv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB535606A329;
	Sat, 14 Nov 2026 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkQD6nv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CA41F000C4;
	Sat, 14 Nov 2026 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640854;
	bh=PfpHdivN+KDSzAkAWuYw2tCHCJlUyhrbBLdfSoKxT2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkQD6nv/OKj6nh/2UbrAlmn5n1lLEJHkhZDCC4fb3UC11E5TsrofF53/tNQrTuXk7
	 8hjJqBeOajEkSrkusYSQifRZ89EOhmenpETmB1oZbyt40Z2P6bax5NfElE+/JRgOcc
	 utbzKsjRPPuNmPexfPwomqZU93HJnE9mogFWQVxUDRr25ntXLITylShKIvUtCTSGvj
	 Fv+iUcywulP/TWyYNQDuhTrYEdpVU6GAhTSvGZYDPiRnz+1pntPMVPo2xiinMPYa6z
	 IWDwJ0Qcv4vnFk0Q/7WIucYxKsO3INo0L1kcgQLnBRDKjv/W01nacdL71j6JWRKOhR
	 nz3yoaHyB5nvg==
Message-ID: <sashiko-outbox-214259@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/22] mm: publish and clear node memory states via
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-3-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-3-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:20:53 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> N_MEMORY, N_NORMAL_MEMORY and N_HIGH_MEMORY are set separately in
> free_area_init(), check_for_memory() and online_pages(), and cleared
> in offline_pages().
>=20
> Centralize those updates in node_set/clear_memory_state().
>=20
> Behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D2

