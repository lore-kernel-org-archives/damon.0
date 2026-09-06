Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A33909A2
	for <damon@lists.linux.dev>; Sun,  6 Sep 2026 18:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788720685; cv=none; b=cbMrQU0jrwrPoNTDsDJz0e+bxmuVP068J5LjhkxPiSXvyv93H1ZZhQc2hqYsN95oV38kJtHSunspD8OnpVRyiegFOt79eaVhL1XnWI7D2ZXAnU3xsV0ssGayPDEFvGF7YnQ7pgZ1jxD68NdyMjJs8aUbeogrIZEm8U1J6pRTVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788720685; c=relaxed/simple;
	bh=FZPy7VHZPpDe/NhR7G1hooEuCNw7lYLsgVASfgaCVdI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2PlLGrZ0asVY5bH7+Y+ABF703qm5luA1VY+1TNgqjVBCzaszOhS0/TM+9aWl0mewqG7+CIcgXRboAz/Q6743rUgIupFVacDIxR3TBya2OUVfTx5T35mPo1IOBB/8sEvz50C/r3/Z1Zo+U+icoa9sn8NSMh3vGKsUacXuj4mq94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msJR6HJF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msJR6HJF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351361F00A3A;
	Sun,  6 Sep 2026 18:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788720682;
	bh=4qyHvg+D0QKN5Y/HOHfF3xF8Zk9EQaGQJqT0ms/o2cw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=msJR6HJFMZjj5PUGdYKQqkDmOdUXGdAzbKovpO5GH6sxkah+LXEPthoo4dWg3pEIW
	 S8M/0giZA5WkqIerw5O+HURGybubsfjaOcimTF3snDQjeuOmbMuLdx19HWoHiO3X/X
	 Fc3Pigp3XW8MW94mahbdadTxuW12sm3iYm7xpDJ2KlcJ0hrNOCV1iCRVU2TmTvuykg
	 rKPiFPkmHlivMVgveCUd5qU5T66ZBkIYQ77wo87BnK8fNlHj96yua5/ZfDormdyjeZ
	 4Brtxg5x6WcyoLNx6DYSbE+G1aCXReQSK6za72IKoOmoKAEGusqc4rppYTEYEdUDcZ
	 lpVDLH8OGh1BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] mm/damon/vaddr: extend apply_probes() for hugetlb
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260906184417.96621-5-sj@kernel.org>
References: <20260906184417.96621-1-sj@kernel.org>
 <20260906184417.96621-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 18:51:21 +0000
Message-Id: <20260906185122.351361F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> DAMON virtual address space operation set(vaddr) does not support
> hugetlb pages in apply_probes.  Extend it for hugetlb pages.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906184417.9662=
1-1-sj@kernel.org?part=3D4

