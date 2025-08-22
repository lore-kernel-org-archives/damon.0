Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAA1096F;
	Fri, 22 Aug 2025 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883174; cv=none; b=fg4S0hd8vGOdWou/MNNqc2o3bQcm16TWmV2sZKBewsHvZ/TXf9loYIm1fN7NGgWJAHOIFX3AbCffcIqnnBKK1BXIYsAGVdseqyqUyIWrAYj/N1IC7b0Ybm3zHPwI5c1day91KOjMUJCWxLy0b2lLefxaKQZDNKzWZeiU0DqhIHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883174; c=relaxed/simple;
	bh=2swlyeBT/bcwBSubBT1dYyvfKoicsRMLgw49qnxgwb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cua2kkf/Il+AIBe89WaE/6Q42ey7CzZZJT228N3KMKQzi02AvxHzyPqz27qEGsQZI+b+9N91zDMQxQKBZ73lmYu3T5yyUVoJyWO158ucOo7qJatIaAEgVdcLOsFyNSb5I7zM8d1/IGxrHC2hhGvjIz2UjUe5Pdd4lQJ9gaPG81c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G73CbZDC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G73CbZDC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1FDC4CEED;
	Fri, 22 Aug 2025 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755883174;
	bh=2swlyeBT/bcwBSubBT1dYyvfKoicsRMLgw49qnxgwb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G73CbZDCMKUrbLz74C9Z7C8zuSKg/AfoA8WMBWCumKR7Qv9T3vcqsQ7sVZ2hTBDeC
	 PmFOUcAJXDKQFxMWe+P2HbRHHvynJ8eWBYSr8+nRilaqVBK11MV/50QC7M2C0Fbboo
	 Yo8alWdAVccYKHphkxE+6r+lgp2noo6o/aIpcBQRPfoM3CVyL7qoFHVqdV9qNWbKoM
	 Ly3dF9X/Le8+Pi6Qwtg3Vc2Hh89FDwAIIOhbBB2ziZt+FOPkL+3jwm5uCIRGtXQQ2h
	 WfVVLNP+C0wwqXnFiTRL3P/zRmbYm29D3n6hOUSOat1QXoLJTjvQgk2rHczq5egcb8
	 Hv0HZPNXfSctQ==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 11/11] mm/damon: add damon_ctx->min_sz_region
Date: Fri, 22 Aug 2025 10:19:32 -0700
Message-Id: <20250822171932.53804-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822093420.2103803-12-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 17:34:19 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Adopting addr_unit would make DAMON_MINREGION 'addr_unit * 4096'
> bytes and cause data alignment issues[1].
> 
> Add damon_ctx->min_sz_region to change DAMON_MIN_REGION from a global
> macro value to per-context variable.
> 
> [1] https://lore.kernel.org/all/527714dd-0e33-43ab-bbbd-d89670ba79e7@huawei.com
> 
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
