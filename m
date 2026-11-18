Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968863;
	b=AQb0lkSfI3MPQfQZYHoNFEnfVdAoyKnuuY08hkQZSYpQ9bp2outjw2aWzqny1XJCdbo9
	 avS9xcl0ekZQP7SqcS4nXW2pjd5Q51xfjRFQyp3FyblH4PudFWFS3s26vCpCwqkooRabJ
	 SWJdpzbDqyF1TzpuFtdmlTK5EVfNiDA1kceE6u0DvcyE8tH6YnMTfCgxXnn3xGIyWfnx4
	 3vVT8RMyr1icUq8ur9ddZL7EGe5s+hZ3CgCHxZ9d13C4h5Ifif3DPPOoNYxwQHKg1cUPB
	 Dsvfk1Ra7KIXA5lZx/ep3tggFuoYBOl+bMqO4yn2UpOy2uJnZpOdtx9Qo2t+oRZJQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gY332GY9pcZc7Xqz/xx9ZfA/+CpNwLxMYP+nsBXTtGI=;
	b=J10wx8xLhlVrYsKdVAzHCN1kUnECCGFQ7q2OHssnc2Gv4lrqfeH+v97hm4kmYvtslazY
	 10hDCsDo4wHpj3Rf7DD85TJukYhxwshcaQvCn/1Nhl0IUkxaJKQn3B9SzEHK37BsyDLDG
	 EugZZOP7+no0U1MXP4eOb2RjxD2O0EQ/Jp1CQC4nPFKN3DNq6qD4+0F+q7VCru6aAALY1
	 OQJ208TzXLQS7wx/w8wZ8YmOF53omo873Feav8ROYLi0QBBcfWVaJEO78qeRbTSSLFw2p
	 blxoddp17FTPUyJKigupXUqadU/Mdqyt4szcYgUBMR0GUWXXkNKLjXQN2WtxBqjSTeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBG6Vns9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4412606A32C
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBG6Vns9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5BE1F000C4;
	Wed, 18 Nov 2026 02:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968863;
	bh=gY332GY9pcZc7Xqz/xx9ZfA/+CpNwLxMYP+nsBXTtGI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RBG6Vns9HUH55F3JRn/ZAgH5Bvb3chdCeCb+6FicJsG7dBBrhxxu4DTtBvciMbM6D
	 LNKo4a2RdySHK5TmF+7yKZJQmAjUQbpPUbpW+2eb8JArVhY6D35jzLXDAcd8WiMLMA
	 VugYBykMPn+s2NbWP23a/e/dQNGOoCNwqIU7yFt2V9hSX7C/tYuBa19dYjshx50+3m
	 jfXlagVbuAZuGvYFjSGzF6OdQ7BKRThtdb7z0o7N0UHIKp3Pd9ln/0OZ+E8Bre/t3U
	 RqG4no/xeJ/ks9RVRru+ZGZ4KcjYvJBdUiaFgzutZxIbEtopiBWX0oAssKAanJKwBy
	 09/v/q3PTSaJg==
Message-ID: <sashiko-outbox-219950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 13/27] mm/damon/core: introduce
 damon_report_exist()
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-14-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-14-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:27:42 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement and expose a new DAMON API function for searching data
> attribute reports from the report queue.  The purpose is to let
> operation sets use it for supporting the REPORT_MADE type probe filters.
>=20
> The caller can specify the type, associated memory address range, and
> the creation time range of reports to search.
>=20
> The function uses CAS-based try-locking for the mutual-exclusive
> synchronization.  If any parallel access to the queue is detected, it
> forgives searching.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D13

