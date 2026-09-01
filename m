Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E64CCDC2
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237503; cv=none; b=h2wosLoIL+hcd8cJxwlrYL52k1/t41vojTdOZIIbSBj0sjAI14CUsHBH2WYvxOzn9+bolP70SE1c2QUM6rqB9RKBTgbLLMV+o38v8yz2U2GS/Jk5tkv+QA1GDJF1sjXXTTqDU/jTvcBmggwt/LpBGlJtDMTanDB7dTBYc8PXWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237503; c=relaxed/simple;
	bh=ibGOQTBBVDuxIlEJfMD8jxqSQilOg5p9Yk98AfOzGDw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DhEuFWG5fKE4jPmghcTGlJ7raJ4wuUwsVYT2xyMYhErxnHKYn0Emc8BfXPEaoknGAN1R1pQ0qb21kMsJXBb78106GiV4QlOf80XOolKw3KejuhmUP34pC97yZRm5kooKS1XzSpJu6tMw6X7UlCElpYMP5a/nRTVGFqjvpd8c/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLS0H8bL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLS0H8bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C6A1F000E9;
	Tue,  1 Sep 2026 04:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237501;
	bh=ibGOQTBBVDuxIlEJfMD8jxqSQilOg5p9Yk98AfOzGDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLS0H8bLSJszFN2e71YIMo+je/ZnP2sPg0H9w3nGHqW3w3APwQp6hBQ/IW83NBjGh
	 gBwv9Pv10c7aI1kwVh6Y7gEpoU37zSi76tzZ3tCAdUADDmuZD5dDwzcmkXiWVMcbXr
	 AgQGESpCRTONtUxna0EcpLVw9Eu/HNMfu7OZP7AMq8lepmj1Hanf810965Kg994r+m
	 X9hzKgtpMHBlj3Gh/75OEt4DMVQJ5nIKLecityIECs6BqCYHVB/I7JLE38RVMOyOMi
	 8LxNCbHL8xnqSTqpA0Pqmln1pozHIM8nsDeYjsg39w5p2w/TcAupwRIf0R5jX1l+Hi
	 Vxm9o5COda9eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/17] Docs/admin-guide/mm/damon/usage: document probe
 preps sysfs files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-17-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-17-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:38:20 +0000
Message-Id: <20260901043821.74C6A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON usage document for the newly added DAMON probe preps sysfs
> files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D16

