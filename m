Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB342DCF58;
	Thu, 21 Aug 2025 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796775; cv=none; b=MtOvoul5w4CO+97rTY1qdSNYc8aqOKe5zwwbidKb4FlPpACe2yV5PJuQXHMCHZdbWrKjmCRs9Ikv9YN+86rKHvF8MWWqOu4CegEu7Ekh8etX49My+hk5uhn/PAVpxCU6Tlj1/sasVRmVrYAs4GEPQY1MdA1Psj5ArUlskCEXs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796775; c=relaxed/simple;
	bh=u36V95yWLge4MrLb1TEu7xiKJXaJ7fDEQmfbJlfHy3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ku7yZFsdiX4ikrNXwKAK5jPvWa+hMOrGF5WuOIyiWZqRRduxyCNAqikyTrMOveTMhQW1e+XVN331b905u8v2lIAZXMQWCkZ7H7H64FGgb1XR8yc2ifiTnabRgYLghBwDGAnKgpUNk9QujMYATmRuV8hbMWj6DDxrAhu/h6iDXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKfsxkDO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKfsxkDO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31E1C4CEEB;
	Thu, 21 Aug 2025 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796775;
	bh=u36V95yWLge4MrLb1TEu7xiKJXaJ7fDEQmfbJlfHy3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OKfsxkDOXEbw1fAQJ3E92dEXJNDCAm0hIau16dul8nxX4lCm4hSmheKoRIZB2ONL7
	 pxD1UA/R1AuQObNGu8s53ey9KmYwwhmZyta8YmXciJsuNnNxEK54/h2aNT+M2uzaG+
	 TDuKLH0/orm8rz+jDYtAMBz1pT1sEqqMTMWaHCsxUN2bZH9dwHwwvVM6KkW0cvMBMK
	 rI/NSamy/QThI5qVRCBInvBVRcC3IXmM0DEAWor025smmu3D+ch11U9icH7uzMHRPp
	 Z009nbBIsijjlHZ9uu2FJZyNI8dXMvj1sD2fyogCjED4VbzMV6ejNKDC5efp2CNEcc
	 edjJVcNVRpVOg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH 06/11] mm/damon/paddr: support addr_unit for DAMOS_STAT
Date: Thu, 21 Aug 2025 10:19:33 -0700
Message-Id: <20250821171933.82070-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821105159.2503894-7-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:51:54 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Add support of addr_unit for DAMOS_STAT action handling from the DAMOS
> operation implementation for the physical address space.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
