Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6D15AF6
	for <damon@lists.linux.dev>; Fri, 29 Nov 2024 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732910133; cv=none; b=tpPuKaJIPapjWPcMHIZ4Ah+IO2W5IlsJeTVN8nIbYxq+XicifRmDVtj/Df2p47hnLCGZGTldueepTF5fXIZJfbKCgU78t/hZ9rgendevvfwHktjP34u9DxvPRG/K0BDdPFrQQL7JnwyFB3i7XOReCLs/B8B0AtNbkOXif/Zb/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732910133; c=relaxed/simple;
	bh=ufXauqxp2yXYrcVMXESE+xb+2yTJSbdZ+9uhjZ/cEBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNNwMYLVKZGr7C9rUKtt8n3yfInVRuroLyrfF40l3q2zNuS+OilBleUQhVbSSKrqZh1cBcvZ1hv22CFCj+4rERiTkhg4+VECXb0yzJrMO4EcokF8XU3RlCcVQrRZggVhXdC3v6358RFKY2z0aMmsQZsKgF1HgAawAZNnYBqWz34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyXvnfPr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyXvnfPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57978C4CECF;
	Fri, 29 Nov 2024 19:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732910132;
	bh=ufXauqxp2yXYrcVMXESE+xb+2yTJSbdZ+9uhjZ/cEBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eyXvnfPrGKj8hyihbj6kW2nvhZIEbmKo7abYDoNQon9roeOhv4uYZyc0ce6so1w0f
	 hUa+4sZJAgqN1mUn7Pby6CcBdGIimVc3GogAm9JZTkgIrnt7nzEv6+e/qoGY1zIN12
	 qFsg2We4GxFrcWgKMyWXzeDHIWYQUySWt1RV0U0dcstBQ5zkcy4UwOP96zGTgaCh3m
	 2C7CzhK+dg0whP2C79IVkep0IIXyvsVkslN4uunO1o9IlbsH0NX1eKHr9TXKnwq+FQ
	 C2216lKOddL0Dr6TzziYoIMA+Nx9QNmc8Q7shKQM50HpcwxQOCuYF8o2jXjirVIxkn
	 UtABjAHp0vObA==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel_team@skhynix.com,
	Yunjeong Mun <yunjeong.mun@sk.com>
Subject: Re: [PATCH] mm/damon/core: accumulate applied size to quota->charged_sz
Date: Fri, 29 Nov 2024 11:55:29 -0800
Message-Id: <20241129195529.98532-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241129083102.1582-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 Nov 2024 17:31:01 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> While testing DAMOS_MIGRATE_COLD action, Yunjeong found that the
> quota->charged_sz is way less than actually migrated size.

You mean "more", not "less", right?

And, is it a problem for your use case?  Could you please share more details?

> 
> In damos_apply_scheme(), quota->charged_sz is used when checking whether
> the quota exceeds the effective size.  The current implementation
> accumulates the charged_sz with sz(region size), but many pages in the
> region might be discarded by DAMOS filters.
> 
> In order to make the quota calculation more accurate, charged_sz is
> better to be accumulated by the actually applied size, which is
> sz_applied in the code.

This is an intended behavior.  Quota is for making a limit of resource
consumption from DAMOS.  Trying a DAMOS action consumes some of the system
resource even if it was eventually filtered out or failed, so we charge those.

We can consider changes of the behaior depending on problems and use cases, but
it is unclear to me.  Could you please elaborate, as I requested above?


Thanks,
SJ

[...]
