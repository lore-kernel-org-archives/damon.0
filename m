Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198875;
	b=zsGNCMndohmgDtf1SCRw46IxuVxJWighQ9ANJDp8bpboYpEa9tuCPc1/BBfRbkv7PfOE
	 ALCy/SShl6F+AhtDlan4dtyb13WkeEIRppjldVF3ZQCWBlheUZ5Mw+SIrOd329tRQ+Fpo
	 RA1nSax53gbsOnF8ziX5CAqiYb+qrV3NDn9BffDNb+vFMiVDIYvKWI7MUYpN65mR/0n+Y
	 qWHNVp8EB6JXMU9cUCs9CutOijugq76vKO0pnQMlolikBQBHV4xcDF9j5ao/75O3NpiOC
	 YeK5xt36JekLVYCEfQf0HIcjrlMT2lCl+WQrBJuO7HQqK8Jo76kkl7spHnnOF7l7Vcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198875;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GhLH7C29PjFEOhRq4L+ykixzfw/29jofHvh8CxhMtyE=;
	b=GxyobdY40lzEuTLRbfW01JQrBD4sMe0/cfPKJgB3LDOl6g2EYhNpzqtiMRFQrp2GKtbe
	 Qtt5+IZucp8CEXw+8z0Ih0jMFfMsk0ZHnsnk2MHS12Y73REv7dGTYBcMfPT9k9+XM4gpG
	 jYqyT28EGu4n/tKZR+vhB9sjvukJpu4EUmEan+475i4nIOcmcSoUjaFWa3eudwD9DYIFW
	 ymxwfA0PK2DyQ6h8o7n7Fit3QLDYP6JP8h86vlXccV/IDn7jwp6gKw4P79pr3p/w8PBh4
	 X79AfBQ0NFTeAexwAyRmB9FB93TYz1b6BSgS6q1LRFZ6rrj3cOjnt+HmQ99QsAD809A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+nYUud1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E33B606A331
	for <damon@lists.linux.dev>; Fri, 20 Nov 2026 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+nYUud1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9251B1F000D2;
	Fri, 20 Nov 2026 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198874;
	bh=GhLH7C29PjFEOhRq4L+ykixzfw/29jofHvh8CxhMtyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M+nYUud1j5WjiUlWFqtE3d5rZAK4F1BuArwbwJIg5NglALlmpBYIOOyrTff4hA3Yu
	 /Hznf/wTAz2FjEsuWdLU0pyxmdtMRJM3HK7/k3mUqh7ytXc5dVsw6CSqn24Qu7zoDb
	 H0PhxRSJ1WLa/rwOrZeFluXh/5lUpvgssvmRWsAG2+KegIJqRl+h8PpG8bV7tF6ozZ
	 k4RN4u2F6Mz+08DAPgawLW27PSOUIAmVs0zpnyxdo00FmUfP8pNDyTL9fMfUDdnAjE
	 io17gaW/MisyiHnFaeNz+KvX3l1nYw0l7ds/mOMjlQdYU2EWW2I3z6LLa+H5soAw6Y
	 W+HmBJEzm2BHw==
Message-ID: <sashiko-outbox-225808@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/60] mm/oom_kill: compare OOM constraints against
 common memory
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?R3JlZ29yeSBQcmljZSAoTWV0YSk=?= <gourry@gourry.net>
Cc: damon@lists.linux.dev
In-Reply-To: <20261120-private_nodes_v6-v1-16-74f5f9a115c2@gourry.net>
References: <20261120-private_nodes_v6-v1-0-74f5f9a115c2@gourry.net>
 <20261120-private_nodes_v6-v1-16-74f5f9a115c2@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 18:21:14 +0000
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
> Ordinary allocations reach only common-memory zonelists. Compare policy
> and cpuset constraints against N_MEMORY_COMMON, so nodes outside it
> neither make an otherwise global policy appear constrained nor inflate
> the constrained capacity.
>=20
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-private_no=
des_v6-v1-0-74f5f9a115c2@gourry.net?part=3D16

