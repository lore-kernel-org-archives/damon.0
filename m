Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A803576EC2
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962997; cv=none; b=XowrSYzNUCx9RAKOl7JOXpTdKDQfhxequ3FN31NP/2h0VwTleI2jyN0q54nE95p3wbqAwy4gWhYgv3ZRNGuLu1wuMFzrLLVBdIBX6nvdi2GKnfU/vKDMlUU4YvehwuUVCCUxDrIXgEgXxVcQ6+ONwvsnBIgURJw1JIHJzyXbBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962997; c=relaxed/simple;
	bh=R8EbR8r8RqhqUGtWS4s9lAUlA8gXa1oqEZZ++ifNbe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JTmlPrS4aK0FL2neAEdEFWEw963Se5yvOxEwYOwfwPfFfJA97YylYXnV21gpYsMNRCrgsax5dfWYHlsHjX/5WFdQPhjGUqXuTZLG/pQjkyFf6D7fVRKBnI+FNNdVsMKp9VlXp1RZPrzTpuxz/d/yIPU12HHbk6Sqa4GCt2KVcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBFJJ9TK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBFJJ9TK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F251F00A3D;
	Wed,  9 Sep 2026 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788962996;
	bh=JjazqQfpzcSEiVjbjp9lhUpIGvRVp3VSoS0VljNsacQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WBFJJ9TKulXArFtUpLvZbTrquGbicANPp4s9PF06f0X8QCzB+Y5lF5By5S+hFcyKs
	 2BXB2wptbqhA4h6dAdIhHJoE2mKsu2+EJdGVQTYbqNEDp+fJDSR+twMc1AMzh8gnmI
	 DxFQzaIjzU0W+Pdb0Sp+DroVLflDOVHRgfDRwPnwDlMleVjl1J4Fb8ocYA5ax+GA6p
	 IDoVbr9zIiIp58NLNzuoVvV+gOWRrRXb5Zgrre2ke9gTDe/kns6nEtQathIlVpl+lL
	 lw23/gI+PA0XZbm7P9zeftXcpH1mCs5c95Wxc8NgX5BbUXcF2Swl1DRiJwDuaQrYKT
	 OKlSRCfx5z8NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REPOST 2/5] mm/damon/paddr: move probe filter handling
 to ops-common
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909140408.104699-3-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
 <20260909140408.104699-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:09:55 +0000
Message-Id: <20260909140956.07F251F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Probe filter matching logic for anon and memcg type filters in DAMON's
> physical address space operation set (paddr) can be reused by virtual
> address space operation set (vaddr) in future.  Prepare the future by
> moving the code to ops-common.c
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909140408.1046=
99-1-sj@kernel.org?part=3D2

