Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231ED37C11C
	for <damon@lists.linux.dev>; Wed,  2 Sep 2026 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788358297; cv=none; b=GjzVCbQXDQ2EsGNBL/M9HGpryg1+JaAaazEyx9emDDgWvfGU969OljxcGgqJZVv58o89OTrLBzupqQKhsNSIoUxlqe6S0DFOpldrJS8SncfmZIEsxWArCap8iyqLEZDov6wnNtAom8Jc2dxDxwkVaGCUX57S5lMOL05AgJPwfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788358297; c=relaxed/simple;
	bh=CdFg6cf/iEGXmebXkKsLLbQIkjdKVK5wBy3AlCAdw8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XsNhqo3r6oon7GP2nPEop2xtQCtS32ZwuqSvnM+Ql1UY0pTycHDXLiC1TJltp2uV5dNQBZFG7xIM9/aFCfcXw599WaPxxhVQe67+RHSMwhjFwFimgM83Hp7/kGmBgmdGs10rRPPiuvCbmy3QMVhWsBE2DEt0JlFVORENFsWG+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoBuGYfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoBuGYfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FC81F000E9;
	Wed,  2 Sep 2026 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788358293;
	bh=CdFg6cf/iEGXmebXkKsLLbQIkjdKVK5wBy3AlCAdw8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EoBuGYfwfkZRz5IkhuhbRqh6BATjJ/4HCxm6uXefqK0vWn6H0SJtSQ59K1eXIaZVt
	 Ccq9BOspsb0CIhvSx24OSL7YH4uwZxUoT02kSxZRhKCVfWYdftHJ8KMnUg91/WySEs
	 7as6kX960EipnCyhJSCcN7QY2n18ILQI+Uw57WKJaBacjLnZqkqW9nptcFfhMUC3L4
	 keBJFAZQtYKuGhC774IRpr2VkefBb1TrpzJlDewdy98u3l4IaGeiHH2P5u6vJ4AVb9
	 tuOQXMGvjX809s8Xxjr3k0kRds2af7Ef7DAPeVzVPLUICAgMNQWpMU+D1ePdmsVbIM
	 6W38MoQK34oNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] mm/damon/tests/core-kunit: add
 damon_commit_probes() test
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260902140313.85983-3-sj@kernel.org>
References: <20260902140313.85983-1-sj@kernel.org>
 <20260902140313.85983-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 14:11:32 +0000
Message-Id: <20260902141133.66FC81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Add kunit test to ensure damon_commit_probes() updates destination DAMON
> context with source probes as expected.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902140313.8598=
3-1-sj@kernel.org?part=3D2

