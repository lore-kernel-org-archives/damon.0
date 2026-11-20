Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198705;
	b=oxb2WZzEnn0brLy4BaX6TSP44Ngha6CtcZgmv1TtaUSOcfHoioPt1+g5YujXTKTqmrhO
	 7XYDlWcEltrdv1qYddCml2WYoktD/9b9wM3I5fkQ8qVn9+vNynEcwPmW7zfI9eo16pm/t
	 ruxyCMQApxa+1mIXjzc2+2ycbd+jM4QeBZWjnxY/j5W/KSfMpDEYbx9audIcVdP9JGwwW
	 9rC6nwXJRtxS4D1fiZwlp3xDl5OY0qGdgTG6I7cQhvDoGtWnfSgJUqAmdoUBZEW9IId57
	 qwGiQcVeFRR8BqVDf7viSdMzHj56tQNLIMR+J5Ahhodm6dhc89QCCJry8i9Q/6A1/Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198705;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z2TwbS7x5X5HVJgdM5ANhaTJI5tbeNOzDoFZorAjd+0=;
	b=c1mLt8TYbP8dlUv32vsK6zhKssl5e3QbjHZWw6o1xLPtC/csiicM0E11KpOqrDGubK0K
	 WEYz0yax63h2CYqJskbaRKDn2p1xmWg5R1FctVE/OWbdl4stiJY9unfv5lK/3T6pBJ0FK
	 SAu81cRZVR60s9goeqi2vANSairpYJisHYZUX3etG6qwMnN8JLJ/8wwU3sEQDgmL8v31t
	 pxyfppBwS1+CNZfY390lnI25LDCXcilTY8T/f7MhohjAAnJVbze/EAbnfdOlFpdDg/1Hl
	 GCmq/SYrNBfaitTmAY2m5cfMz/mmjzrfgZldsAU+k3Twn0KPPZN/hkD6InKMY3vJsfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESpXH+aa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6B606B21E
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESpXH+aa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D3E1F000EF;
	Fri, 20 Nov 2026 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198704;
	bh=Z2TwbS7x5X5HVJgdM5ANhaTJI5tbeNOzDoFZorAjd+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESpXH+aapE3xUAfaeZ1Vpz3H7Xy3GkQYjG7IeTPM4kJyBQ+dL0HMXuk5vD3TXzsvu
	 Jgsd+UYiOoexoFk3R+e1f6aTVrnapFTIgGHwcFUhL3I0YHe6v1es9aWBdTIjel3sWU
	 J7/+QnEA0wcHet+tBtlh4q+jm5EmMlYRFtYO3S+fZ6kBgY5Y4/ulc8HmlCAWpkPRbV
	 //+gbI3x2tVux4oOpy64LQ749YO/yTRr83nShyAEqpPZ8UlY9bAIralF8RGw3DlPWd
	 278o4+4QXI2DdrrnJ0LyFr4J1I4az9hd2lMvtEwsJdDsZl6GYcoZUbz8ADmfJmxnfO
	 /KKUE9++QHh4Q==
Message-ID: <sashiko-outbox-225794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/60] mm/damon: reject migration destinations outside
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-9-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-9-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:18:24 +0000
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
> DAMOS migration actions move folios to a node the user picks. As with
> move_pages(2), the destination should be general purpose memory.
>=20
> Reject a destination outside N_MEMORY_COMMON, exactly the same as a
> node without memory is rejected today.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D9

