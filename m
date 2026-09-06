Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A336B93D
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729092; cv=none; b=IzehjtxtTw2MyJ6PQhcvCnIWawA0RugnfJOPKCmVwukiLzWD6wFWm0UuYZWESYrlUi5pQ8lfePuTD3fD6VMvucT4YDDb+l0M9EVyOaCPt8pNecbCAlURRvB5XulYbSGMyb782gR6bMmLT9YSjp9EyQRohaWRUrQCBT4ikXTvZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729092; c=relaxed/simple;
	bh=sy3ljFICQl3sIW0hZf4Ycax0ROHwUdmEzWotBg2Lby8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYVfarhor8rR9+tumJa/gUvlHlMQgE7jDUjlhabTuXftGAb2osnCL8wLpdTVz6CI48oL/6t/TsMT8icgCcG/52tU7Ep972S1cG5vBvAVn3x6dWMKjxW2R8aXtEhTFnfxklHJ4oLHtuqBU9jmqzY9qYIjzljNjzcSln9aZAqmSmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5M0NkBQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5M0NkBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC13A1F00A3A;
	Sun,  6 Sep 2026 21:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788729091;
	bh=sy3ljFICQl3sIW0hZf4Ycax0ROHwUdmEzWotBg2Lby8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5M0NkBQsOvlcuW+gANNYxZmfvglv/W2T/jh24d7gdsEXCHnT1aZH6dOXVfZuGdAU
	 3r6dmtlM2Ej3AlXm9tjrH2AlKS6FAb7YM/6/CSxq8LaBDy/jeAo9NMSZVLYpx0qcnv
	 c+HFsQJ6aTdPNOBVbZFKx2ytaPwLkmLAZtayHVfkfTOUtwxJTmlVcuFZ0TItYcp7f0
	 CuPfIHybW0jiDkmyf+VJfB869PCP0j3Cz42TnjNnUz025u9RPUEuaX4hVYfKdA9RR+
	 Dm3zK96asim3xuh442oGkncIr+C76OngpZhsIS4S1i3Nuoxnw5sL5wrRUQKDnRIBcj
	 7Ir1hwnzVpcKw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/6] Docs/admin-guide/mm/damon/usage: update for
 probe_hits_wsum DAMOS filter
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906210513.106895-7-sj@kernel.org>
References: <20260906210513.106895-1-sj@kernel.org>
 <20260906210513.106895-7-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 21:11:30 +0000
Message-Id: <20260906211130.BC13A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added probe hits weighted sum
> based DAMOS core filter type.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906210513.1068=
95-1-sj@kernel.org?part=3D6

