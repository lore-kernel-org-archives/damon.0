Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198864;
	b=EVxbuzYm1WfBkUXeKWODIzZNFh7vWcPSDjkOIRKHR6AloUVuQAV9oOZK4RfTGHdc6rAv
	 IHsy85Myt3qt5qebgn0SdlXxBuzMtSsDGTA93g/DkKrPtVsAGENReenHproDs3cTG7H7Q
	 1KMYZM/U9+QeSIsH84IQmavbEXVC7Jv5zX2u1hy0orto3GUoxIF4d7g39yBWKF06r745s
	 l4aPeCNfy9bimgGx50XcEO2oQQJpyZIoC0UYjlXSOZupMPe9jte9gonUobtSQHobRWUnA
	 i7gJOjau3GsCg3edohV63mnoin2uY5kqIwSdMwFuugYWZzl+PWfB0aAaNknhlTbAPNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198864;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xY697q5x1DNNY+FCWmrTEVtuEEBh68I+lBbT/rW54WE=;
	b=RRFIHMvcal/5fBNeObZblAE6Nc1aqdVWshzEiry6M2xVYcTYLscXVJh/LHjDfcgX05vd
	 lmSMbPkQ/7NthRQj9Riao9N2g/GDIshWFR0vsC5hk8rr7LkV8MJ5f4zM5Z9s9NN3cZgqR
	 hC9DekKpcsWaG8hezLa+YYcctUMLqp7G+K1FKML9ZNWfyv9J8B/afazkIZO6PYHd29wo4
	 NPVEVxiImyYUYXCKUDDxkUm5K9q43tJTU35CW1/e81fkjnIUlpXK+/Xyc2tlBMJkYA+/k
	 sMBuM1uahotwrL2EuNvxRrjAmqFD2Xd97I5VfZbK49iDxGW9Z8aGstQrn2crpaWA7Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNDAOGGY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4FC606A881
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YNDAOGGY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF81F000C4;
	Fri, 20 Nov 2026 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198863;
	bh=xY697q5x1DNNY+FCWmrTEVtuEEBh68I+lBbT/rW54WE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNDAOGGYoJ5kIPAHMRtaXEPPHnK2r6w6Yqaj9Iuyov+CkcYtZeu1zwG0naqswwTZK
	 VolAVK3ppZFMX9sszf5DM30eE8zgPTvFnTs0jW47BK2I2tAnMEAsFj8g4AbQN8T3cO
	 E9AcQ8CW05aPaN4eASzt6KsHWjGb3BgcylFIc9tT4e2CBzY8Yfpdnx01U94/AJMljk
	 T7Vm3KsKPEEU7vlNz5607m69BbrJemVv+DgFb9LK8/WIgk8Lx4aQGm3NRFuBCdc0Od
	 nDl1oAsSOXUCIdwkTopMVkKYwnsQXSiRDSdwckS6/nXsURbEGuZ+fr9H7wsSasUmGs
	 K09+GtkXEhCmg==
Message-ID: <sashiko-outbox-225807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/60] mm/khugepaged: restrict collapse to common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-21-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-21-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:03 +0000
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
> Collapse is an opportunistic MM service and should operate only on
> common memory. The anonymous scan and isolation paths already filter
> zone device for the same reason.
>=20
> Replace the zone_device check with page_is_common_memory().
>=20
> collapse_scan_file() gains a folio_is_common_memory() check. Page-cache
> folios are never ZONE_DEVICE, so there it only filters memory outside
> N_MEMORY_COMMON.
>=20
> collapse_file() rechecks once each folio is locked, since a folio can be
> added or migrated after collapse_scan_file() looked at it.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D21

