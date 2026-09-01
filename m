Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1D12E1DC
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 04:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237371; cv=none; b=IdwsygwZ68xXXyIpvdwfy7sHtD/BqWflgKvwas3uxi5y968P25bWh8oKzipggJj7mlLx0Lwi0TxDF2eBl1Yz/0dttQPbPPrbqIMpgC/OGbF/yI6dpuIja9+dZiesfne0LM7QtKoDMbXuNisco9MzEG9GkOVumgZz5j6LiS/pqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237371; c=relaxed/simple;
	bh=k7xmhoGnsoS6yaXu2CREG85c5PLwxK9HGZdaIRrO+zc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qZ0IXwVaW8dVkg8kCNb82eGWAv7QMPv5Lotl1KpetClukyePLeUrb9IKnpYz+QQPaAIAIcopq4BUasIDpYahjK+uUKXRVMbcAlrFLkZWAKLqRP+u32MK5Sj7JkEIf/R4W3kRMVkn9tswa1RgNDcCS9TnFX8e5E8pD7omDw8P5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOREr3z4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOREr3z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ADB1F000E9;
	Tue,  1 Sep 2026 04:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237370;
	bh=k7xmhoGnsoS6yaXu2CREG85c5PLwxK9HGZdaIRrO+zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOREr3z4RKKxM8zQWhjzFYckeYmWgptT+cXMJ3DsBoQyNAZN5Fx/yafhedLL5Y6/b
	 ZxsA+Gex3l9TUjTSF7ElAq56FZEQBSrCJRNlMq052cx6KyKbPr5aOGMzMWGePlQmHQ
	 G3wdA6wdZxqHbZqgYRj/qQHlHCsET2svyS8LYmMCKHB9/hI0yY24ukPx6moN35qw1r
	 p+8S5xvGfgq+TEEYpP0U6ULPZvE+BS8rlAIbyDQRkv3va98YzzLwN4wK2GkgsbFdig
	 dZATLck57Lzv1XxrPk56JWnpv5H2Xu5B9Yc8zkIBh34lUd8kF1HVbhNtK32rohSEPf
	 SVfMmUewxxltQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/17] selftests/damon/sysfs.sh: test probe prep sysfs
 files
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901043417.2165-15-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
 <20260901043417.2165-15-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 04:36:09 +0000
Message-Id: <20260901043609.E3ADB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add basic file operations test for newly introduced DAMON probe prep
> sysfs directories and files.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901043417.2165=
-1-sj@kernel.org?part=3D14

