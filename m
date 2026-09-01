Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15C1331EAB;
	Tue,  1 Sep 2026 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222324; cv=none; b=stn7oDDC8ed2rdA2mKy/qgPyWq0JtE4Nkxe1ImHE05KRFx1x6Xwi9PTsYiUX5ARwvcAlhdOX3ccvaH1AHbw0kZnCAib+2TAtTmh+CmwKj+2L2iSSTcc/gbJ34mVZpdSA0rVhkf9nQ7S+qjfbRBOnnFlr6n1ptXz6oPQy+0M7sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222324; c=relaxed/simple;
	bh=qd6gJjVLJqIODsjc5svs7fsHukTbDjVj4LwxMxvce6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXsdwyZGO3sQAr57N5r2fqbzkRwb1uLYqOSKIAY3rmzZ7DboRGBF1T1zZCNOTk43l0e8gAy6VOx4vMkol+XAX+HuWBLolu6BkKcd4HsyBuAVLsdN1nfEhZjFC1bPgnFKu9dZVBaSczTxy0PUdOCahDJpqHG6zyp/bL1NGXvjAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GodOCmuB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GodOCmuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223C71F000E9;
	Tue,  1 Sep 2026 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788222322;
	bh=olDDZe1kwamyYukq3MnZjHpBTxBriTDZT9fSNSnY2nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GodOCmuBtNBi7l6NKMfdpFBezCgwPKRhZWfY/xn+zes4cgaBwBPxNnlQF0lg6vRLs
	 lJXX3w2xA9LRITbSF7DMcQnkWGb1sqPxXgYP4c4z4+CnyePc/Gl/OeeUs2FHYOYOR8
	 ARmXikq8sNsMZw3e3xr+a9NZaSjF+Zp0vMpteJxsMI47M/9rfUe7pZbpR3iCe3YYIc
	 U3gNESGS7BT+AjnD8qhihkNgixvhVxeadJeFJCFf0RnxGk9IfyxX039t1Xde/ple+w
	 MslbhC7dAkBeL4B7rug5ujtfpd3RsBNeR6WhTL4lQo2RstRDLQe8DDhXBayeusyFUk
	 lOH9HOkEYLDFQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	sashiko-bot@kernel.org,
	damon@lists.linux.dev,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH] mm/damon/tests/core-kunit: add test for unconditionally skipping the last region
Date: Mon, 31 Aug 2026 17:25:14 -0700
Message-ID: <20260901002515.88585-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831122842.9091-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 31 Aug 2026 20:28:15 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Mon, 31 Aug 2026 11:50:14 +0000 sashiko-bot@kernel.org wrote:
[...] 
> > [Severity: Medium]
> > Does this patch omit the fix for the core logic?
> > 
> > Without an accompanying fix for damos_skip_charged_region() in
> > mm/damon/core.c, won't this new test unconditionally fail and break CI?
> > 
> > Because the underlying bug is not fixed in this patch, the old logic still
> > triggers and returns true when it processes the last region:
> > 
> > mm/damon/core.c:damos_skip_charged_region() {
> > 	...
> > 	if (quota->charge_target_from) {
> > 		if (t != quota->charge_target_from)
> > 			return true;
> > 		if (r == damon_last_region(t)) {
> > 			quota->charge_target_from = NULL;
> > 			quota->charge_addr_from = 0;
> > 			return true;
> > 		}
> > 	...
> > }
> 
> This test is add for [1].  Therefore, this patch can only be merged
> after [1] is merged.

Makes sense.

> 
> [1] https://lore.kernel.org/damon/20260830063159.6347-1-aethernet65535@gmail.com

I wonder if you are open to repost this after the dependent patch is merged
into mm-new.  It would be definitely inconvenient for you, but that would help
us getting AI review help.  What do you think?


Thanks,
SJ

[...]
