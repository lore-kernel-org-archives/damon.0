Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D7238C1A
	for <damon@lists.linux.dev>; Mon, 21 Sep 2026 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789956258; cv=none; b=PhhYOZL6u+W+zIIV9ZGU+XVl0g5qlwXWf1QQPEULL/EGcfXjzkjyiYUP527uuTmtr696zCRXN7R/Vt1cq/2wUQm3UGf6e6/Z9wGXCfhOfCpEyxnaockfRC6wzbimDcJncE1o9L3BViHzjIE3IJ5aoUSxGqrqLMJcuZcZA8Od/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789956258; c=relaxed/simple;
	bh=0c2R5FPihUaOzEkmEQW6RI6SmGttUA3xsdI0FA8rMMM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4DeCkABrAf4EfXtuvZf21OyCxIMnCUfXQRSXDFCtFfX0JmmoBk+F6cwvJnuDSl/YB/moKgokPuwBRphjDT887Ywo3FwGaCQsx5msd+nfi34q1SVe9y+woLt6J9xNXZyC4e+ADI9v2lHKJYfMMzYEfBb6V1Tib0Y/enD7Mbfu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gv2ycCtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gv2ycCtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DA91F000FF;
	Mon, 21 Sep 2026 02:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789956256;
	bh=0c2R5FPihUaOzEkmEQW6RI6SmGttUA3xsdI0FA8rMMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gv2ycCtKpK48w7+RmP3P/U/1z5gqQ4Y9B3WPYJYglmSKkmEhgP6QrFftGYm9uzdW2
	 OZ2XJBVGY4dssWu8cOrF8WYKT0D8I/NZUZUTm8xqZuts5xGzmst/PtydZFvG88hbmn
	 TPoLmq2Hufn0NmFOpxhtL0rqDwDfT9Rl7KM/uH84I0fbWU8X+Yi9T8VMcRKDul/YxT
	 4wq3IeG07jUipsXHBLT740PYxncgtInSVnfLpMfaxpUWqGw8BRXTVafPlP1uWSlQOM
	 odLgBzAUQ/V0fi6JCXO8qqkPmfXbhFq0u/jKLOzqHXw9XJF01SqP7cfm7vN1J4noI/
	 b42qrnJQztJJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mm/damon/tests/core-kunit: test PSI goal values
 with explicit samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: damon@lists.linux.dev
In-Reply-To: <20260921020013.33105-3-kmehltretter@gmail.com>
References: <20260921020013.33105-1-kmehltretter@gmail.com>
 <20260921020013.33105-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 02:04:15 +0000
Message-Id: <20260921020416.77DA91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>

> Test the PSI current-value helper with explicit totals so the result does
> not depend on the test system's memory pressure. Cover an unmeasured
> consist goal, unmeasured temporal goals with zero and nonzero effective
> quotas, and measured rounds for both tuners. Check last_psi_total after
> each call.
>=20
> With the old unmeasured-round behavior retained in the helper, the
> temporal check with a nonzero effective quota fails.
>=20
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921020013.3310=
5-1-kmehltretter@gmail.com?part=3D2

