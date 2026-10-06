Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFFB3D890F
	for <damon@lists.linux.dev>; Tue,  6 Oct 2026 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791275932; cv=none; b=SgnwcxXrmftv5q+yo+OzNyGwovwtsttUm9Bb45yqbfYa/pLiTxFKHHHGsBFrPPPod75kAOg7nL4hKTbjOg8ADfCh/5SnPtAErJlyMJ57UM8ol0l1vreGByTwwN1leBeqJYmLn8lbauxqy+PB+YfbtNYDLDES7MIOhObvVSAIwnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791275932; c=relaxed/simple;
	bh=S7mbjJsdOH1y6cZEHFsKN84sSmvjkVA8r40kT4OvmcQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M0Fmym1a7Ay+k2pjicTNpx6YVPqBVZI2beIARYrnpCdKtF4IAK6b+PmbUNFQqYMfwwTTBKiUbAaz4/Yszllr6zRyvtU2hgO9v8N9P8/BbDXhVBcrWbmu8Px7WTR89pkc+lLFQ8pgbolqlJvtTsLPXqZi5asenwPC2W+lkeXLuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=iigl/7S3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iigl/7S3"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hzV5t0L7fzMlT6;
	Tue, 06 Oct 2026 10:38:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791275922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7mbjJsdOH1y6cZEHFsKN84sSmvjkVA8r40kT4OvmcQ=;
	b=iigl/7S3287vT3m4CcJM/cC+eb3MSdf2VrRcV/6tNkYERSvUJfOAQyd6vG8Pip1ytelUuT
	rcGTp7e5kUgcOD/R1L9vaRYprUGUdr5tYw4ghxJWp96rOl+8DwWAyjkJ8MRmKxJDI16rHX
	gso7NJ6+puFdMuqGKixccO31uB3Aaalft4t3p+gEd0hrbuytlTy/Do7iRg85DthegFDkqH
	fFfLFe83tPHoBk+FXtElYWElgmH1UuRJ6+0HXgXP7oGeFtLJN2/gNiW195Nmc0vGFlBU9b
	QzCqJL9GCezqx8zg6+51GHipDh+m2ylRhQWvpZQHiMtscd7ig86R5An0nyusww==
Message-ID: <c2c4279ac5948b1debbe597eea1210fd667801f6.camel@mailbox.org>
Subject: Re: [PATCH 1/1] mm/damon: fix typos in comments
From: Manuel Ebner <manuelebner@mailbox.org>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>, SJ Park
 <sj@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 	ahuang12@lenovo.com
Date: Tue, 06 Oct 2026 10:38:38 +0200
In-Reply-To: <20260915102746.647-1-adrianhuang0701@gmail.com>
References: <20260915102746.647-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MBO-RS-ID: 4f7708e9e185bd138c8
X-MBO-RS-META: jfbsa4wbs98wgj5dz7dihncj5qdkb3ur

Hi Adrian,=C2=A0

On Tue, 2026-09-15 at 18:27 +0800, Adrian Huang (Lenovo) wrote:
> Correct spelling mistakes. No functional changes.
>=20
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
> =C2=A0mm/damon/core.c=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
> =C2=A0mm/damon/lru_sort.c | 2 +-

could you add this changes in this file?

DAMON_RCLAIM -> DAMON_RECLAIM
'set as' -> 'set to'

> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 0c98f7e267d0..981a153619c0 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -2447,7 +2447,7 @@ static bool damos_valid_target(struct damon_ctx *c,=
 struct damon_region *r,
> =C2=A0 * This function checks if a given region should be skipped or not =
for the
> =C2=A0 * reason.=C2=A0 If only the starting part of the region has previo=
usly charged,
> =C2=A0 * this function splits the region into two so that the second one =
covers the
> - * area that not charged in the previous charge widnow, and return true.=
=C2=A0 The
> + * area that not charged in the previous charge window, and return true.=
=C2=A0 The

Please make it 'area that is not charged'

Thanks
 Manuel=20

