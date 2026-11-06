Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793931105;
	b=bl7b1ef54Tp5cQRmR1GxJB9hGc0Fi7ycSJPb5Pg3B6K4/qAsf5wms90GYDPJVJ08hQc2
	 yirszWnw0hIXp3PoUQstznZgLhHc93vnkgPsndOEHP/hMiJw5cHond7uHze+sdXdNnRVM
	 gfP2LcJDFWZcC+WJgtEpGD9q2kfj1tcip3NPJ98xX4DsHf1f3hQokrFc4uDCX1b+ZYeSL
	 9boq77LAljAIlvgmljVitoKCkuGesypU9cv63lYcyiizHG1ySyhgZ0BMaHqgXqUIkumfo
	 /638+BTJD+llOvd1YpBVHDPDIQRZUC/o6+9gVDVQRYMrTdYyQhJLjEg2gdRx9wcNMGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793931105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j7w4hsu1rdlzotmh+Qz8xDKPH2UMHLlggf+nRCIxSGk=;
	b=xjzFdcnZfLmhIdTHWm2Ova7AS1PymYJNFb1LdWLjZ6bBDIBQUqhyQX2VxurecFH0HgzJ
	 UFYDKMqghIh6HNSe9pxL4szPb3xqNJLybPoNS3/yjG4cY2q3jbV0pWlx4bnFf1gvhgKSy
	 HFl+tXsM6ekw9IQyPuT9l6L9dRtmAG+TIGbLe/ob6kwZ6Qzll9NdFGSwrHbAtWHzdD7vl
	 2fyAWL8MoYQ6iTsPtjunKFMuf4AnTaiL1nCGOZUDFyiP8DHFvSOX/K2G8PgOjxvSlA/DS
	 U37bBfyJ3KJGaRMuDgKBivN0kL9RpZwag23BHpIbFlIgvReGA7qw/3ebXf3OqFhrDYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YwDBb/RW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D047606A330
	for <damon@lists.linux.dev>; Fri,  6 Nov 2026 02:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwDBb/RW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA961F0089F;
	Fri,  6 Nov 2026 02:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793931105;
	bh=j7w4hsu1rdlzotmh+Qz8xDKPH2UMHLlggf+nRCIxSGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwDBb/RWIjH51DOgmIhIjPp1B41pZaBWxTKnFWzk8iMkCqhBT/7xgEDCkveGLwAsC
	 7uLAeRWW94Hc5P6JqsA1uIu1tWFZkdiPmSSM3Sof3ACcpjkJgUgdDe/O54ZoVOxsxo
	 lnBoJth/weFv1HW4eOcmzpo+5SVa5Bcg24RWXa4LRViECC72C2MfgNzky8Ai60Lroc
	 iQ47HgzmQe47JOICckdD////twjN0IxlDeq9dzihr/naTGBZbrKTOnojW2IMGaAt+N
	 uzfQTOxOTTf3kjO6tP/CugtbHu4R6CLAq94Z5hteU6spqwyvuKPrbhvw4erIksBpnm
	 wEohoXTrPoVYQ==
Message-ID: <sashiko-outbox-200582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] Docs/admin-guide/mm/damon/usage: update for age_ms
 damos core filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20261106020559.98352-5-sj@kernel.org>
References: <20261106020559.98352-1-sj@kernel.org>
 <20261106020559.98352-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:11:44 +0000
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list

> Update DAMON usage document for the newly added age_ms DAMOS core filter
> type.  Add an explanation of how the age range for the filter can be
> specified by the user.
>=20
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106020559.9835=
2-1-sj@kernel.org?part=3D4

