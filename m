Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198817;
	b=tmGKICj1HZ029kSXJyY+aZlWSIlSiUMCKAkfG2baV35wI1mzTkGqX3fPU5gS4wpnPeZJ
	 rvLNpFL0sggkEO5oWooyCi2AFwtpZuaxkvT7tQZmG0uiHfqOevYm/d7VSemmc+7vl8q65
	 5v5Eidli9ECDK4VGQnPeLqJqbvgrrFl0NRvKPzJjpyQKzMABZ3Ut86cnmf/lOL+RLbv9N
	 GeSnwf2ssMmFcErWBTXwSqrXT4MxKFy6iqGUc/7Au56wxR+D9SO8ZEo4iWR4D1QdLOdhM
	 gc3l6EkoXP5Pnfq1IENa8jTYJfTlieRc5R/wWoN+Feo0/mpfxoNHxYx9lTjoTEU/erA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=60kroUjBeEQCeysXiCq9mfvVEXpL+REfPDZjSoUD7FA=;
	b=IPC0cBz1bMjQxcNfv9IoGs/BRUwB/BJXUkL2G4gXgp0iow86KefGIHN2XM/qYRvhVFnH
	 oLLdTil42OJyMxMT70gk11G+H2JmG8KX1+dJfZWzWMoju/ymxkd95GWSXZr36xuLz8Oxj
	 U8CW+ua5IryZLXmfo/7ByrnAGLkMP/qBOsiOvuWWyS+IfmL35EfzvUOEfPa3T9LCAbpJb
	 XJN0KBQ4wuBIfgpeBxxtLIdg5W2f6NohEnbBUKyzGymW45gCyXRYnIH7XvpKuaV9LFvtR
	 M6LHKoTMYlPLCwzd+fQVxmYtnrSpcJ73R+0Nb44qHQ+f6HlZifllEHo3SqetWFwRY8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi7z8uB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC2606A8B5
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hi7z8uB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91EE1F01564;
	Fri, 20 Nov 2026 18:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198817;
	bh=60kroUjBeEQCeysXiCq9mfvVEXpL+REfPDZjSoUD7FA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hi7z8uB0HKZgknDvMSlXzLmuiIszB378P75hc7sZnOsjwM6GxtEbi3AlL2uRNbxsN
	 lqjSqYKEIuZ8NP5DJjgM60UzAJxmUeO6vBDHWLREuZRfBNKcqpe8YPgQb1/iHkFDMr
	 8K69+cfEF/ijokWDekCmbj/4v4iYHg+qypT7afQD2uWfmmRlk5hk4hBoi3q+Pk+X3h
	 i8b6C3yPZ3WwzxsMek07Naz9Lk922jbjJl2mZ/a7NTfglPut49eBe6Bg/vvRdmDfE5
	 zDpk6n15KbNNoYVuUQ1RxeWa0OMFETm8B5PFDKolY/MPtZxd0H8HHkzfGz4sQrSuUy
	 GQx8bqzS/xE+Q==
Message-ID: <sashiko-outbox-225804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 18/60] mm/khugepaged: base the recommended
 min_free_kbytes on common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-18-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-18-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:20:16 +0000
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
> set_recommended_min_free_kbytes() reserves two pageblocks per populated
> zone to help THP allocations avoid fragmentation. The reserve serves
> ordinary allocations, which use only common memory, so count only the
> zones on N_MEMORY_COMMON nodes.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D18

