Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640586;
	b=LkvTJ5LzRF6RIN5V7PhzsnWIyBWqDIId10dLGrGronvtKwmRxaLTjgiPE8s11bJdvQNJ
	 7/1vqJUzsGV+2RL3r7321a7MVCJPYKCp407XdJK8ykOTa/0rKebkX/eSkVqya9m5HLt2W
	 kkWgw/AsSi+hdLOM6uZZpVtD5S+9MBTI1WyxRNOEgdHePLK+6xop2wq+mZEYNz3/aTzTZ
	 kWnjtdI20qHXYoSz1wEo2PEQ8R8yfk7sapT29QoEHkglZ+CPToz1BadG2izSo3y9PBrcQ
	 eyuIjLyRDJOSRJTGQxPU+LhyfPwhKPlDqc28268RtaEt+PCWLkag4jH7LbHIvfrfqnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640586;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LUOfBM2egg7F2ndk53MpUk6fnlO5pM4JbUQgp1DN4Jc=;
	b=KWmPO9Q/tKql+Nt98ORzQxBNdWjS1GG4LXQiew5qnzvG0psszchR3O+xMrK0TtvCTb7B
	 iWCXTRWtZ3b2FIOmQ3szgzuA8EZl9EgALMM4EDrRxRBURSOYevHnETUQ68+QPKq1rWVIB
	 wrTG3xMjCvEqSBs6FyMro1/CqDbLU9ONvojChG8dV446YRtSPx/KXT8RQKIFYPwYYrXCg
	 ZsiRgZfFLOD5G8NhOb+7Fonk93jEyDXkatezv3W0xUZPVIK/cciBlquoUnrnTHj3VVrJn
	 nAyIuE+wBSg05JM5tdLz1SZe5BEQnxLI6Ejfdkb+OetYOXsj21/LzRC1HBQEZ26Wesw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJlHU1JR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534ED606A32E;
	Sat, 14 Nov 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJlHU1JR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78811F000C4;
	Sat, 14 Nov 2026 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640586;
	bh=LUOfBM2egg7F2ndk53MpUk6fnlO5pM4JbUQgp1DN4Jc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJlHU1JRSeQN4msR8oa+TCJ5gcaX1Hgmza+3NTczTcqLyGEGdxNngE8m0AurVSbXQ
	 0ZsNn6J0S2XfYl8tZJE1TC3mzAP6iIOtrYZIHUWuZpeaewZ3U4nCQtIdFznlVFl7+V
	 tiWlKqi6jkdR2co7CYUZOu03jBZzwQUaQk6hY1SPodh2tug+cmu+HsacsoeaRfL40x
	 2Ii80XDc7IhT1O1Dva47sYUzZe0/43iIQ8iCN9Xiw+zsl1ZiO4FZgbXrZWvbh61sO/
	 181zej7kBGgVCZW4UHqV+fofCDVav7C3KoHUlqkZUpQrHWU1m7UCbymVWZcixSvizm
	 uBeWNN9tW5cWQ==
Message-ID: <sashiko-outbox-214245@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/22] mm/memory-tiers: restrict demotion topology to
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: linux-serial@vger.kernel.org, damon@lists.linux.dev
In-Reply-To: <20261114070959.3490008-9-gourry@gourry.net>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-9-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 07:16:25 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Memory outside N_MEMORY_COMMON is outside the ordinary allocation pool
> and cannot be a generic demotion source or destination.
>=20
> Build demotion paths and the default DRAM performance reference from
> N_MEMORY_COMMON rather than every node that has memory, and do not
> assign other nodes to a memory tier through the generic hotplug path.
>=20
> Removing a node's memory already resets its demotion targets, so a node
> that unplugs and returns outside N_MEMORY_COMMON keeps none.
>=20
> All memory nodes currently carry N_MEMORY_COMMON, behavior is unchanged.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114070959.3490=
008-1-gourry@gourry.net?part=3D8

