Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EAA3A9002;
	Tue, 18 Aug 2026 04:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028613; cv=none; b=WLnzDVoTXt66hrEFTESaWyK9e5M2WTUzIDGS1+xP6JtRT79y2Tw4h4D89P97TWAjj54/IvZ8l9NoazGxSo9XbI804Oxtl27JSiJowM5pu5x/GmmzDL1Rk188xXNSuG7S6p44LVNuMLROugGguR6PdGAitfot3R9xed8ci1as8t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028613; c=relaxed/simple;
	bh=DXL2QfjEO30rnlTZtiKz0oDX/nlL5myyhlpYFSWo7Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMKQpzWa8gor/ZKLFjAtaaEVaGvIcu7frfS9lyRZygpesfjPMBmQKxVmDTADVs4Qc7/VuD8Flz1uU5t/Xaa3Zha6Y8QO+rJ9tIMBIdq6qEJpUH7ENWQ41S5EAboSAN7P4BQIdy8slL3avxtzGaivunKvlgxMboxmJHw+03D6r/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7skpJ8C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7skpJ8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DA01F000E9;
	Tue, 18 Aug 2026 04:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787028610;
	bh=mtX13R1ypyiRL9Ftkla+zVGEDE/fgvp5SvpwPGOAv0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C7skpJ8CRdoWeL9Xpft+bSu1GIg7/8RxNkaxcxxIRGu2Kf62eO7InNqx07MbqjFR9
	 5KAKBLTvVJEG03u9nLWu29S2c60OvWmHrJibO7LtuKc8jr4W188jhsds8ho7n0Eg4G
	 ZH4zKHwzgMdCulh/BOUGUoCSOD6eYw8SaXJ/DBsfZ3NNE2M9/2vdCCNwHQMi0m9LcN
	 puHO42CT/syK5qF1qqfCGyY2mLdysSkLUSKHFbxpOCY369NspJe2Mek05XdKfe0YFv
	 l1zfucMx1Ry0u+6coch5pi9FBIGVns3t7tMxcT2RsEhxczIZJUv1tOMZqe3ut9bFow
	 LHXRsXN0a4M+A==
From: SJ Park <sj@kernel.org>
To: Jason Angelov <jasonangelov@ucla.edu>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/damon/core-kunit: test probe_hits handling at region split and merge
Date: Mon, 17 Aug 2026 21:50:02 -0700
Message-ID: <20260818045002.97073-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818034552.11975-2-jasonangelov@ucla.edu>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Aug 2026 03:45:51 +0000 Jason Angelov <jasonangelov@ucla.edu> wrote:

> damon_split_region_at() copies probe_hits[] and last_probe_hits[] to
> the new split region.
> damon_merge_two_regions() sets probe_hits[] to the size-weighted
> average of the merged regions.
> 
> Extend damon_test_split_at() and damon_test_merge_two() tests to
> cover those fields.

Thank you for adding these tests!

> 
> Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
