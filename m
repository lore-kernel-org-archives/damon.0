Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747057F736
	for <damon@lists.linux.dev>; Wed,  9 Sep 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963103; cv=none; b=Y3RAp2Uc7710nX5chtuC40NptRZwcXupPGZShgItsfiwIgcVlsBUjWl4ZJi6AbalR6t4BJaDrtrBzfKferCDeu3QjlHAbXDBEtkYCVYonyGbDxtZtyPMY11rL9Mnz0XX47mdzzq3PNTOlcXpyhR9e6GdS0/bpw3N3Q5f7acF0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963103; c=relaxed/simple;
	bh=KWr3dHWYpWBqyyV+XiI8Dqj0/xb545q0Qi/oIDQqSr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzUs+r4vqxOlzWoO1YKzkl5K40fjoZ8R2MpAiZyFVmu4xFoejWES1bjapHh8zOlGbhcCdwQPf2MyaRv0l5uuuvKSXYePwY/m/LlsrU1xcaolbtyB0TFhVpMGfC1iXZn10IaDr4SY7mW3j888VqJiWldYmqQIjg/mc7JZKECrP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG6xdznu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG6xdznu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0507D1F00A3D;
	Wed,  9 Sep 2026 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963102;
	bh=XyR4PRsgkIBdVoqylzs25hxPfEfIPFdpfePXjqBI6m4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aG6xdznuTx6tOQHrJf5T7CjzffP6WoksOyBR83vZDVEWM4p8ltkQjmAeZApNyc8Ft
	 FRqSEuGCzo5V9bJka6ZLDpzgzaF3bmZo4AqREYEiTfG6ajb7VwDPw8J8KYebJw5R5C
	 Cd3mj+ctZvNg15Mn3LfDEYI4CUugCHQzv1cQP1BOqNOsjXwAD1giVx2RyhUwylcDJZ
	 4ruV3DH/oV4UEftQAm1/kpJz4jYaXD9mzP0HBDlvKVUImTz+4XxJHaDSG6DwH8d+xE
	 Kq+ZHkatq/F2NmJsU1JUV1g2b+IBssdi6z4w82t4l1/Q2m3vcDeVNIR5GlpQExhYco
	 XKFGBTSzcXkSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REPOST 4/5] mm/damon/vaddr: extend apply_probes() for
 hugetlb
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260909140408.104699-5-sj@kernel.org>
References: <20260909140408.104699-1-sj@kernel.org>
 <20260909140408.104699-5-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 14:11:41 +0000
Message-Id: <20260909141142.0507D1F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909140408.1046=
99-1-sj@kernel.org?part=3D4

