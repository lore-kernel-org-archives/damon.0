Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198910;
	b=M+Q78rtg30lWnneXvaMD3VEUnu5qOY3DHjM8JhktFIoaB0x0ZOjP7I7Zt15V5ujq5P1H
	 7KPFDqlEYHfmPNooZpk2Gu3OLKVl5V6cjB371jk+9LHJheoTQZfWDTKrZijA3HejI0frG
	 u0NvrKWStTxoglv7B7HpCdbQofPj3g/UP+3REH3bqQuYCvI0OHuCX0h1ANYcp3Siy1v7C
	 0kgjZdAUDBKsy0wLHkMuc6PnO7mWs0x05ai5ziCYp0Ft195cb9aTz61IO0+p4emDBzrse
	 OLXTEzyL1NUrxqlNf/va6Xu7m++sECsBedJtO4cnUhSGAkPIELGyY93rYF+x3s+rpdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DAnXEatxiitrWdDv3eTVYTtBAYCl0cq8l7/ivVF4HaU=;
	b=lI07kGXEN6cHC0vqJnTLLTrwVBP/gq7jfxOwtJS1GrSwNJyEmhRwmFt4SfSOQc6o0i+O
	 VQM6geuJY5ajr3wh32eRQVTjH6gIcUz/k6lSLCp/Ni6Cp2rPGHT3nu/+FeDtQ2vMc/zpM
	 Q33bpHfbq6maWhcjXdfc6/hYrN7lJ+B1+uvhFxFMAD3rbTSiY0lDCHCaDXCt/yR63JIS9
	 GFrFVZkYivj0pm8PMVMdt1xZ3xgNE9z/APMN3zuRt0COmAHgtjgZEtmD3Cp4mKIkuU/I8
	 h/4NPx9I5ONXCDoqzpDpDSOdpeDLBXz+eoXtzgci7PsnfvxmKTLd3ErdDel8GMuUoog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vc16Wt3V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEED1606B447
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vc16Wt3V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1311F000C0;
	Fri, 20 Nov 2026 18:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198910;
	bh=DAnXEatxiitrWdDv3eTVYTtBAYCl0cq8l7/ivVF4HaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vc16Wt3ViJuUzhLMVSyf/XRh9AI1+9oVzShpRxBGB+9VJbaZvHvaEEBGp0Lao3P7X
	 zC5Ffw11BXOSsyXUWM5SuzlVQloMmu1P81KEyc4eBVRgKZ/eHTxVkURYz6Df+08vvp
	 Kc/okF+yak7dxEqLeRe5PVR0gCsJ1KU5guQr9zo9W3zgRNMxzOJWcobtEnxZkHMvRl
	 07MYQct2iF7teFxJGKiM/kzmDVmRlEm/iOmWICXal/vkI7cw1ojiDECoGZ6VDibBoV
	 6NjNE7WjHr1efLltELQLoFANrzgfZbN0dB9EeEJ8Mv1C+04KM3wxF1F+8zLnwu4y73
	 eCsRgLIXYUoVg==
Message-ID: <sashiko-outbox-225813@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/60] sched/numa: restrict NUMA migration targets to
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-10-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-10-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:49 +0000
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
> should_numa_migrate_memory() refuses to migrate folios towards a
> memoryless node, since the migration can only fail; see
> commit 3fb43636876d ("sched/numa, mm: do not try to migrate memory to
> memoryless nodes").
>=20
> A node outside N_MEMORY_COMMON can have CPUs but has an empty
> __GFP_THISNODE zonelist, so a NUMA hinting fault from one of its CPUs
> would isolate the folio, fail to allocate the destination and put the
> folio back.
>=20
> Check N_MEMORY_COMMON instead.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D10

