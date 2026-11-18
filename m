Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794968964;
	b=5RkZvPgFvtUEUUCcN1mULKqkH9qgYqYVvZPdm+JudXKFbhkRdF0314inVQ5LP6JF48oH
	 B/mhgRpf8GmUIs1bIqIjPpMUDMKYEz9JyNeBi21IZcBqhFEEUqg/Ou2tuTrtWOaRlFwHZ
	 bTReep+Mmp6ff3d/OjAizLb0vvzhLndh9ZCFDi+zDl1PbtIn2nxhzRnF575Ovqp9gZEn8
	 79mm1hwkgu4wGnZuzUlhtosRLsnTAOJVR6OqEPq7OvZ3VD8AnXZHtZTyUG9v78QWhv9E7
	 7JQF8D4lzsQqM8JxCnjh9PZ2eKEfg5M9S/p02n7XPalgaQetjk0qQGia4Z8E0AfB1Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794968964;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7AOOGsIiBixpyuMBhryLdDRyBmWtxca4pmXq3GcieP8=;
	b=PsegR9jnTitQf9sdx6q9ONnf/5Crso/aHTytQsqgzB3pSVbgPK7e9NSwUZiJFxdF2nB9
	 NP2fjV6rKKOHti8ycECVwHDAjcZMmAHnFnCI7JLto1E8pS3OT6DXHFN85QiqozigSc0rM
	 EVkex4J8xcyzKh76C7q+VRNqE5JQPxI+E6yLMnLxi/y5XRsiEwFgzXN5DzzhNIOYEMRim
	 g1XqUjlmf+tYHlcpaCmAPX9YTvr8hltFWkZsvq6stpdo90qKPZwNijZXu/xnO3yKiemsE
	 hJ02/yCWsYa3UEFjydFDKJtEQK/dyKL9JRNtwQPuB6lnFelhRg/WWrcwOcylPCnh5UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCodWnFA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E5606A32A
	for <damon@lists.linux.dev>; Wed, 18 Nov 2026 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCodWnFA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A741F000C6;
	Wed, 18 Nov 2026 02:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794968964;
	bh=7AOOGsIiBixpyuMBhryLdDRyBmWtxca4pmXq3GcieP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCodWnFAb7HolHuv1bwGgK8x+cEitJ7GMOrXsGkMS/YObKBGfhgQH+xxM1T8zsPbE
	 LtKw5erwLF2G6Is9PuvHwfTXew7mYrfBEpQNbtPw2Bj4HLvHx/ryOKj0p89k7Gxyqh
	 ueiHaAWSAtyi1roHlIyl0bqBe52WFRrB1gJ6j3el9ocK/JJPi+GMnuMTjDXkRSNv5h
	 Xfl739rw7B+lGsyAkM01cBSZ53k6eON9AjQWDrqRMjpyWVKRIuxS4lkmDtAiatSyTU
	 2r92pkLs2dHbhU94keerqS7AkM9m9Pklj5aovPLI+VfLO0FtFjSvwWfDKi8DL7LfYi
	 IVCllyOlqcggw==
Message-ID: <sashiko-outbox-219956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 22/27] mm/damon/sysfs: implement report producer
 addr_{start,end} files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261118022225.100659-23-sj@kernel.org>
References: <20261118022225.100659-1-sj@kernel.org>
 <20261118022225.100659-23-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 02:29:24 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Implement addr_start and addr_end sysfs files under report producer
> directory.  Those set and get the address range of the user_report type
> data attribute reports.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118022225.1006=
59-1-sj@kernel.org?part=3D22

