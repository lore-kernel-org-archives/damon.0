Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197752;
	b=0XiF6kwd9MkLxZGNAX4nXSKOruM9+/xz1nrHuqKtihA65x30cr0ltiItLS9Uq6d3zNRr
	 iF9xl0RFqkP70s78BaQ/Zx1XxtZALPIJd97pLMRhih17DH/UR9VKrbWt6qarxI0Y4VHWh
	 U0qdgsYWnQ/nftX/lwmOk2mODk4JBR8T2ZgQbmGL8phF4oghJJpO2kEH+NSCjK1eZPoa9
	 yiX0cD+2co4k/RXQUhzsm0876yFDXO3cHrEQHPLF3NQuTx6vo8mbFTS8MBE7hLsSQXLcj
	 Acn7wHWyvhIurNU8dYO6A9JN8mYlo3vEdVYhl4tgqBi6ipqRECdHYfC/RCHAY1tKuqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197752;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0bxiD3xp3eaQLbbhzO/nYcj/F+3++dSURd2QbPhU4QA=;
	b=2dev0j5hUYxisZgscdd1YNu5zXX/kQK3zc8Ky1+V0dGYZtS1ltLTQOBEdnr/1ai3rSa3
	 r74GQmbVAS+lTP3a8qshsndyOu7Kc6I6DCgj+Dy42fLMnFFHwyF3awcxdWbHqs9tYoUPV
	 JYwRNzSONoPr7/Hm4mgpJCUHv7KnAAcnQ7tPDt2TQAcNY5z4DivJHZaZoJPpu/YQ2kkr/
	 d/wt1jAkGsWkp8ItDnqJvQJqX6qBPb5sTUn4Ylihv0/k1ySNnce+CKvWG1GCKPwLAzKmJ
	 gpNaHIgqtSYhrOvqVTZ1IEwbczqANsv4nfvzQy60EwvkuwCV5Gl2SBErlSULfO8C9Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8JG2Xo5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FA7606A31A
	for <damon@lists.linux.dev>; Wed, 28 Oct 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8JG2Xo5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145AE1F01825;
	Wed, 28 Oct 2026 14:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197752;
	bh=0bxiD3xp3eaQLbbhzO/nYcj/F+3++dSURd2QbPhU4QA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k8JG2Xo578SfwhbWjmUF0RZ9AYfW9N2BUuJ8iU1WrVkYAk997Zg2x/B9+6SRLXwgt
	 G2+pym+MJ0xJBDM/PH4kn0tNUH/l0v9MB7gmCZT9+QGlhQZQq1Q0Q4FCzg0sQKGCWk
	 cAMlFFpq1vj2HynEz9/Uy1FIE/CAEoD1y/corehgOyVaLmd58YSvAdi/+m6OtCZvb/
	 uv1ykKEnpr2vezPhy+oPvKG1BxvRVBmo1i5UiwaECxJ1lbTCccoeGzsWmBr5r2TRox
	 FQKQD0KsHeAEBEfzP681lTiABBYh9EbU2hcznwWIzgwnFuT95szIqwdP1sPRBgFOkK
	 xGF/IXUMI1UWw==
Message-ID: <sashiko-outbox-187983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.1.y 2/2] mm/damon/sysfs: put target pids for
 apply_inputs() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261028141723.161776-3-sj@kernel.org>
References: <20261028141723.161776-1-sj@kernel.org>
 <20261028141723.161776-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 14:29:11 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> damon_sysfs_build_ctx() invokes damon_sysfs_apply_inputs() for setting
> damon_ctx object with user inputs.  If it is configured for virtual
> address spaces monitoring, the setup also increases reference counts of
> monitoring target pids.  If the setup is failed, damon_sysfs_build_ctx()
> deallocates the damon_ctx object without decreasing the reference counts
> of the pids.  If the failure happened after increasing reference counts
> of pids, the pids can be leaked.
>=20
> Fix the leaks by decreasing the pid reference counts before deallocating
> the damon_ctx object.
>=20
> The issue was discovered [1] by Sashiko.
>=20
> [1] https://lore.kernel.org/20260730040740.140836-1-sj@kernel.org
>=20
> Fixes: 74bd8b7d2f8e ("mm/damon/sysfs: move targets setup code to a separa=
ted function")
> Cc: <stable@vger.kernel.org> # 5.19.x
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028141723.1617=
76-1-sj@kernel.org?part=3D2

