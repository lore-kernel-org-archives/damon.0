Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B26286420;
	Wed, 13 Aug 2025 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106119; cv=none; b=PVh4YsvghGRMEuAHIpTqLuFqj2X/wujVUr3EdZi2EGmtdd9+u7NKrmaIzZ49LYt89eNI4UafXMsvEd0pwki3DzB/+zXfIpo/fn1KnuhlUmnRSAZQx9QRCU5VAH9fhd/UZptbZFNEZbIrWIOEkuxAeWl4YG1agEVCu0COWkNBfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106119; c=relaxed/simple;
	bh=0cgYvn5Ljx/oaqxoyW3chdgTsnV3nXNB0fX+rUyitBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CVzRSTsaqWpEbZyvN6a+KcyW7Kka9huZg/s1Q0uRHVXpRDDMKcaC/1J0Vpk0qXYeJswOEmPblpCmCxrMflx8f6cii7clgTtuNo0BEjsFqIAdjQjwiSubXz6HYg7LEELLotMe/JBl46kv9hqdQMbSxWZeDWsLhRzWoCRnW7q6o1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YodXG5bM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YodXG5bM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D2C4CEEB;
	Wed, 13 Aug 2025 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755106119;
	bh=0cgYvn5Ljx/oaqxoyW3chdgTsnV3nXNB0fX+rUyitBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YodXG5bM2fcZD/K6wAH7xEBEGAR6RYAmbyX1dkPyrf2NIbkx1R93CQDZLDPYW5lN7
	 3F52mhkNx3Aw+0X+LzU7d4wmz9QLalW+r06IUDYvDNf8HbD6EQOHU8tFSCBRcYywGw
	 OVRIYymL+TsMnKHqvm3qs0hInbm+VH2Wq36+18BC1QiCb5zaOXO2efrvRq9qzzBtmE
	 JJyURSeNnfKOxnJ3cWTM9S75rH3G2Vqhx0s0IrZXLVbO+2lEwud0nlor+awaBa2a0V
	 8FYPTVZXlPDoJcWsL5+gtrdt2XbHWdBmMpPOXksXbbh/bCuCfrF+lOnhCmfxsH12y1
	 8C0Df9i2iBIrw==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
Date: Wed, 13 Aug 2025 10:28:36 -0700
Message-Id: <20250813172836.6743-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813050706.1564229-1-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 13:06:50 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> Previously, DAMON's physical address space monitoring only supported
> memory ranges below 4GB on LPAE-enabled systems. This was due to
> the use of 'unsigned long' in 'struct damon_addr_range', which is
> 32-bit on ARM32 even with LPAE enabled.
> 
> Implements DAMON compatibility for ARM32 with LPAE enabled.
> 
> Patches 01/16 through 10/16 are from the mailing list[1], add a new core
> layer parameter called 'addr_unit'. Operations set layer can translate a
> core layer address to the real address by multiplying the parameter value
> to the core layer address.
> 
> Patches 11/16 through 14/16 extend and complement patches 01~10, addressing
> various issues introduced by the addr_unit implementation.
> 
> Patches 15/16 and 16/16 complete native DAMON support for 32-bit systems.
> 
> [1] https://lore.kernel.org/all/20250416042551.158131-1-sj@kernel.org/

It would be nice to add more history about this nice work here, with links.


Thanks,
SJ

[...]
