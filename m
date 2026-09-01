Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0DC3D9DB9
	for <damon@lists.linux.dev>; Tue,  1 Sep 2026 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269855; cv=none; b=pq12h61kovOhIBwmZ5dcl9EcUePGT0rlWlLZxWxtvLutxma25dMt9fplslLLLVHkNZy0pNH/sFR51y/Epfc1nTA/HBjKPPAG7m+yxIaNs48dzbdqNzE0KpmLkpM7T8MG4HXUqOwlFP0ppA6Uzv+9ChXfIMqaXzax65dUKL19qrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269855; c=relaxed/simple;
	bh=aa7vklGh1/xBaX2YV5448P7PugeGNg1zo62ABFicMig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfX43C45vDIMkg1s4mJqmHV5RU2eXWVFWyTGq7cts7fMNqKMSz8qQY28xt/1+aKTt8ssnTPjlC2pD151DJ1n7xhuc6K105wt5TMMPFSEuSvlwk4TgfDiAaVsjr+57nmiTlqF63F0FW5iaq0FBZH8k7er105nBeNYHDAcBRfLxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiU+Tgye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiU+Tgye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9526F1F00A3D;
	Tue,  1 Sep 2026 13:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269853;
	bh=aa7vklGh1/xBaX2YV5448P7PugeGNg1zo62ABFicMig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TiU+Tgyeszhx3laiuoNDUY/XwGCF142qYyEf24LPVM/AY3/OaKUm8EMpKOVyDvaKR
	 ndoNP5bEeeO/Cht0rA6v1Q++TkRnfpVGNrnJa3m3LmfD29D0iG4TSl6civ1l/dVPGK
	 bSJ4maFDDis6kXaHmMUsqU7Iz6Qox/3ruG9l1zMFVOyn688U5kJnk0u29EguDpnOL9
	 H9fBpKEtqpS2/ZwtmdmzBEhtVNGqQlP2vxL5hUIhSSPLQ8S5Crn9yVRPBvcyY5sBly
	 iEFBUHz3HuzAoOAQYiULLJ4jih8UaqzRvG1sEyHFM3EsIi6/uMoWo/2gJvbTluh+tL
	 qXE/dWPFLk1dQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1.1 15/17] Docs/mm/damon/design: document probe preps
Reply-To: sashiko-reviews@lists.linux.dev
To: "SJ Park" <sj@kernel.org>
Cc: damon@lists.linux.dev
In-Reply-To: <20260901132506.99243-16-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
 <20260901132506.99243-16-sj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:37:33 +0000
Message-Id: <20260901133733.9526F1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Update DAMON design document for the newly added DAMON probe preps
> feature.
>=20
> Signed-off-by: SJ Park <sj@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901132506.9924=
3-1-sj@kernel.org?part=3D15

