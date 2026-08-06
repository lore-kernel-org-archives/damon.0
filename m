Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548F33C188;
	Thu,  6 Aug 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785976449; cv=none; b=NxGfHPj5TJAhls8fvjSNrfj6EGyyVKgN2W5xw9NoTq8cz9mwaEnXKj3vcGBxuqR1WPtRbRYs90okCFYg5e/IzhCCokfmKIrpQ8oCGNjCaCh6RwldePxM+c2vzeBpV7B0bnT+miIV7kObf+SQJvLFht6M42ExVifDiIuDvaH/Yac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785976449; c=relaxed/simple;
	bh=USIXWXL4x2O3ifVRmp7wwKh/piGs5SNTLwuNb0Bofxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSYFcNzvdc8OHHz/lHANRxJhrpFn33sxEDk0TMc0X5Ln3N3FK6H/4UL3/Dp0RbXsQtoD462vhxamktntHLtb4xHo+vvw9WktKiZsaFrZFA1Z0oRTs/dO0m0xyMFLN26O1OfxbkH5DeDaaT5nciHtNqpppOyJ7vi5CyeD2g/csUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA1KLCQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA1KLCQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A571F000E9;
	Thu,  6 Aug 2026 00:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785976447;
	bh=vFBSpNps5ahNANzjK00DJStkD9Rlq2k2GdWcPT+1zyc=;
	h=From:To:Cc:Subject:Date;
	b=AA1KLCQ23cCUYOU9WN2LYr37LxbZyCKSDq06ew4AE4j+oMm2mse8DzqZvUHchvEAn
	 2OC0RVXWEteVFYqL4CouoOroazX2SVltqppx6DsVo304CCyqmJz9yyxs0XYji2RjT/
	 q+NTFp+vOIQR7ppt4PiemNlbpVa9/9tA7piXVLAUYcAzjfLJS8p4CBIeH3W/9hWudH
	 wLTZwq6mR4Y/g0P/qSGpfgs96KoHjJObraFiX0DNiq6DYg6sbIvNm7AJOiER1mJtlM
	 4YnTlHZZsxRZd3JPbQHLUQgiaTZ5/RLBSo1f18C63iuZpvIeCHF9Hs1UW1laKOoCLX
	 5tdQI8AdjqSSA==
From: SJ Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SJ Park <sj@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [CFP] DAMON Nanoconference (aka BoF) at LPC'26
Date: Wed,  5 Aug 2026 17:33:57 -0700
Message-ID: <20260806003357.92659-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello community,


We will have a DAMON BoF session [1] at LPC'26.  Because it is a BoF, I want to
make it as casual as possible with many voices.  Hence inviting you.  You could
think this as yet another version of our bi-weekly Beer/Coffee/Tea chat meeting
series [2], or the first Nano-sized DAMON conference.

If you have any topics about DAMON that you want to present and discuss in the
session, please send an email to me.

Example of topics include but not limited to:

- Your DAMON work that is recently landed, in progress/plan
- Your DAMON usage and success/failure stories

Depending on the topic and number of proposals, I will try to give each topic
5-15 minutes.


[1] https://lpc.events/event/20/contributions/2453/
[2] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGbZAH3mi2vpM/edit?usp=sharing


Thanks,
SJ
